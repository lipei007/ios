//
//  LXYLockBoard.m
//  Lock
//
//  Created by emerys on 15/8/29.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "JKLockBoard.h"
#import "JKLockNode.h"

#define MARGIN 20
#define NUMBEROFNODE 9
#define NUMBEROFNODEINROW 3

@interface JKLockBoard ()

@property (nonatomic,strong) NSMutableArray *nodes;
@property (nonatomic,strong) NSMutableArray *selectedNodes;
@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) NSMutableArray *pointArray;
@property (nonatomic,strong) UIBezierPath *linePath;

@end

@implementation JKLockBoard


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.nodes = [NSMutableArray arrayWithCapacity:NUMBEROFNODE];
        self.selectedNodes = [NSMutableArray arrayWithCapacity:NUMBEROFNODE];
        self.linePath = [[UIBezierPath alloc] init];
        self.pointArray = [NSMutableArray array];
        self.lineLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.lineLayer];
        
        self.lineLayer.strokeColor = [UIColor blueColor].CGColor;
        self.lineLayer.fillColor = [UIColor clearColor].CGColor;
        self.lineLayer.lineWidth = 1.0f;

        CGFloat nodeWidth = (frame.size.width - MARGIN * 2) / (NUMBEROFNODEINROW * 2 - 1);
        CGFloat nodeHeight = nodeWidth;
        CGFloat nodeInterval = nodeWidth;
//        CGFloat verticalMargin = (frame.size.height - nodeHeight *
//                                  ((NUMBEROFNODE / NUMBEROFNODEINROW) * 2 - 1)) / 2.0;
        
        
        for (int i = 0; i < NUMBEROFNODE; i++) {
            int row = i / NUMBEROFNODEINROW;
            int col = i % NUMBEROFNODEINROW;
            
            CGFloat x = MARGIN + (nodeWidth + nodeInterval) * col;
//            CGFloat y = verticalMargin + (nodeHeight + nodeInterval) * row;
             CGFloat y = MARGIN + (nodeHeight + nodeInterval) * row;
            
            JKLockNode *node = [[JKLockNode alloc] initWithFrame:
                                 CGRectMake(x, y, nodeWidth, nodeHeight)];
            node.backgroundColor = [UIColor clearColor];
            node.tag = 500 + i;
            [self.nodes addObject:node];
            [self addSubview:node];
        }
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:panRecognizer];
    }
    return self;
}



#pragma mark 拖动手势的回调
-(void)pan:(UIPanGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:self];
    JKLockNode *node = [self nodeContainsPoint:point];
    if (recognizer.state == UIGestureRecognizerStateBegan) { // 手指刚按下
        if (node) {
//            [self addPoint:node.center inNode:node];
//            [self addSelectedNode:node];
            [self addPoint:node.center withSelectedNode:node];
            self.status = JKLockBoardStatusSelected;
        }
    }else{ // 手指move
        if(self.status == JKLockBoardStatusSelected){
            if(!node){
                if (self.selectedNodes.count > 0) {
//                    [self addPoint:point inNode:nil];
                    [self addPoint:point withSelectedNode:nil];
                }
            }else{
//                [self addPoint:node.center inNode:node];
//                [self addSelectedNode:node];
                [self addPoint:node.center withSelectedNode:node];
            }

        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) { // 手指抬起,结束
        CGPoint lastPoint = [[self.pointArray lastObject] CGPointValue];
        if (![self nodeContainsPoint:lastPoint]) {
            [self.pointArray removeLastObject];
        }
        // 此处要做的是保存密码或者验证密码正确性
        NSMutableString *password = [NSMutableString string];
        for (JKLockNode *node in self.selectedNodes) {
            [password appendString:[@(node.tag - 500) stringValue]];
        }
        self.status = [self.delegate handlePassWord:password];
        [self performSelector:@selector(setNormalStatus) withObject:nil afterDelay:0.5f];
    }
    [self drawLine];
   
}

//
-(void)addPoint:(CGPoint)point withSelectedNode:(JKLockNode *)node{
    [self addPoint:point inNode:node];
    if (node) {
        [self addSelectedNode:node];
    }
}

// 将选中的节点添加到选中节点的数组中,若节点已经添加过则不添加
-(BOOL)addSelectedNode:(JKLockNode *)node{
    BOOL flag = NO;
    if (![self.selectedNodes containsObject:node]) {
        node.status = JKLockNodeStatusSelected;
        [self.selectedNodes addObject:node];
        flag = YES;
    }
    return flag;
}

// 将点添加进数组
-(void)addPoint:(CGPoint)point inNode:(JKLockNode*)node{

    if (self.pointArray.count > 1) {
        CGPoint tmpPoint = [[self.pointArray lastObject] CGPointValue];
        if (![self nodeContainsPoint:tmpPoint]) {
            [self.pointArray removeLastObject];
        }
    }
//    [self.pointArray addObject:[NSValue valueWithCGPoint:point]];
    // 若点所在的节点被添加了,意味着点也被添加了,那么就不用添加;点不在节点中,那么照样添加
    if (!node) {
        [self.pointArray addObject:[NSValue valueWithCGPoint:point]];
    }else{
        if (![self.selectedNodes containsObject:node]) {
            [self.pointArray addObject:[NSValue valueWithCGPoint:point]];
        }
    }
    
}

//
-(void)drawLine{
    [self.linePath removeAllPoints];
    if (self.pointArray.count > 0) {
        [self.linePath moveToPoint:[(NSValue *)[self.pointArray firstObject] CGPointValue]];
        for (int i = 1; i < self.pointArray.count; i++) {
            [self.linePath addLineToPoint:[(NSValue *)[self.pointArray objectAtIndex:i] CGPointValue]];
        }
        
        self.lineLayer.path = self.linePath.CGPath;
    }else{
        self.lineLayer.path = NULL;
    }
    [self.layer setNeedsDisplay];
}

// 返回point所在的node
-(JKLockNode *)nodeContainsPoint:(CGPoint)point{
    JKLockNode *result = nil;
    for (JKLockNode *node in self.subviews) {
        if(CGRectContainsPoint(node.frame, point)){
            result = node;
            break;
        }
    }
    return result;
}

// 设置为正常状态
-(void)setNormalStatus{
    for (JKLockNode *node in self.selectedNodes) {
        node.status = JKLockNodeStatusNormal;
        
    }
    [self.selectedNodes removeAllObjects];
    [self.pointArray removeAllObjects];
    [self drawLine];
}

// 设置个为设置密码的状态
-(void)setSelectedStatus{
    for (JKLockNode *node in self.selectedNodes) {
        node.status = JKLockNodeStatusSelected;
    }
    self.lineLayer.strokeColor = [UIColor blueColor].CGColor;
    [self drawLine];
}
// 设置为出错状态
-(void)setWarningStatus{
    for (JKLockNode *node in self.selectedNodes) {
        node.status = JKLockNodeStatusWarning;
    }
    self.lineLayer.strokeColor = [UIColor redColor].CGColor;
    [self drawLine];
}

-(void)setStatus:(JKLockBoardStatus)status{
    _status = status;
    switch (_status) {
        case JKLockBoardStatusNormal:
            [self setNormalStatus];
            break;
        case JKLockBoardStatusSelected:
            [self setSelectedStatus];
            break;
        case JKLockBoardStatusWarning:
            [self setWarningStatus];
            break;
        default:
            break;
    }
    
}

@end

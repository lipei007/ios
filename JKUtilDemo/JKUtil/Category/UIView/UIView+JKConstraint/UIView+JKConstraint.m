//
//  UIView+JKConstraint.m
//  Constraint
//
//  Created by Jack on 2018/12/10.
//  Copyright © 2018年 Jack Template. All rights reserved.
//

#import "UIView+JKConstraint.h"
#import <objc/runtime.h>

#pragma mark - Constraint

@interface JKConstraint ()

@property (nonatomic,weak) id appliedView;
@property (nonatomic,weak) NSLayoutConstraint *constraint;
@property (nonatomic,assign) UILayoutPriority priority;
@property (nonatomic,assign) BOOL validate;
@property (nonatomic,copy) NSString *identifier;

@property (nonatomic,assign) NSLayoutAttribute attribute;
@property (nonatomic,assign) NSLayoutRelation relation;
@property (nonatomic,weak) UIView *toView;
@property (nonatomic,assign) NSLayoutAttribute toAttribute;
@property (nonatomic,assign) CGFloat constant;

@property (nonatomic,copy) JKConstraint *(^jk_p_offset)(CGFloat offset);
@property (nonatomic,copy) JKConstraint *(^jk_p_lessThanOrEqualTo)(JKConstraint *constraint);
@property (nonatomic,copy) JKConstraint *(^jk_p_equalTo)(JKConstraint *constraint);
@property (nonatomic,copy) JKConstraint *(^jk_p_greaterThanOrEqualTo)(JKConstraint *constraint);
@property (nonatomic,copy) JKConstraint *(^jk_p_priority)(UILayoutPriority prioruty);

@property (nonatomic,strong) NSMutableDictionary<NSString *,JKConstraint *> *appendConstraints;
@property (nonatomic,copy) JKConstraint *(^jk_p_append)(NSString *identifier);
@property (nonatomic,copy) JKConstraint *(^jk_p_size_greaterThanOrEqualTo)(CGFloat size);
@property (nonatomic,copy) JKConstraint *(^jk_p_size_lessThanOrEqualTo)(CGFloat size);

@property (nonatomic,copy) void (^jk_p_modify)(CGFloat constant);

@end

@implementation JKConstraint

- (instancetype)init {
    if (self = [super init]) {
        
        _attribute = NSLayoutAttributeNotAnAttribute;
        _relation = NSLayoutRelationEqual;
        _toAttribute = NSLayoutAttributeNotAnAttribute;
        _priority = UILayoutPriorityDefaultHigh;
        
        __weak typeof(self) weakSelf = self;
        self.jk_p_offset = [^JKConstraint *(CGFloat offset) {
            
            weakSelf.validate = YES;
            weakSelf.constant = offset;
            return weakSelf;
        } copy];
        
        self.jk_p_lessThanOrEqualTo = [^JKConstraint *(JKConstraint *constraint) {
            
            weakSelf.validate = YES;
            weakSelf.toView = constraint.appliedView;
            weakSelf.relation = NSLayoutRelationLessThanOrEqual;
            weakSelf.toAttribute = constraint.attribute;
            
            return weakSelf;
        } copy];
        
        self.jk_p_equalTo = [^JKConstraint *(JKConstraint *constraint) {
            
            weakSelf.validate = YES;
            weakSelf.toView = constraint.appliedView;
            weakSelf.relation = NSLayoutRelationEqual;
            weakSelf.toAttribute = constraint.attribute;
            
            return weakSelf;
        } copy];
        
        self.jk_p_greaterThanOrEqualTo = [^JKConstraint *(JKConstraint *constraint) {
            
            weakSelf.validate = YES;
            weakSelf.toView = constraint.appliedView;
            weakSelf.relation = NSLayoutRelationGreaterThanOrEqual;
            weakSelf.toAttribute = constraint.attribute;
            
            return weakSelf;
        } copy];
        
        self.jk_p_priority = [^JKConstraint *(UILayoutPriority priority) {
           
            weakSelf.priority = priority;
            
            return weakSelf;
        } copy];
        
        self.jk_p_append = [^JKConstraint *(NSString *identifier) {
            
            if (!identifier) {
                return nil;
            }
            
            if (weakSelf.appendConstraints[identifier]) {
                return weakSelf.appendConstraints[identifier];
            }
            
            JKConstraint *constraint = [JKConstraint new];
            constraint.appliedView = weakSelf.appliedView;
            constraint.attribute = weakSelf.attribute;
            
            weakSelf.appendConstraints[identifier] = constraint;
            
            return constraint;
            
        } copy];
        
        self.jk_p_size_lessThanOrEqualTo = [^JKConstraint *(CGFloat size) {
            
            if (weakSelf.attribute != NSLayoutAttributeWidth && weakSelf.attribute != NSLayoutAttributeHeight) {
                return weakSelf;
            }
            
            weakSelf.validate = YES;
            weakSelf.toView = nil;
            weakSelf.relation = NSLayoutRelationLessThanOrEqual;
            weakSelf.toAttribute = NSLayoutAttributeNotAnAttribute;
            weakSelf.jk_offset(size);
            
            return weakSelf;
        } copy];
        
        self.jk_p_size_greaterThanOrEqualTo = [^JKConstraint *(CGFloat size) {
            
            if (weakSelf.attribute != NSLayoutAttributeWidth && weakSelf.attribute != NSLayoutAttributeHeight) {
                return weakSelf;
            }
            
            weakSelf.validate = YES;
            weakSelf.toView = nil;
            weakSelf.relation = NSLayoutRelationGreaterThanOrEqual;
            weakSelf.toAttribute = NSLayoutAttributeNotAnAttribute;
            weakSelf.jk_offset(size);
            
            return weakSelf;
        } copy];
        
        self.jk_p_modify = [^(CGFloat constant) {
            
            weakSelf.constant = constant;
            if (weakSelf.constraint) {
                weakSelf.constraint.constant = constant;
                if ([weakSelf appliedViewIsView]) {
                    UIView *appliedView = ((UIView *)weakSelf.appliedView);
                    [appliedView.superview layoutIfNeeded];
                }
            }
            
        } copy];
    }
    return self;
}

- (JKConstraint *(^)(CGFloat))jk_offset {
    return self.jk_p_offset;
}

- (JKConstraint *(^)(JKConstraint *))jk_lessThanOrEqualTo {
    return self.jk_p_lessThanOrEqualTo;
}

- (JKConstraint *(^)(JKConstraint *))jk_equalTo {
    return self.jk_p_equalTo;
}

- (JKConstraint *(^)(JKConstraint *))jk_greaterThanOrEqualTo {
    return self.jk_p_greaterThanOrEqualTo;
}

- (JKConstraint *(^)(UILayoutPriority))jk_priority {
    return self.jk_p_priority;
}

- (JKConstraint *(^)(NSString *))jk_append {
    return self.jk_p_append;
}

- (JKConstraint *(^)(CGFloat))jk_size_lessThanOrEqualTo {
    return self.jk_p_size_lessThanOrEqualTo;
}

- (JKConstraint *(^)(CGFloat))jk_size_greaterThanOrEqualTo {
    return self.jk_p_size_greaterThanOrEqualTo;
}

- (void (^)(CGFloat))jk_modify {
    return self.jk_p_modify;
}

- (void)jk_uninstall {
    
    if (self.appliedView && self.appliedViewIsView && self.validate && self.constraint) {
        
        UIView *appliedView = ((UIView *)self.appliedView);
        if ((self.attribute == NSLayoutAttributeWidth || self.attribute == NSLayoutAttributeHeight) && !self.toView) {
            
            [appliedView removeConstraint:self.constraint];
        } else {
            
            [appliedView.superview removeConstraint:self.constraint];
        }
    }
    
    [self.appendConstraints enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, JKConstraint * _Nonnull obj, BOOL * _Nonnull stop) {
       
        [obj jk_uninstall];
    }];
    
    self.validate = NO;
    self.constraint = nil;
    self.identifier = nil;
    
    self.toView = nil;
    self.relation = NSLayoutRelationEqual;
    self.toAttribute = NSLayoutAttributeNotAnAttribute;
    self.constant = 0;
    self.priority = UILayoutPriorityDefaultHigh;
    
    [self.appendConstraints removeAllObjects];
}

- (void)jk_install {
    
    if (self.appliedView && self.appliedViewIsView && self.validate && !self.constraint) {
        
        UIView *appliedView = ((UIView *)self.appliedView);
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:appliedView
                                                                      attribute:self.attribute
                                                                      relatedBy:self.relation
                                                                         toItem:self.toView
                                                                      attribute:self.toAttribute
                                                                     multiplier:1
                                                                       constant:self.constant];
        self.constraint = constraint;
        self.constraint.priority = self.priority;
        self.constraint.identifier = self.identifier;
        
        if ((self.attribute == NSLayoutAttributeWidth || self.attribute == NSLayoutAttributeHeight) && !self.toView) {
            [appliedView addConstraint:self.constraint];
        } else{
            [appliedView.superview addConstraint:self.constraint];
        }
    }
    
    [self.appendConstraints enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, JKConstraint * _Nonnull obj, BOOL * _Nonnull stop) {
        
        [obj jk_install];
    }];
}

- (NSMutableDictionary *)appendConstraints {
    if (!_appendConstraints) {
        _appendConstraints = [NSMutableDictionary dictionary];
    }
    return _appendConstraints;
}

- (BOOL)appliedViewIsView {
    BOOL isView = [self.appliedView isKindOfClass:[UIView class]];
    return isView;
}

@end

#pragma mark - Maker

@interface JKConstraintMaker ()

@property (nonatomic,weak) UIView *appliedView;

@property (nonatomic,strong) JKConstraint *left;
@property (nonatomic,strong) JKConstraint *top;
@property (nonatomic,strong) JKConstraint *right;
@property (nonatomic,strong) JKConstraint *bottom;
@property (nonatomic,strong) JKConstraint *centerX;
@property (nonatomic,strong) JKConstraint *centerY;
@property (nonatomic,strong) JKConstraint *baseLine;
@property (nonatomic,strong) JKConstraint *width;
@property (nonatomic,strong) JKConstraint *height;

@property (nonatomic,strong) JKConstraint *jk_safeAreaLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong) JKConstraint *jk_safeAreaTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong) JKConstraint *jk_safeAreaRight API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong) JKConstraint *jk_safeAreaBottom API_AVAILABLE(ios(11.0),tvos(11.0));

@property (nonatomic,strong) NSMutableArray<JKConstraint *> *constraints;

@property (nonatomic,copy) void (^jk_modifyConstraint)(NSString *identifier, CGFloat constant);

@end

static const UILayoutPriority kJKLayoutPriorityNone = -1;

@implementation JKConstraintMaker

- (instancetype)initWithAppliedView:(UIView *)view {
    if (self = [super init]) {
        self.appliedView = view;
        [self.constraints addObjectsFromArray:@[
                                                self.left,
                                                self.top,
                                                self.right,
                                                self.bottom,
                                                self.centerX,
                                                self.centerY,
                                                self.baseLine,
                                                self.width,
                                                self.height
                                                ]];
        
        self.jk_horizontalHuggingPriority = kJKLayoutPriorityNone;
        self.jk_verticalHuggingPriority = kJKLayoutPriorityNone;
        
        self.jk_horizontalCompressionResistancePriority = kJKLayoutPriorityNone;
        self.jk_verticalCompressionResistancePriority = kJKLayoutPriorityNone;
        
        __weak typeof(self) weakSelf = self;
        self.jk_modifyConstraint = [^(NSString *identifier, CGFloat constant) {
            
            NSDictionary *constraintRes = [weakSelf findConstraintOfView:weakSelf.appliedView byIdentifier:identifier];
            if (constraintRes) {
                
                UIView *view = constraintRes[@"view"];
                NSLayoutConstraint *constraint = constraintRes[@"constraint"];
                
                constraint.constant = constant;
                [view layoutIfNeeded];
            }
            
        } copy];
    }
    return self;
}

- (NSDictionary *)findConstraintOfView:(UIView *)view byIdentifier:(NSString *)identifier {
    if (!view || !identifier) {
        return nil;
    }
    NSLayoutConstraint *result = nil;
    
    NSArray<NSLayoutConstraint *> *constraintArray = view.constraints;
    for (NSLayoutConstraint *constraint in constraintArray) {
        if (constraint.identifier && [constraint.identifier isEqualToString:identifier]) {
            result = constraint;
            break;
        }
    }
    if (result) {
        return @{
                 @"view" : view,
                 @"constraint" : result
                 };
    } else {
        if (view.superview) {
            return [self findConstraintOfView:view.superview byIdentifier:identifier];
        } else {
            return nil;
        }
    }
}

- (NSMutableArray<JKConstraint *> *)constraints {
    if (!_constraints) {
        _constraints = [NSMutableArray array];
    }
    return _constraints;
}

- (JKConstraint *)left {
    if (!_left) {
        _left = [JKConstraint new];
        _left.attribute = NSLayoutAttributeLeft;
        _left.appliedView = self.appliedView;
    }
    return _left;
}

- (JKConstraint *)top {
    if (!_top) {
        _top = [JKConstraint new];
        _top.attribute = NSLayoutAttributeTop;
        _top.appliedView = self.appliedView;
    }
    return _top;
}

- (JKConstraint *)right {
    if (!_right) {
        _right = [JKConstraint new];
        _right.attribute = NSLayoutAttributeRight;
        _right.appliedView = self.appliedView;
    }
    return _right;
}

- (JKConstraint *)bottom {
    if (!_bottom) {
        _bottom = [JKConstraint new];
        _bottom.attribute = NSLayoutAttributeBottom;
        _bottom.appliedView = self.appliedView;
    }
    return _bottom;
}

- (JKConstraint *)centerX {
    if (!_centerX) {
        _centerX = [JKConstraint new];
        _centerX.attribute = NSLayoutAttributeCenterX;
        _centerX.appliedView = self.appliedView;
    }
    return _centerX;
}

- (JKConstraint *)centerY {
    if (!_centerY) {
        _centerY = [JKConstraint new];
        _centerY.attribute = NSLayoutAttributeCenterY;
        _centerY.appliedView = self.appliedView;
    }
    return _centerY;
}

- (JKConstraint *)baseLine {
    if (!_baseLine) {
        _baseLine = [JKConstraint new];
        _baseLine.attribute = NSLayoutAttributeBaseline;
        _baseLine.appliedView = self.appliedView;
    }
    return _baseLine;
}

- (JKConstraint *)width {
    if (!_width) {
        _width = [JKConstraint new];
        _width.attribute = NSLayoutAttributeWidth;
        _width.appliedView = self.appliedView;
    }
    return _width;
}

- (JKConstraint *)height {
    if (!_height) {
        _height = [JKConstraint new];
        _height.attribute = NSLayoutAttributeHeight;
        _height.appliedView = self.appliedView;
    }
    return _height;
}

// safe area

- (JKConstraint *)jk_safeAreaLeft {
    if (!_jk_safeAreaLeft) {
        _jk_safeAreaLeft = [JKConstraint new];
        _jk_safeAreaLeft.attribute = NSLayoutAttributeLeft;
        _jk_safeAreaLeft.appliedView = self.appliedView.safeAreaLayoutGuide;
    }
    return _jk_safeAreaLeft;
}

- (JKConstraint *)jk_safeAreaTop {
    if (!_jk_safeAreaTop) {
        _jk_safeAreaTop = [JKConstraint new];
        _jk_safeAreaTop.attribute = NSLayoutAttributeTop;
        _jk_safeAreaTop.appliedView = self.appliedView.safeAreaLayoutGuide;
    }
    return _jk_safeAreaTop;
}

- (JKConstraint *)jk_safeAreaRight {
    if (!_jk_safeAreaRight) {
        _jk_safeAreaRight = [JKConstraint new];
        _jk_safeAreaRight.attribute = NSLayoutAttributeRight;
        _jk_safeAreaRight.appliedView = self.appliedView.safeAreaLayoutGuide;
    }
    return _jk_safeAreaRight;
}

- (JKConstraint *)jk_safeAreaBottom {
    if (!_jk_safeAreaBottom) {
        _jk_safeAreaBottom = [JKConstraint new];
        _jk_safeAreaBottom.attribute = NSLayoutAttributeBottom;
        _jk_safeAreaBottom.appliedView = self.appliedView.safeAreaLayoutGuide;
    }
    return _jk_safeAreaBottom;
}

- (void)jk_install {
    if (self.appliedView) {
        
        // 抗拉伸
        if (self.jk_horizontalHuggingPriority != kJKLayoutPriorityNone) {
            [self.appliedView setContentHuggingPriority:self.jk_horizontalHuggingPriority forAxis:UILayoutConstraintAxisHorizontal];
        }
        
        if (self.jk_verticalHuggingPriority != kJKLayoutPriorityNone) {
            [self.appliedView setContentHuggingPriority:self.jk_verticalHuggingPriority forAxis:UILayoutConstraintAxisVertical];
        }
        
        // 抗压缩
        if (self.jk_horizontalCompressionResistancePriority != kJKLayoutPriorityNone) {
            [self.appliedView setContentCompressionResistancePriority:self.jk_horizontalCompressionResistancePriority forAxis:UILayoutConstraintAxisHorizontal];
        }
        
        if (self.jk_verticalCompressionResistancePriority != kJKLayoutPriorityNone) {
            [self.appliedView setContentCompressionResistancePriority:self.jk_verticalCompressionResistancePriority forAxis:UILayoutConstraintAxisVertical];
        }
        
        // normal constraint
        for (JKConstraint *constraint in self.constraints) {
            [constraint jk_install];
        }
    }
}

- (void)jk_uninstall {
    
    if (self.appliedView) {
        
        for (JKConstraint *constraint in self.constraints) {
            [constraint jk_uninstall];
        }
    }
}

@end

#pragma mark - UIView

static const char JKMaker = '\a';

@implementation UIView (JKConstraint)

- (void)setJK_Maker:(JKConstraintMaker *)maker {
    
    if (maker) {
        objc_setAssociatedObject(self, &JKMaker, maker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (JKConstraintMaker *)JK_Maker {
    JKConstraintMaker *maker = objc_getAssociatedObject(self, &JKMaker);
    if (maker == nil) {
        maker = [[JKConstraintMaker alloc] initWithAppliedView:self];
        [self setJK_Maker:maker];
    }
    return maker;
}

- (void)jk_applyConstraints:(void(^)(JKConstraintMaker *maker))apply {
    if (self.superview) {
        self.superview.translatesAutoresizingMaskIntoConstraints = NO;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        JKConstraintMaker *maker = [self JK_Maker];
        if (apply) {
            apply(maker);
        }
        
        [self applyMaker:maker];
    }
}

- (void)applyMaker:(JKConstraintMaker *)maker {
    
    if (maker) {
        [self setJK_Maker:maker];
        [maker jk_install];
        
        [self.superview layoutIfNeeded];
    }
}

- (void)jk_remakeConstraints:(void(^)(JKConstraintMaker *maker))remake {
    
    [[self JK_Maker] jk_uninstall];
    
    [self jk_applyConstraints:remake];
}

#pragma mark - P

- (JKConstraint *)left {
    return [self JK_Maker].left;
}

- (JKConstraint *)top {
    return [self JK_Maker].top;
}

- (JKConstraint *)right {
    return [self JK_Maker].right;
}

- (JKConstraint *)bottom {
    return [self JK_Maker].bottom;
}

- (JKConstraint *)centerX {
    return [self JK_Maker].centerX;
}

- (JKConstraint *)centerY {
    return [self JK_Maker].centerY;
}

- (JKConstraint *)baseLine {
    return [self JK_Maker].baseLine;
}

- (JKConstraint *)width {
    return [self JK_Maker].width;
}

- (JKConstraint *)height {
    return [self JK_Maker].height;
}

// safe area

- (JKConstraint *)jk_safeAreaLeft {
    return [self JK_Maker].jk_safeAreaLeft;
}

- (JKConstraint *)jk_safeAreaTop {
    return [self JK_Maker].jk_safeAreaTop;
}

- (JKConstraint *)jk_safeAreaRight {
    return [self JK_Maker].jk_safeAreaRight;
}

- (JKConstraint *)jk_safeAreaBottom {
    return [self JK_Maker].jk_safeAreaBottom;
}

// modify

- (void (^)(NSString *, CGFloat))jk_modifyConstraint {
    return [self JK_Maker].jk_modifyConstraint;
}

@end

#pragma mark - View Controller

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation UIViewController (JKConstraint)

- (JKConstraint *)jk_topLayoutGuid {
    
    JKConstraint *constraint = [JKConstraint new];
    constraint.attribute = NSLayoutAttributeBottom;
    constraint.appliedView = self.topLayoutGuide;
    return constraint;
}

- (JKConstraint *)jk_topLayoutGuidTop {
    
    JKConstraint *constraint = [JKConstraint new];
    constraint.attribute = NSLayoutAttributeTop;
    constraint.appliedView = self.topLayoutGuide;
    return constraint;
}

- (JKConstraint *)jk_topLayoutGuidBottom {
    
    JKConstraint *constraint = [JKConstraint new];
    constraint.attribute = NSLayoutAttributeBottom;
    constraint.appliedView = self.topLayoutGuide;
    return constraint;
}

- (JKConstraint *)jk_bottomLayoutGuid {
    
    JKConstraint *constraint = [JKConstraint new];
    constraint.attribute = NSLayoutAttributeTop;
    constraint.appliedView = self.bottomLayoutGuide;
    return constraint;
}

- (JKConstraint *)jk_bottomLayoutGuidTop {
    JKConstraint *constraint = [JKConstraint new];
    constraint.attribute = NSLayoutAttributeTop;
    constraint.appliedView = self.bottomLayoutGuide;
    return constraint;
}

- (JKConstraint *)jk_bottomLayoutGuidBottom {
    JKConstraint *constraint = [JKConstraint new];
    constraint.attribute = NSLayoutAttributeBottom;
    constraint.appliedView = self.bottomLayoutGuide;
    return constraint;
}

#pragma clang diagnostic pop

@end

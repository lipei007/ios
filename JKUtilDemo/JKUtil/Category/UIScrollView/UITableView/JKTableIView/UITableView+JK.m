//
//  UITableView+JK.m
//  chemistry2048
//
//  Created by emerys on 16/3/31.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "UITableView+JK.h"

@implementation UITableView (JKCell)

-(void)jk_registerCellWithClass:(Class)cellClass{
    NSString *identifier = NSStringFromClass(cellClass);
    [self registerClass:cellClass forCellReuseIdentifier:identifier];
}

-(void)jk_registerHeaderFooterViewWithClass:(Class)headerFooterViewClass{
    NSString *identifier = NSStringFromClass(headerFooterViewClass);
    [self registerClass:headerFooterViewClass forCellReuseIdentifier:identifier];
}

-(nullable __kindof UITableViewCell *)jk_dequeueReusableCellWithClass:(Class)cls{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cls)];
}

-(nullable __kindof UITableViewHeaderFooterView *)jk_dequeueReusableHeaderFooterViewWithClass:(Class)cls{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(cls)];
}

@end

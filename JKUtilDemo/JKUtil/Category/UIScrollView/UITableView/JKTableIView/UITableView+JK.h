//
//  UITableView+JK.h
//  chemistry2048
//
//  Created by emerys on 16/3/31.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  @author Jack Lee, 16-03-31 14:03:50
 *
 *  @brief cell
 */
@interface UITableView (JKCell)

/**
 *  @author Jack Lee, 16-03-31 14:03:56
 *
 *  @brief 注册一个cell，identifier为其类名
 *
 *  @param cellClass cell类
 */
-(void)jk_registerCellWithClass:(Class)cellClass;
/**
 *  @author Jack Lee, 16-03-31 14:03:31
 *
 *  @brief 根据identifier取出一个cell
 *
 *  @param identifier 识别器
 *
 *  @return tableViewcell
 */
-(nullable __kindof UITableViewCell *)jk_dequeueReusableCellWithClass:(Class)cls;
/**
 *  @author Jack Lee, 16-03-31 14:03:35
 *
 *  @brief 注册headerView／footerView
 *
 *  @param headerFooterViewClass headerView／footerView类名
 */
-(void)jk_registerHeaderFooterViewWithClass:(Class)headerFooterViewClass;
/**
 *  @author Jack Lee, 16-03-31 14:03:23
 *
 *  @brief 根据identifier取出headerView／footerView
 *
 *  @param identifier 识别器
 *
 *  @return headerView／footerView
 */
-(nullable __kindof UITableViewHeaderFooterView *)jk_dequeueReusableHeaderFooterViewWithClass:(Class)cls;

NS_ASSUME_NONNULL_END

@end

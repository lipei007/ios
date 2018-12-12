//
//  UIView+JKConstraint.h
//  Constraint
//
//  Created by Jack on 2018/12/10.
//  Copyright © 2018年 Jack Template. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKConstraint : NSObject

@property (nonatomic,readonly,copy) JKConstraint *(^jk_offset)(CGFloat offset);
@property (nonatomic,readonly,copy) JKConstraint *(^jk_lessThanOrEqualTo)(JKConstraint *constraint);
@property (nonatomic,readonly,copy) JKConstraint *(^jk_equalTo)(JKConstraint *constraint);
@property (nonatomic,readonly,copy) JKConstraint *(^jk_greaterThanOrEqualTo)(JKConstraint *constraint);
@property (nonatomic,readonly,copy) JKConstraint *(^jk_priority)(UILayoutPriority priority);

@property (nonatomic,readonly,copy) JKConstraint *(^jk_append)(NSString *identifier);
@property (nonatomic,copy) JKConstraint *(^jk_size_greaterThanOrEqualTo)(CGFloat size);
@property (nonatomic,copy) JKConstraint *(^jk_size_lessThanOrEqualTo)(CGFloat size);

@end

#pragma mark - Maker

@interface JKConstraintMaker : NSObject

@property (nonatomic,strong,readonly) JKConstraint *left;
@property (nonatomic,strong,readonly) JKConstraint *top;
@property (nonatomic,strong,readonly) JKConstraint *right;
@property (nonatomic,strong,readonly) JKConstraint *bottom;
@property (nonatomic,strong,readonly) JKConstraint *centerX;
@property (nonatomic,strong,readonly) JKConstraint *centerY;
@property (nonatomic,strong,readonly) JKConstraint *baseLine;
@property (nonatomic,strong,readonly) JKConstraint *width;
@property (nonatomic,strong,readonly) JKConstraint *height;

@property (nonatomic,strong,readonly) JKConstraint *jk_safeAreaLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong,readonly) JKConstraint *jk_safeAreaTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong,readonly) JKConstraint *jk_safeAreaRight API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong,readonly) JKConstraint *jk_safeAreaBottom API_AVAILABLE(ios(11.0),tvos(11.0));

@end

#pragma mark - UIView

@interface UIView (JKConstraint)

@property (nonatomic,strong,readonly) JKConstraint *left;
@property (nonatomic,strong,readonly) JKConstraint *top;
@property (nonatomic,strong,readonly) JKConstraint *right;
@property (nonatomic,strong,readonly) JKConstraint *bottom;
@property (nonatomic,strong,readonly) JKConstraint *centerX;
@property (nonatomic,strong,readonly) JKConstraint *centerY;
@property (nonatomic,strong,readonly) JKConstraint *baseLine;
@property (nonatomic,strong,readonly) JKConstraint *width;
@property (nonatomic,strong,readonly) JKConstraint *height;

@property (nonatomic,strong,readonly) JKConstraint *jk_safeAreaLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong,readonly) JKConstraint *jk_safeAreaTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong,readonly) JKConstraint *jk_safeAreaRight API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic,strong,readonly) JKConstraint *jk_safeAreaBottom API_AVAILABLE(ios(11.0),tvos(11.0));

- (void)jk_applyConstraints:(void(^)(JKConstraintMaker *maker))apply;

/**
 * it will remove all of its constraints before installing them again.
 */
- (void)jk_remakeConstraints:(void(^)(JKConstraintMaker *maker))remake;

@end


#pragma mark - View Controller

@interface UIViewController (JKConstraint)

@property (nonatomic,strong,readonly) JKConstraint *jk_topLayoutGuid;
@property (nonatomic,strong,readonly) JKConstraint *jk_topLayoutGuidTop;
@property (nonatomic,strong,readonly) JKConstraint *jk_topLayoutGuidBottom;

@property (nonatomic,strong,readonly) JKConstraint *jk_bottomLayoutGuid;
@property (nonatomic,strong,readonly) JKConstraint *jk_bottomLayoutGuidTop;
@property (nonatomic,strong,readonly) JKConstraint *jk_bottomLayoutGuidBottom;

@end

//
//  JKContactManager.h
//  ContactDemo
//
//  Created by Jack on 2018/12/24.
//  Copyright © 2018 Jack Template. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CNContact,CNMutableContact;
NS_CLASS_AVAILABLE(10_11, 9_0)
@interface JKContactManager : NSObject

+ (instancetype)defaultManager;

- (void)requestAuthorization:(void(^)(BOOL granted))completion;

#pragma mark - Search

- (void)fetchAllContactCompletionHandler:(void(^)(NSArray<CNContact *> *contacts, NSError *error))completion;

- (void)searchContactByName:(NSString *)name completionHandler:(void(^)(NSArray<CNContact *> *contacts, NSError *error))completion;

- (void)searchContactByKeyword:(NSString *)keyword completionHandler:(void(^)(NSArray<CNContact *> *contacts, NSError *error))completion;

#pragma mark - Insert

- (void)insertContact:(CNMutableContact *)contact  completionHandler:(void(^)(BOOL result,NSError *error))completion;

#pragma mark - Remove

- (void)removeContact:(CNContact *)contact completionHandler:(void(^)(BOOL result,NSError *error))completion;

#pragma mark - Update

- (void)updateContact:(CNMutableContact *)contact completionHandler:(void(^)(BOOL result,NSError *error))completion;

#pragma mark - Utils

- (void)sortGroupedContactsByFamilyNameFirstLetter:(NSArray<CNContact *> *)contacts
                                        completion:(void(^)(NSArray<NSString *> *sortedKeys, NSDictionary<NSString *, NSArray<CNContact *> *> *contactGroup))completion;///<使用姓氏首页字母分组

@end


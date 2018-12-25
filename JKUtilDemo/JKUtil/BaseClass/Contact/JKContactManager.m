//
//  JKContactManager.m
//  ContactDemo
//
//  Created by Jack on 2018/12/24.
//  Copyright © 2018 Jack Template. All rights reserved.
//

#import "JKContactManager.h"
#import <Contacts/Contacts.h>
#import "CNContact+JKContact.h"

@implementation JKContactManager

+ (instancetype)defaultManager {
    static JKContactManager *manager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[JKContactManager alloc] init];
    });
    return manager;
}

#pragma mark - Authorization

- (void)requestAuthorization:(void(^)(BOOL granted))completion {
    
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        
        if (completion) {
            completion(YES);
        }
        
    } else {
        
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (completion) {
                completion(granted);
            }
            
        }];
    }
}

#pragma mark - Get

- (void)searchContactWithPredicate:(NSPredicate *)predicate completionHandler:(void(^)(NSArray<CNContact *> *contacts, NSError *error))completion {
    
    // 创建联系人仓库
    CNContactStore *store = [[CNContactStore alloc] init];
    
    // 创建联系人的请求对象
    // keys决定能获取联系人哪些信息,例:姓名,电话,头像等
    NSArray *fetchKeys = @[
                           CNContactIdentifierKey,
                           CNContactGivenNameKey,
                           CNContactFamilyNameKey,
                           CNContactMiddleNameKey,
                           CNContactImageDataKey,
                           CNContactOrganizationNameKey,
                           CNContactDepartmentNameKey,
                           CNContactJobTitleKey,
                           CNContactPhoneNumbersKey,
                           CNContactEmailAddressesKey,
                           CNContactPostalAddressesKey,
                           CNContactSocialProfilesKey,
                           CNContactUrlAddressesKey,
                           CNContactNoteKey
                           ];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetchKeys];
    request.sortOrder = CNContactSortOrderFamilyName;
    request.predicate = predicate;
    
    // 请求联系人
    NSError *error = nil;
    NSMutableArray<CNContact *> *contacts = [NSMutableArray array];
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        [contacts addObject:contact];
    }];
    
    if (error) {
        contacts = nil;
    }
    if (completion) {
        completion([contacts copy], error);
    }
}

- (void)fetchAllContactCompletionHandler:(void(^)(NSArray<CNContact *> *contacts, NSError *error))completion {
    [self searchContactWithPredicate:nil completionHandler:completion];
}

- (void)searchContactByKeyword:(NSString *)keyword completionHandler:(void(^)(NSArray<CNContact *> *contacts, NSError *error))completion {
    if (keyword) {
        
        [self searchContactWithPredicate:nil completionHandler:^(NSArray<CNContact *> *contacts, NSError *error) {
            
            if (error) {
                
                if (completion) {
                    completion(nil, error);
                }
                
            } else {
                
                NSMutableArray<CNContact *> *keywordContacts = [NSMutableArray array];
                for (CNContact *c in contacts) {
                    if ([c jk_containsKeyWord:keyword]) {
                        [keywordContacts addObject:c];
                    }
                }
                
                if (completion) {
                    completion(keywordContacts, nil);
                }
            }
            
        }];
        
    } else {
        
        [self searchContactWithPredicate:nil completionHandler:completion];
    }
}

- (void)searchContactByName:(NSString *)name completionHandler:(void(^)(NSArray<CNContact *> *contacts, NSError *error))completion {
    [self searchContactWithPredicate:[CNContact predicateForContactsMatchingName:name] completionHandler:completion];
}

#pragma mark - Add

- (void)insertContact:(CNMutableContact *)contact  completionHandler:(void(^)(BOOL result,NSError *error))completion {
    
    if (contact) {
        CNContactStore *store = [[CNContactStore alloc] init];
        CNSaveRequest *request = [[CNSaveRequest alloc] init];
        
        [request addContact:contact toContainerWithIdentifier:nil];
        
        NSError *err;
        [store executeSaveRequest:request error:&err];
        if (completion) {
            completion(err == nil, err);
        }
    } else {
        
        if (completion) {
            completion(NO, [NSError errorWithDomain:NSCocoaErrorDomain code:404 userInfo:@{@"msg":@"contact is nil"}]);
        }
    }
}

#pragma mark - Remove

- (void)removeContact:(CNContact *)contact completionHandler:(void(^)(BOOL result,NSError *error))completion {
    
    if (contact) {
        
        if (contact.identifier != nil) {
            
            CNContactStore *store = [[CNContactStore alloc] init];
            CNSaveRequest *request = [[CNSaveRequest alloc] init];
            
            [request deleteContact:contact.mutableCopy];
            NSError *err;
            [store executeSaveRequest:request error:&err];
            if (completion) {
                completion(err == nil, err);
            }
            
        } else {
            
            if (completion) {
                completion(NO, [NSError errorWithDomain:NSCocoaErrorDomain code:404 userInfo:@{@"msg":@"contact's identifier is nil"}]);
            }
        }
        
    } else {
        
        if (completion) {
            completion(NO, [NSError errorWithDomain:NSCocoaErrorDomain code:404 userInfo:@{@"msg":@"contact is nil"}]);
        }
    }
}

#pragma mark - Modify

- (void)updateContact:(CNMutableContact *)contact completionHandler:(void(^)(BOOL result,NSError *error))completion {
    
    if (contact) {
        
        if (contact.identifier != nil) {
            
            CNContactStore *store = [[CNContactStore alloc] init];
            CNSaveRequest *request = [[CNSaveRequest alloc] init];
            
            [request updateContact:contact];
            NSError *err;
            [store executeSaveRequest:request error:&err];
            if (completion) {
                completion(err == nil, err);
            }
            
        } else {
            
            if (completion) {
                completion(NO, [NSError errorWithDomain:NSCocoaErrorDomain code:404 userInfo:@{@"msg":@"contact's identifier is nil"}]);
            }
        }
        
    } else {
        
        if (completion) {
            completion(NO, [NSError errorWithDomain:NSCocoaErrorDomain code:404 userInfo:@{@"msg":@"contact is nil"}]);
        }
    }
    
}

#pragma mark - Utils

- (NSString *)getFirstLetterFromString:(NSString *)aString {
    
    if (aString) {
        NSMutableString *str = [NSMutableString stringWithString:aString];
        //带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        NSLog(@"%@",str);
        //不带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
        //转化为大写拼音
        NSString *strPinYin = [str capitalizedString];
        
        NSString *firstString = [strPinYin substringToIndex:1];
        //判断姓名首位是否为大写字母
        NSString * regexA = @"^[A-Z]$";
        NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
        //获取并返回首字母
        return [predA evaluateWithObject:firstString] ? firstString : @"#";
    } else{
        return @"#";
    }
}

- (void)addContact:(CNContact *)contact toGroupDictionary:(NSMutableDictionary<NSString *, NSMutableArray<CNContact *> *> *)dic {
    
    if (contact && dic) {
    
        NSString *firstLetter = [self getFirstLetterFromString:contact.familyName];
        
        if (!dic[firstLetter]) {
            dic[firstLetter] = [NSMutableArray array];
        }
        [dic[firstLetter] addObject:contact];
    }
}

- (void)sortGroupedContactsByFamilyNameFirstLetter:(NSArray<CNContact *> *)contacts completion:(void(^)(NSArray<NSString *> *sortedKeys, NSDictionary<NSString *, NSArray<CNContact *> *> *contactGroup))completion {
    
    if (contacts && contacts.count > 0) {
        
        NSMutableDictionary<NSString *, NSMutableArray<CNContact *> *> *dic = [NSMutableDictionary dictionary];
        for (CNContact *c in contacts) {
            [self addContact:c toGroupDictionary:dic];
        }
        
        // 对Group排序
        [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray<CNContact *> * _Nonnull obj, BOOL * _Nonnull stop) {
           
            [obj sortUsingComparator:^NSComparisonResult(CNContact *  _Nonnull obj1, CNContact *  _Nonnull obj2) {
                return [obj1.familyName localizedCompare:obj2.familyName];
            }];
        }];
        
        NSArray *sortedKeys = [dic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 localizedCompare:obj2];
        }];
        
        if (completion) {
            completion(sortedKeys, dic);
        }
        
    } else {
        if (completion) {
            completion(nil, nil);
        }
    }
}

@end

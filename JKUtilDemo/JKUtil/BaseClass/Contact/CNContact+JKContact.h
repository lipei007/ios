//
//  CNContact+JKContact.h
//  ContactDemo
//
//  Created by Jack on 2018/12/25.
//  Copyright © 2018 Jack Template. All rights reserved.
//

#import <Contacts/Contacts.h>

@interface CNContact (JKContact)

- (BOOL)jk_containsKeyWord:(NSString *)keyword;

@end

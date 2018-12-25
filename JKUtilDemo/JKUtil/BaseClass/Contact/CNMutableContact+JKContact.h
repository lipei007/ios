//
//  CNMutableContact+JKContact.h
//  ContactDemo
//
//  Created by Jack on 2018/12/25.
//  Copyright © 2018 Jack Template. All rights reserved.
//

#import <Contacts/Contacts.h>

@interface CNMutableContact (JKContact)

#pragma mark - Phone

- (void)jk_addPhoneNumber:(NSString *)phoneNumber withLabel:(NSString *)label;

- (void)jk_deletePhoneNumber:(CNLabeledValue<CNPhoneNumber *> *)phoneNumber;

#pragma mark - Email

- (void)jk_addEmail:(NSString *)email withLabel:(NSString *)label;

- (void)jk_deleteEmail:(CNLabeledValue<NSString *> *)email;

#pragma mark - Postal Address

- (void)jk_addPostalAdress:(CNPostalAddress *)postalAddress withLabel:(NSString *)label;

- (void)jk_deletePostalAddress:(CNLabeledValue<CNPostalAddress *> *)address;

#pragma mark - Social Profile

- (void)jk_addSocialProfile:(CNSocialProfile *)socialProfile withLabel:(NSString *)label;

- (void)jk_deleteSocialProfiles:(CNLabeledValue<CNSocialProfile *> *)socialProfile;

#pragma mark - URL

- (void)jk_addURL:(NSString *)url withLabel:(NSString *)label;

- (void)jk_deleteURL:(CNLabeledValue<NSString *> *)url;

@end


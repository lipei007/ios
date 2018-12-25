//
//  CNMutableContact+JKContact.m
//  ContactDemo
//
//  Created by Jack on 2018/12/25.
//  Copyright © 2018 Jack Template. All rights reserved.
//

#import "CNMutableContact+JKContact.h"

@implementation CNMutableContact (JKContact)

#pragma mark - Phone

- (void)jk_addPhoneNumber:(NSString *)phoneNumber withLabel:(NSString *)label {
    
    if (phoneNumber) {
        
        if (!label) {
            label = CNLabelHome;
        }
        
        CNPhoneNumber *phone = [CNPhoneNumber phoneNumberWithStringValue:phoneNumber];
        CNLabeledValue *labeled_phone = [[CNLabeledValue alloc] initWithLabel:label value:phone];
        
        NSMutableArray<CNLabeledValue<CNPhoneNumber *> *> *phoneNumbers = [self.phoneNumbers mutableCopy];
        if (phoneNumbers == nil) {
            phoneNumbers = [NSMutableArray array];
        }
        [phoneNumbers addObject:labeled_phone];
        
        self.phoneNumbers = [phoneNumbers copy];
    }
}

- (void)jk_deletePhoneNumber:(CNLabeledValue<CNPhoneNumber *> *)phoneNumber {
    
    if (phoneNumber) {
        
        NSMutableArray<CNLabeledValue<CNPhoneNumber *> *> *phoneNumbers = [self.phoneNumbers mutableCopy];
        if (phoneNumbers && phoneNumbers.count > 0 && [phoneNumbers containsObject:phoneNumber]) {
            
            [phoneNumbers removeObject:phoneNumber];
            
            self.phoneNumbers = [phoneNumbers copy];
        }
        
    }
}

#pragma mark - Email

- (void)jk_addEmail:(NSString *)email withLabel:(NSString *)label {
    
    if (email) {
        
        if (!label) {
            label = CNLabelHome;
        }
        
        CNLabeledValue<NSString *> *labeledEmail = [[CNLabeledValue alloc] initWithLabel:label value:email];
        
        NSMutableArray<CNLabeledValue<NSString *> *> *emails = [self.emailAddresses mutableCopy];
        if (emails == nil) {
            emails = [NSMutableArray array];
        }
        [emails addObject:labeledEmail];
        
        self.emailAddresses = [emails copy];
    }
}

- (void)jk_deleteEmail:(CNLabeledValue<NSString *> *)email {
    
    if (email) {
        
        NSMutableArray<CNLabeledValue<NSString *> *> *emails = [self.emailAddresses mutableCopy];
        if (emails && emails.count > 0 && [emails containsObject:email]) {
            
            [emails removeObject:email];
            
            self.emailAddresses = [emails copy];
        }
        
    }
}

#pragma mark - Postal Address

- (void)jk_addPostalAdress:(CNPostalAddress *)postalAddress withLabel:(NSString *)label {
    
    if (postalAddress) {
        
        if (!label) {
            label = CNLabelHome;
        }
        
        CNLabeledValue<CNPostalAddress *> *labeledAddr = [[CNLabeledValue alloc] initWithLabel:label value:postalAddress];
        
        NSMutableArray<CNLabeledValue<CNPostalAddress *> *> *addresses = [self.postalAddresses mutableCopy];
        if (addresses == nil) {
            addresses = [NSMutableArray array];
        }
        [addresses addObject:labeledAddr];
        
        self.postalAddresses = [addresses copy];
    }
}

- (void)jk_deletePostalAddress:(CNLabeledValue<CNPostalAddress *> *)address {
    
    if (address) {
        
        NSMutableArray<CNLabeledValue<CNPostalAddress *> *> *addresses = [self.emailAddresses mutableCopy];
        if (addresses && addresses.count > 0 && [addresses containsObject:address]) {
            
            [addresses removeObject:address];
            
            self.postalAddresses = [addresses copy];
        }
        
    }
}

#pragma mark - Social Profile

- (void)jk_addSocialProfile:(CNSocialProfile *)socialProfile withLabel:(NSString *)label {
    
    if (socialProfile) {
        
        if (!label) {
            label = CNLabelHome;
        }
        
        CNLabeledValue<CNSocialProfile *> *labeledSocialProfile = [[CNLabeledValue alloc] initWithLabel:label value:socialProfile];
        
        NSMutableArray<CNLabeledValue<CNSocialProfile *> *> *socialProfiles = [self.socialProfiles mutableCopy];
        if (socialProfiles == nil) {
            socialProfiles = [NSMutableArray array];
        }
        [socialProfiles addObject:labeledSocialProfile];
        
        self.socialProfiles = [socialProfiles copy];
    }
}

- (void)jk_deleteSocialProfiles:(CNLabeledValue<CNSocialProfile *> *)socialProfile {
    
    if (socialProfile) {
        
        NSMutableArray<CNLabeledValue<CNSocialProfile *> *> *socialProfiles = [self.socialProfiles mutableCopy];
        if (socialProfiles && socialProfiles.count > 0 && [socialProfiles containsObject:socialProfile]) {
            
            [socialProfiles removeObject:socialProfile];
            
            self.socialProfiles = [socialProfiles copy];
        }
        
    }
}

#pragma mark - URL

- (void)jk_addURL:(NSString *)url withLabel:(NSString *)label {
    
    if (url) {
        
        if (!label) {
            label = CNLabelHome;
        }
        
        CNLabeledValue<NSString *> *labeledURL = [[CNLabeledValue alloc] initWithLabel:label value:url];
        
        NSMutableArray<CNLabeledValue<NSString *> *> *urlAddresses = [self.urlAddresses mutableCopy];
        if (urlAddresses == nil) {
            urlAddresses = [NSMutableArray array];
        }
        [urlAddresses addObject:labeledURL];
        
        self.urlAddresses = [urlAddresses copy];
    }
}

- (void)jk_deleteURL:(CNLabeledValue<NSString *> *)url {
    
    if (url) {
        
        NSMutableArray<CNLabeledValue<NSString *> *> *urlAddresses = [self.urlAddresses mutableCopy];
        if (urlAddresses && urlAddresses.count > 0 && [urlAddresses containsObject:url]) {
            
            [urlAddresses removeObject:url];
            
            self.urlAddresses = [urlAddresses copy];
        }
        
    }
}

@end

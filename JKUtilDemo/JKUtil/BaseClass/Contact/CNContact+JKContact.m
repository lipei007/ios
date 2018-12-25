//
//  CNContact+JKContact.m
//  ContactDemo
//
//  Created by Jack on 2018/12/25.
//  Copyright © 2018 Jack Template. All rights reserved.
//

#import "CNContact+JKContact.h"

@implementation CNContact (JKContact)

- (BOOL)jk_containsKeyWord:(NSString *)keyword {
    
    if (keyword && keyword.length > 0) {

        // givenName middleName familyName
        NSString *givenName = self.givenName;
        NSString *middleName = self.middleName;
        NSString *familyName = self.familyName;

        if ([givenName containsString:keyword] || [middleName containsString:keyword] || [familyName containsString:keyword]) {
            return YES;
        }
        
        // organizationName departmentName jobTitle
        NSString *organizationName = self.organizationName;
        NSString *departmentName = self.departmentName;
        NSString *jobTitle = self.jobTitle;

        if ([organizationName containsString:keyword] || [departmentName containsString:keyword] || [jobTitle containsString:keyword]) {
            return YES;
        }
        
        // phoneNumbers
        NSArray<CNLabeledValue<CNPhoneNumber*>*> *phoneNumbers = self.phoneNumbers;
        for (CNLabeledValue<CNPhoneNumber*> *labeledValue in phoneNumbers) {
            
            CNPhoneNumber *phoneNumber = labeledValue.value;
//            NSString *label = [CNLabeledValue localizedStringForLabel:labeledValue.label];

            if ([phoneNumber.stringValue containsString:keyword]) {
                return YES;
            }
        }

        // emailAddresses
        NSArray<CNLabeledValue<NSString*>*> *emailAddresses = self.emailAddresses;
        for (CNLabeledValue<NSString*> *labeledValue in emailAddresses) {
            
            NSString *email = labeledValue.value;
//            NSString *label = [CNLabeledValue localizedStringForLabel:labeledValue.label];

            if ([email containsString:keyword]) {
                return YES;
            }
        }

        // postalAddresses
        NSArray<CNLabeledValue<CNPostalAddress*>*> *postalAddresses = self.postalAddresses;
        for (CNLabeledValue<CNPostalAddress*> *labeledValue in postalAddresses) {
            
//            NSString *label = [CNLabeledValue localizedStringForLabel:labeledValue.label];
            CNPostalAddress *postalAddress = labeledValue.value;
            NSString *postalCode = postalAddress.postalCode;
            NSString *country = postalAddress.country;
            NSString *state = postalAddress.state;
            NSString *city = postalAddress.city;
            NSString *street = postalAddress.street;
            
            if ([postalCode containsString:keyword] || [country containsString:keyword] || [state containsString:keyword] || [city containsString:keyword] || [street containsString:keyword]) {
                return YES;
            }
        }


        // urlAddresses
        NSArray<CNLabeledValue<NSString*>*> *urlAddresses = self.urlAddresses;
        for (CNLabeledValue<NSString*> *labeledValue in urlAddresses) {
            
            NSString *url = labeledValue.value;
//            NSString *label = [CNLabeledValue localizedStringForLabel:labeledValue.label];

            if ([url containsString:keyword]) {
                return YES;
            }
        }
        
        // note
        if ([self.note containsString: keyword]) {
            return YES;
        }
        
    }
    
    return NO;
}

@end

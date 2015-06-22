//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTIObject.h"

// Libraries
#import <objc/runtime.h>

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@interface BTIObject ()

// Private Properties
@property (nonatomic, assign, getter = isDescriptionInProgress) BOOL descriptionInProgress;

@end

@implementation BTIObject

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Management

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Custom Getters and Setters


#pragma mark - Initialization


#pragma mark - NSObject Overrides


#pragma mark - NSObject Protocol Methods

- (NSString *)description
{
    // Bail to avoid recursive loop
    
    if ([self isDescriptionInProgress])
    {
        return [NSString stringWithFormat:@">>> Already logged: <%@: %p>", NSStringFromClass([self class]), self];
    }
    
    [self setDescriptionInProgress:YES];
    
    NSMutableString *description = [NSMutableString string];
    
    [description appendFormat:@"\n\n<%@: %p>\n", NSStringFromClass([self class]), self];
    [description appendString:@"{{\n"];
    
    // Get list of properties
    // https://developer.apple.com/library/mac/documentation/cocoa/conceptual/objcruntimeguide/articles/ocrtpropertyintrospection.html
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int index = 0; index < outCount; index++)
    {
        objc_property_t property = properties[index];
        
        const char *propertyName = property_getName(property);
        const char *propertyAttributes = property_getAttributes(property);
        
        NSString *propertyNameString = [NSString stringWithUTF8String:propertyName];
        NSString *propertyAttributesString = [NSString stringWithUTF8String:propertyAttributes];
        
        // https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
        // Explanation of leading T, under "Property Type String":
        // https://developer.apple.com/library/mac/documentation/cocoa/conceptual/objcruntimeguide/articles/ocrtpropertyintrospection.html
        
        // valueForKey: chokes if the return type is SEL.  Need to special-case those.
        
        id value = nil;
        
        if ([propertyAttributesString hasPrefix:@"T:"])       // Selector (SEL) type
        {
            SEL propertySelector = NSSelectorFromString(propertyNameString);
            
            NSMethodSignature *signature = [self methodSignatureForSelector:propertySelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setSelector:propertySelector];
            [invocation setTarget:self];

            SEL valueSelector = NULL;
            [invocation invoke];
            [invocation getReturnValue:&valueSelector];
            
            value = NSStringFromSelector(valueSelector);
        }
        else
        {
            value = [self valueForKey:propertyNameString];
        }
        
        [description appendFormat:@"    %@: %@\n", propertyNameString, value];
    }
    
    if (properties != NULL)
    {
        free(properties);
    }
    
    [description appendString:@"}}\n\n"];
    
    [self setDescriptionInProgress:NO];
    
    return description;
}

@end

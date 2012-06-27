#import <Foundation/Foundation.h>
#import "Jastor.h"

#define kProjectVersion @"1.0"

@interface GTSProject : Jastor

@property (nonatomic, strong) NSString *version;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *customer;

@end

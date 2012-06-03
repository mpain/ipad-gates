#import "GTSLabelElement.h"
#import "GTSEditableElement.h"

@interface GTSNumberElement : GTSEditableElement

@property (nonatomic, strong) NSDecimalNumber *number;
@property (nonatomic, assign) NSInteger fractionDigits;

@end

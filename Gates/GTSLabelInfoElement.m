#import "GTSLabelInfoElement.h"
#import "GTSLabelInfoCell.h"

@implementation GTSLabelInfoElement

@synthesize info;

- (NSString *)cellReusableIdentifier {
    return @"GTSLabelInfoCellIdentifier";
}

@end

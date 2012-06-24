#import "GTSLabelElement.h"
#import "GTSLabelCell.h"

@implementation GTSLabelElement

@synthesize label;

- (NSString *)cellReusableIdentifier {
    return @"GTSLabelCellIdentifier";
}


@end

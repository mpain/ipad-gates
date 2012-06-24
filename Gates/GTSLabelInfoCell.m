#import "GTSLabelInfoCell.h"
#import "GTSLabelInfoElement.h"

@implementation GTSLabelInfoCell

@synthesize labelInfo;

- (void)updateCellFromElement {
    self.labelInfo.text = ((GTSLabelInfoElement *)self.element).info;
    [super updateCellFromElement];
}


@end

#import "GTSLabelInfoCell.h"
#import "GTSLabelInfoElement.h"

@implementation GTSLabelInfoCell

@synthesize labelInfo;
@synthesize element;

- (void)updateCellFromElement:(GTSLabelInfoElement *)anElement {
    self.element = anElement;
    [self updateCellFromElement];
}

- (void)updateCellFromElement {
    self.labelInfo.text = element.info;
}


@end

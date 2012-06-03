#import "GTSLabelInfoCell.h"
#import "GTSLabelInfoElement.h"

@implementation GTSLabelInfoCell

@synthesize labelInfo;
@synthesize element;

- (void)updateCellFromElement:(GTSLabelInfoElement *)anElement {
    self.element = anElement;
    [self updateInfoFromElement];
}

- (void)updateInfoFromElement {
    self.labelInfo.text = element.info;
}


@end

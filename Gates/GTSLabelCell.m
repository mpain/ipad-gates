#import "GTSLabelCell.h"
#import "GTSLabelElement.h"
#import "GTSElementDelegate.h"

@implementation GTSLabelCell

@synthesize label = _label;
@synthesize element = _element;
@synthesize tableView = _tableViewHost;

- (void)updateCellForElement:(GTSRowElement *)anElement andTableView:(GTSFormTableView *)aTableView {
    self.element = anElement;
    self.tableView = aTableView;
    
    [self updateCellFromElement];
}

- (GTSLabelElement *)labelElement {
    return (GTSLabelElement *)self.element;
}
- (void)updateCellFromElement {
    self.label.text = self.labelElement.label;
}

- (void)notificateAboutValueWasChanged {
	if ([self.element.delegate respondsToSelector:@selector(valueChangedForElement:)]) {
        [self.element.delegate valueChangedForElement:self.element];
    }
}

@end

#import "GTSFormCell.h"

@class GTSRowElement;
@class GTSFormTableView;

@interface GTSLabelCell : GTSFormCell

@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, weak) GTSRowElement *element;
@property (nonatomic, weak) GTSFormTableView *tableView;

- (void)updateCellForElement:(GTSRowElement *)anElement andTableView:(GTSFormTableView *)aTableView;
- (void)notificateAboutValueWasChanged;

@end

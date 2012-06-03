#import "GTSLabelCell.h"

@class GTSRowElement;
@class GTSFormTableView;

@interface GTSEditableCell : GTSLabelCell<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textValue;
@property (nonatomic, weak) GTSRowElement *element;
@property (nonatomic, weak) GTSFormTableView *tableView;

- (void)updateCellForElement:(GTSRowElement *)anElement andTableView:(GTSFormTableView *)aTableView;
@end

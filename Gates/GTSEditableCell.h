#import "GTSLabelCell.h"

@interface GTSEditableCell : GTSLabelCell<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textValue;

@end

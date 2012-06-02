#import <UIKit/UIKit.h>
#import "GTSFormCell.h"


@interface GTSFormTextFieldCell : GTSFormCell

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIButton *buttonCalc;
@property (nonatomic, strong) IBOutlet UILabel *label;

@end

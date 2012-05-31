#import "QPickerViewController.h"

@interface QPickerViewController ()

@end

@implementation QPickerViewController

- (id)initWithPickerView:(UIPickerView *)pickerView {
    self = [super init];
    if (self) {
		self.view = pickerView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

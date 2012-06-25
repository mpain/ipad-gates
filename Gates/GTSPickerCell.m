#import "GTSPickerCell.h"
#import "GTSPickerElement.h"

@implementation GTSPickerCell  {
	__strong UIView *_pickerHost;
	__strong UIPickerView *_pickerView;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
	_pickerHost = [[UIView alloc] initWithFrame:CGRectZero];
	_pickerHost.autoresizingMask = (UIViewAutoresizingNone);
	_pickerHost.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	
	_pickerView = [[UIPickerView alloc] init];
	_pickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
	
	_pickerView.showsSelectionIndicator = YES;
	_pickerView.dataSource = self;
	_pickerView.delegate = self;
	
	_pickerHost.frame = _pickerView.frame;
	NSLog(@"Frame: %f %f %f %f", _pickerView.frame.origin.x, _pickerView.frame.origin.y, _pickerView.frame.size.width, _pickerView.frame.size.height);
	
	[_pickerHost addSubview:_pickerView];
	self.textValue.inputView = _pickerHost;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear:) name:UIKeyboardDidShowNotification object:nil];
	
}

- (void)updateCellFromElement {
	self.textValue.text = self.pickerElement.text;
	[self setPickerViewValue:self.pickerElement.text];
    [super updateCellFromElement];
}


- (GTSPickerElement *)pickerElement {
    return (GTSPickerElement *)self.element;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	//[_pickerView sizeToFit];
	[self.textValue reloadInputViews];
	
	[super textFieldDidBeginEditing:textField];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return self.pickerElement.items.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [[self.pickerElement.items objectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[[self.pickerElement.items objectAtIndex:component] objectAtIndex:row] description];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.pickerElement.text = [self getPickerViewValue];
    [self updateCellFromElement];
	[self notificateAboutValueWasChanged];
	[self setNeedsDisplay];
}

#pragma mark - Getting/setting value from UIPickerView

- (NSArray *)getSelectedIndices {
    NSMutableArray *componentsValues = [NSMutableArray array];
    
    for (int i = 0; i < _pickerView.numberOfComponents; i++) {
        NSInteger rowIndex = [_pickerView selectedRowInComponent:i];
        if (rowIndex >= 0) {
            [componentsValues addObject:[self pickerView:_pickerView titleForRow:rowIndex forComponent:i]];
        } else {
            [componentsValues addObject:[NSNull null]];
        }
    }
	
    return componentsValues;
}

- (NSString *)getPickerViewValue {
	NSArray *selections = [self getSelectedIndices];
	self.pickerElement.selectedIndices = selections;
    return [self.pickerElement.valueParser objectFromComponentsValues:selections];
}

- (void)setPickerViewValue:(NSString *)value {
    NSArray *componentsValues = [self.pickerElement.valueParser componentsValuesFromObject:value];
    
    for (int index = 0; index < componentsValues.count && _pickerView.numberOfComponents; index++) {
        id componentValue = [componentsValues objectAtIndex:(NSUInteger) index];
        NSInteger rowIndex = [[self.pickerElement.items objectAtIndex:index] indexOfObject:componentValue];
        [_pickerView selectRow:rowIndex inComponent:index animated:YES];
    }
}

- (void)keyboardDidAppear:(NSNotification *)notification {
	if (self.superview && self.textValue.isFirstResponder) {
		
		//[_pickerView setNeedsLayout];
		CGRect keyboardFrame = [self convertRect:[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
		
		CGRect frame = 	_pickerHost.frame;
		frame.size = keyboardFrame.size;
		if (self.textValue.inputAccessoryView) {
			frame.size.height -= self.textValue.inputAccessoryView.bounds.size.height;
		}
		_pickerHost.frame = frame;
	}
}
@end

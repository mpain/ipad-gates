#import "GTSEditableCell.h"
#import "GTSFormTableView.h"
#import "GTSRowElement.h"
#import "GTSSection.h"
#import "GTSForm.h"
#import "GTSElementDelegate.h"
#import "GTSEditableElement.h"

@implementation GTSEditableCell {
    UISegmentedControl *prevNext;
}

@synthesize textValue;
@synthesize element;
@synthesize tableView;

- (UIToolbar *)createActionBar {
    UIToolbar *toolbar = [UIToolbar new];
    toolbar.translucent = YES;
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [toolbar sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"ACTIONBAR_DONE", @"") style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBarDone:)];
    
    prevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"ACTIONBAR_PREVIOUS", @""), NSLocalizedString(@"ACTIONBAR_NEXT", @""), nil]];
    prevNext.momentary = YES;
    prevNext.segmentedControlStyle = UISegmentedControlStyleBar;
    prevNext.tintColor = toolbar.tintColor;
    [prevNext addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:prevNext];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
    
	return toolbar;
}

- (void)updateCellForElement:(GTSRowElement *)anElement andTableView:(GTSFormTableView *)aTableView {
    self.element = anElement;
    self.tableView = aTableView;
	textValue.text = ((GTSEditableElement *)anElement).text;
    textValue.inputAccessoryView = [self createActionBar];
    
    [self updatePrevNextStatus];
	[self updateCellFromElement];
	[self notificateAboutValueWasChanged];
}

#pragma mark - UITextField delegate -
- (void)textFieldEditingChanged:(UITextField *)textFieldEditingChanged {
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [tableView scrollToRowAtIndexPath:[tableView indexForElement:element] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    });
    
    
    if (textValue.returnKeyType == UIReturnKeyDefault) {
        UIReturnKeyType returnType = ([self findNextElement] != nil) ? UIReturnKeyNext : UIReturnKeyDone;
        textValue.returnKeyType = returnType;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self notificateAboutValueWasChanged];
    return YES;
}

- (void)notificateAboutValueWasChanged {
	if ([self.element.delegate respondsToSelector:@selector(valueChangedForElement:)]) {
        [self.element.delegate valueChangedForElement:element];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    GTSRowElement *nextElement = [self findNextElement];
    if (nextElement) {
        UITableViewCell *cell = [self.tableView cellForElement:nextElement];
        if (cell) {
            [cell becomeFirstResponder];
        }
    }  else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)updatePrevNextStatus {
    [prevNext setEnabled:([self findPreviousElement] != nil) forSegmentAtIndex:0];
    [prevNext setEnabled:([self findNextElement] != nil) forSegmentAtIndex:1];
}

#pragma mark - Action bar handlers -
- (BOOL)handleActionBarDone:(NSObject *)sender {
    [self endEditing:YES];
    [self endEditing:NO];
    [textValue resignFirstResponder];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    return NO;
}

- (void)handleActionBarPreviousNext:(NSObject *)sender {
	GTSRowElement *target = (prevNext.selectedSegmentIndex == 1) ? [self findNextElement] : [self findPreviousElement];
	
	if (target) {
        UITableViewCell *cell = [self.tableView cellForElement:target];
		if (cell) {
			[cell becomeFirstResponder];
		} else {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
                UITableViewCell *aCell = [self.tableView cellForElement:element];
                if (aCell) {
                    [aCell becomeFirstResponder];
                }
            });
        }
	}
}

#pragma mark - Responder stuff -

- (BOOL)becomeFirstResponder {
    [textValue becomeFirstResponder];
    return YES;
}

- (BOOL)resignFirstResponder {
    return YES;
}

#pragma mark - Previous and next element search methods -

- (GTSRowElement *)findPreviousElement {
    GTSRowElement *previousElement = nil;
    for (GTSSection *section in self.element.section.form.sections) {
        for (GTSRowElement *current in section.elements) {
            if (current == self.element) {
                return previousElement;
            } else if ([current isKindOfClass:[GTSEditableElement class]]){
                previousElement = (GTSRowElement *)current;
            }
        }
    }
    return nil;
}

- (GTSRowElement *)findNextElement {
    BOOL foundSelf = NO;
    for (GTSSection *section in self.element.section.form.sections) {
        for (GTSRowElement *current in section.elements) {
            if (current == self.element) {
                foundSelf = YES;
            } else if (foundSelf && [current isKindOfClass:[GTSEditableElement class]]){
                return (GTSRowElement *)current;
            }
        }
    }
    return nil;
}

@end

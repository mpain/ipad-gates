#import "GTSProjectFormEngine.h"
#import "GTSFormatters.h"
#import "GTSForm.h"
#import "GTSSection.h"
#import "GTSNumberElement.h"
#import "GTSLabelInfoElement.h"
#import "GTSPickerElement.h"
#import "GTSBooleanElement.h"

@implementation GTSProjectFormEngine {
    __strong GTSNumberElement *gatesWidthElement;
    __strong GTSNumberElement *gatesHeightElement;
    __strong GTSLabelInfoElement *gatesSurfaceElement;
	
    __strong GTSBooleanElement *_gatesBooleanElement;
    __strong GTSLabelElement *_gatesSimpleElement;
    
	__strong NSDecimalNumber *aMillion;
}

@synthesize form;
@synthesize delegate;

+ (GTSProjectFormEngine *)sharedInstance {
    static dispatch_once_t once;
    __strong static id _sharedInstance = nil;
    dispatch_once(&once, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self ) {
		aMillion = [NSDecimalNumber decimalNumberWithString:@"1000000"];
        [self build];
    }
    return self;
}

- (void)build {
	self.form = [GTSForm new];
	[form addSection:[self buildProjectSection]];
	[form addSection:[self buildGatesSection]];
    [form addSection:[self buildSimpleSection]];
}

- (GTSSection *)buildProjectSection {
	GTSSection *section = [GTSSection new];
	section.title = NSLocalizedString(@"PROJECT_SECTION_COMMON", nil);
	[self editableElementWithLabel:@"PROJECT_COMMON_TITLE" section:section];
	[self editableElementWithLabel:@"PROJECT_COMMON_ADDRESS" section:section];
	[self editableElementWithLabel:@"PROJECT_COMMON_CUSTOMER_NAME" section:section];
	[self editableElementWithLabel:@"PROJECT_COMMON_CUSTOMER_PHONE" section:section];
	
	[self pickerElementWithLabel:@"PROJECT_COMMON_CUSTOMER_PICKER" section:section items:[NSArray arrayWithObject:[NSArray arrayWithObjects:@"First", @"Second", @"Third", @"Fourth", nil]]];
	
    _gatesBooleanElement = [self booleanElementWithLabel:@"TEST_BOOLEAN" section:section needToSetDelegate:YES];
    _gatesBooleanElement.on = YES;
	return section;
}

- (GTSSection *)buildGatesSection {
	GTSSection *section = [GTSSection new];
	section.title = NSLocalizedString(@"PROJECT_SECTION_DIMENTIONS", nil);
    
    gatesWidthElement = [self numberElementWithLabel:@"PROJECT_GATES_WIDTH" withDelegate:self section:section];
    gatesHeightElement = [self numberElementWithLabel:@"PROJECT_GATES_HEIGHT" withDelegate:self section:section];
    gatesSurfaceElement = [self labelElementWithLabel:@"PROJECT_GATES_SURFACE" section:section];
    
	return section;
}


- (GTSSection *)buildSimpleSection {
	GTSSection *section = [GTSSection new];
	section.title = NSLocalizedString(@"PROJECT_SECTION_DIMENTIONS", nil);
    
    [self numberElementWithLabel:@"PROJECT_GATES_WIDTH" withDelegate:self section:section];
    [self numberElementWithLabel:@"PROJECT_GATES_HEIGHT" withDelegate:self section:section];
    _gatesSimpleElement = [self labelElementWithLabel:@"PROJECT_GATES_SURFACE" section:section];
    
	return section;
}

- (GTSNumberElement *)numberElementWithLabel:(NSString *)label withDelegate:(id<GTSElementDelegate>)aDelegate section:(GTSSection*)section {
    GTSNumberElement *element = [GTSNumberElement new];
    element.label = NSLocalizedString(label, nil);
    element.delegate = aDelegate;
    
    [section addElement:element];
    
    return element;
}

- (GTSLabelInfoElement *)labelElementWithLabel:(NSString *)label section:(GTSSection *)section {
    GTSLabelInfoElement *element = [GTSLabelInfoElement new];
    element.label = NSLocalizedString(label, nil);
    [section addElement:element];
    
    return element;
}

- (GTSEditableElement *)editableElementWithLabel:(NSString *)label section:(GTSSection *)section {
	GTSEditableElement *element = [GTSEditableElement new];
    element.label = NSLocalizedString(label, nil);
    [section addElement:element];
    
    return element;
}

- (GTSPickerElement *)pickerElementWithLabel:(NSString *)label section:(GTSSection *)section items:(NSArray *)items {
	GTSPickerElement *element = [[GTSPickerElement alloc] initWithItems:items value:nil];
    element.label = NSLocalizedString(label, nil);
    [section addElement:element];
    
    return element;
}

- (GTSBooleanElement *)booleanElementWithLabel:(NSString *)label section:(GTSSection *)section needToSetDelegate:(BOOL)needToSetDelegate {
    GTSBooleanElement *element = [GTSBooleanElement new];
    element.label = NSLocalizedString(label, nil);
    if (needToSetDelegate) {
        element.delegate = self;
    }
    [section addElement:element];
    return element;
}

- (void)valueChangedForElement:(GTSRowElement *)element {
    NSLog(@"Value was changed for an element: %@", [element description]);
    
    if ((element == gatesWidthElement || element == gatesHeightElement) && 
                (gatesHeightElement.number && gatesWidthElement.number)) {
        NSDecimalNumber *surface = [[gatesWidthElement.number decimalNumberByMultiplyingBy:gatesHeightElement.number] decimalNumberByDividingBy:aMillion];
        gatesSurfaceElement.info = [[[GTSFormatters sharedInstance] floatNumberFormatter] stringFromNumber:surface];
        
		if ([self.delegate respondsToSelector:@selector(reloadAnElement:)]) {
			[self.delegate reloadAnElement:gatesSurfaceElement];
		}
    } else if (element == _gatesBooleanElement) {
        _gatesSimpleElement.hidden = !_gatesBooleanElement.on;
        if ([self.delegate respondsToSelector:@selector(showOrHideElements:)]) {
			[self.delegate showOrHideElements:[NSArray arrayWithObject:_gatesSimpleElement]];
		}
    }
}
@end

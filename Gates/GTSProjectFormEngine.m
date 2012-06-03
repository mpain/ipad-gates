#import "GTSProjectFormEngine.h"
#import "GTSForm.h"
#import "GTSSection.h"
#import "GTSNumberElement.h"
#import "GTSLabelInfoElement.h"

@implementation GTSProjectFormEngine {
    __strong GTSNumberElement *gatesWidthElement;
    __strong GTSNumberElement *gatesHeightElement;
    __strong GTSLabelInfoElement *gatesSurfaceElement;
}

@synthesize form;

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
        [self build];
    }
    return self;
}

- (GTSSection*)buildGatesSection {
	GTSSection *section = [GTSSection new];
	section.title = NSLocalizedString(@"PROJECT_SECTION_DIMENTIONS", nil);
    
    gatesWidthElement = [self numberElementWithLabel:@"PROJECT_GATES_WIDTH" withDelegate:self section:section];
    gatesHeightElement = [self numberElementWithLabel:@"PROJECT_GATES_HEIGHT" withDelegate:self section:section];
    gatesSurfaceElement = [self labelElementWithLabel:@"PROJECT_GATES_SURFACE" section:section];
    
	return section;
}

- (GTSForm *)build {
	self.form = [GTSForm new];
	[form addSection:[self buildGatesSection]];
	return form;
}

- (GTSNumberElement *)numberElementWithLabel:(NSString *)label withDelegate:(id<GTSElementDelegate>)delegate section:(GTSSection*)section {
    GTSNumberElement *element = [GTSNumberElement new];
    element.label = NSLocalizedString(label, nil);
    element.delegate = delegate;
    
    [section addElement:element];
    
    return element;
}

- (GTSLabelInfoElement *)labelElementWithLabel:(NSString *)label section:(GTSSection *)section {
    GTSLabelInfoElement *element = [GTSLabelInfoElement new];
    element.label = NSLocalizedString(label, nil);
    [section addElement:element];
    
    return element;
}

- (void)valueChangedForElement:(GTSRowElement *)element {
    if ((element == gatesWidthElement || element == gatesHeightElement) && 
                (gatesHeightElement.number && gatesWidthElement.number)) {
        NSDecimalNumber *surface = [gatesWidthElement.number decimalNumberByMultiplyingBy:gatesHeightElement.number];
        gatesSurfaceElement.info = [surface description];
        
    }
}
@end

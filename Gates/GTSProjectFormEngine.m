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
    
	__strong NSDecimalNumber *_oneMillion;
	__strong NSArray *_commonMatherials;
	__strong NSArray *_commonPanelDesignTypes;
	__strong NSArray *_commonPanelStructure;
	__strong NSArray *_commonPanelColor;
	
	__strong NSMutableArray *_outerPanel;
	__strong NSMutableArray *_innerPanel;
	
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
		_oneMillion = [NSDecimalNumber decimalNumberWithString:@"1000000"];
		_commonMatherials = [NSArray arrayWithObject:[NSArray arrayWithObjects:
													  NSLocalizedString(@"MATHERIAL_CONCRETE", nil),
													  NSLocalizedString(@"MATHERIAL_WOOD", nil),
													  NSLocalizedString(@"MATHERIAL_BRICK", nil),
													  NSLocalizedString(@"MATHERIAL_AIR_BRICK", nil),
													  NSLocalizedString(@"MATHERIAL_METAL", nil), nil]];
		_commonPanelDesignTypes = [NSArray arrayWithObject:[NSArray arrayWithObjects:
													  NSLocalizedString(@"PANEL_TYPE_CLASSIC", nil),
													  NSLocalizedString(@"PANEL_SMOOTH_SURFACE", nil),
													  NSLocalizedString(@"PANEL_CENTRAL_LINE", nil),
													  NSLocalizedString(@"PANEL_WAVE", nil),
													  NSLocalizedString(@"PANEL_WAVE_CENTRAL_LINE", nil),
													  NSLocalizedString(@"PANEL_PANEL", nil), nil]];
		
		_commonPanelStructure = [NSArray arrayWithObject:[NSArray arrayWithObjects:
															NSLocalizedString(@"PANEL_STRUCTURE_SMOOTH", nil),
															NSLocalizedString(@"PANEL_STUCCO", nil),
															NSLocalizedString(@"PANEL_WOOD", nil), nil]];
		
		_commonPanelColor = [NSArray arrayWithObject:[NSArray arrayWithObjects:
														  NSLocalizedString(@"PANEL_COLOR_DEFAULT", nil),
														  NSLocalizedString(@"PANEL_COLOR_CUSTOM", nil),
														  NSLocalizedString(@"PANEL_COLOR_WOOD", nil),
														  NSLocalizedString(@"PANEL_COLOR_USER", nil), nil]];
		
        [self build];
    }
    return self;
}

- (void)build {
	self.form = [GTSForm new];
	
	_outerPanel = [NSMutableArray array];
	_innerPanel = [NSMutableArray array];
	
	[form addSection:[self buildProjectSection]];
	[form addSection:[self buildPackagingSection]];
	[form addSection:[self buildGatesSection]];
	[form addSection:[self buildDesignFeaturesSection]];
	[form addSection:[self buildSandwichPanelsSection]];
}

- (GTSSection *)buildProjectSection {
	GTSSection *section = [GTSSection new];
	section.title = NSLocalizedString(@"PROJECT_SECTION_COMMON", nil);
	[self editableElementWithLabel:@"PROJECT_COMMON_TITLE" section:section];
	[self editableElementWithLabel:@"PROJECT_COMMON_ADDRESS" section:section];
	[self editableElementWithLabel:@"PROJECT_COMMON_CUSTOMER_NAME" section:section];
	[self editableElementWithLabel:@"PROJECT_COMMON_CUSTOMER_PHONE" section:section];
	
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


- (GTSSection *)buildPackagingSection {
	GTSSection *section = [GTSSection new];
	section.title = NSLocalizedString(@"PROJECT_SECTION_PACKAGING", nil);
    
    [self pickerElementWithLabel:@"PROJECT_PACKAGING_TYPE" section:section items:
					[NSArray arrayWithObject:[NSArray arrayWithObjects:
							   NSLocalizedString(@"PROJECT_PACKAGING_TYPE_FULL", nil),
							   NSLocalizedString(@"PROJECT_PACKAGING_TYPE_GATES", nil),
							   NSLocalizedString(@"PROJECT_PACKAGING_TYPE_RULERS", nil), nil]]];
    
	return section;
}

- (GTSSection *)buildDesignFeaturesSection {
	GTSSection *section = [GTSSection new];
	section.title = NSLocalizedString(@"PROJECT_SECTION_DESIGN_FEATURES", nil);
    
    [self numberElementWithLabel:@"PROJECT_DESIGN_FEATURE_LINTEL" withDelegate:self section:section];
	[self numberElementWithLabel:@"PROJECT_DESIGN_FEATURE_PARTITION_LEFT" withDelegate:self section:section];
	[self numberElementWithLabel:@"PROJECT_DESIGN_FEATURE_PARTITION_RIGHT" withDelegate:self section:section];
	[self numberElementWithLabel:@"PROJECT_DESIGN_FEATURE_ROOM_DEPTH" withDelegate:self section:section];

    [self pickerElementWithLabel:@"PROJECT_DESIGN_FEATURE_WALL_MATHERIAL" section:section items:_commonMatherials];
	[self pickerElementWithLabel:@"PROJECT_DESIGN_FEATURE_CEILING_MATHERIAL" section:section items:_commonMatherials];
	[self pickerElementWithLabel:@"PROJECT_DESIGN_FEATURE_LINTEL_MATHERIAL" section:section items:_commonMatherials];
	
	 
	return section;
}



- (GTSSection *)buildSandwichPanelsSection {
	GTSSection *section = [GTSSection new];
	section.title = NSLocalizedString(@"PROJECT_SECTION_SANDWICH_PANELS", nil);
    
    [self booleanElementWithLabel:@"PROJECT_SANDWICH_PANEL_DEFENCE" section:section needToSetDelegate:NO];
	
	[self addPanelElementsForSection:section forPanel:_outerPanel withPrefix:@"OUTER"];
	[self addPanelElementsForSection:section forPanel:_innerPanel withPrefix:@"INNER"];
	
	[self pickerElementWithLabel:@"PROJECT_SANDWICH_PANEL_INNER_DESIGN" section:section items:_commonPanelDesignTypes];
	
	
	return section;
}

- (void)addPanelElementsForSection:(GTSSection *)section forPanel:(NSMutableArray *)panel withPrefix:(NSString *)prefix {
	[self pickerElementWithLabel:@"PROJECT_SANDWICH_PANEL_OUTER_DESIGN" section:section items:_commonPanelDesignTypes];
	[self pickerElementWithLabel:@"PROJECT_SANDWICH_PANEL_OUTER_STRUCTURE" section:section items:_commonPanelStructure];
	
	[panel removeAllObjects];
    [panel addObject:[self pickerElementWithLabel:[NSString stringWithFormat:@"PROJECT_SANDWICH_PANEL_%@_COLOR", prefix] section:section items:_commonPanelColor]];
	[panel addObject:[self pickerElementWithLabel:@"COLOR_DEFAULT" section:section items:_commonPanelColor]];
	[panel addObject:[self pickerElementWithLabel:@"COLOR_CUSTOM" section:section items:_commonPanelColor hidden:YES]];
	[panel addObject:[self pickerElementWithLabel:@"COLOR_WOOD" section:section items:_commonPanelColor hidden:YES]];
	
	GTSNumberElement *numberElement = [self numberElementWithLabel:@"COLOR_USER" withDelegate:nil section:section];
	numberElement.hidden = YES;
	[panel addObject:numberElement];
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

- (GTSPickerElement *)pickerElementWithLabel:(NSString *)label section:(GTSSection *)section items:(NSArray *)items hidden:(BOOL)isHidden {
	GTSPickerElement *element = [self pickerElementWithLabel:label section:section items:items];
	element.hidden = isHidden;
	return element;
}

- (GTSPickerElement *)pickerElementWithLabel:(NSString *)label section:(GTSSection *)section items:(NSArray *)items {
	GTSPickerElement *element = [[GTSPickerElement alloc] initWithItems:items value:nil];
    element.label = NSLocalizedString(label, nil);
	element.delegate = self;
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
    if ((element == gatesWidthElement || element == gatesHeightElement) && 
                (gatesHeightElement.number && gatesWidthElement.number)) {
        NSDecimalNumber *surface = [[gatesWidthElement.number decimalNumberByMultiplyingBy:gatesHeightElement.number] decimalNumberByDividingBy:_oneMillion];
        gatesSurfaceElement.info = [[[GTSFormatters sharedInstance] floatNumberFormatter] stringFromNumber:surface];
        
		if ([self.delegate respondsToSelector:@selector(reloadAnElement:)]) {
			[self.delegate reloadAnElement:gatesSurfaceElement];
		}
    } else if (element == [_outerPanel objectAtIndex:0]) {
		GTSPickerElement *picker = (GTSPickerElement *)element;
		NSInteger selectionIndex = [[picker.items objectAtIndex:0] indexOfObject:[picker.selectedIndices objectAtIndex:0]];
		
		if (selectionIndex != NSNotFound) {
			GTSRowElement *found = nil;
			for (NSInteger i = 1; i < _outerPanel.count; i++) {
				GTSRowElement *current = [_outerPanel objectAtIndex:i];
				BOOL state = ((i - 1) != selectionIndex);
				if (!current.isHidden && current.isHidden != state) {
					found = current;
				}
			}
			
			if (found && [self.delegate respondsToSelector:@selector(showElements:hideElements:)]) {
				[self.delegate showElements:[NSArray arrayWithObject:[_outerPanel objectAtIndex:selectionIndex + 1]] hideElements: [NSArray arrayWithObject:found]];
			}
		}
    }
}
@end

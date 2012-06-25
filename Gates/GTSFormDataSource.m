#import "GTSFormDataSource.h"
#import "GTSForm.h"
#import "GTSFormTableView.h"
#import "GTSFormTextFieldCell.h"
#import "GTSRowElement.h"
#import "GTSSection.h"

@implementation GTSFormDataSource {
	__weak GTSFormTableView *owner;
}

@synthesize form = _form;

- (GTSForm *)form {
	return [[GTSProjectFormEngine sharedInstance] form];
}

- (id)initWithTableView:(GTSFormTableView *)aTableView {
    self = [super init];
    if (self) {
		owner = aTableView;
		
		GTSProjectFormEngine *engine = [GTSProjectFormEngine sharedInstance];
		engine.delegate = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.form sectionsCount];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[self.form.sections objectAtIndex:section] title];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	GTSSection *formSection = [self.form.sections objectAtIndex:section];
	return formSection.hidden? 0 : formSection.visibleElementsCount;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	GTSFormTableView *table = [self convertToTableView:aTableView];
    
    GTSSection *section = [self.form.sections objectAtIndex:indexPath.section];
    GTSRowElement *element = [section elementAtIndex:indexPath.row];
    
    return [element getCellForTableView:table];
}

- (void)reloadAnElement:(GTSRowElement *)element {
	GTSFormCell *cell = (GTSFormCell *)[owner cellForElement:element];
	[cell updateCellFromElement];
	[cell setNeedsDisplay];
}

- (void)showElements:(NSArray *)elementsToShow hideElements:(NSArray *)elementsToHide {
	NSLog(@"show : %@, hide: %@", elementsToShow, elementsToHide);
	
    NSMutableArray *removeIndices = [NSMutableArray array];
    for (GTSRowElement *element in elementsToHide) {
        NSInteger section = [self.form.sections indexOfObject:element.section];
		
        NSInteger row = [element.section visibleIndexOfElement:element];
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        
		if (!element.section.isHidden) {
			[removeIndices addObject:path];
		}
    }
	
	for (GTSRowElement *element in elementsToHide) {
        element.hidden = YES;
    }
	
	for (GTSRowElement *element in elementsToShow) {
        element.hidden = NO;
    }
	
	NSMutableArray *insertIndices = [NSMutableArray array];
	for (GTSRowElement *element in elementsToShow) {
        NSInteger section = [self.form.sections indexOfObject:element.section];
		
        NSInteger row = [element.section visibleIndexOfElement:element];
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        
		if (!element.section.isHidden) {
			[insertIndices addObject:path];
		}
    }

	if (!insertIndices.count && !removeIndices.count) {
		return;
	}

	NSLog(@"insert : %@, delete: %@", insertIndices, removeIndices);
	[owner beginUpdates];
	if (insertIndices.count) {
		[owner insertRowsAtIndexPaths:insertIndices withRowAnimation:UITableViewScrollPositionBottom];
	}
	
	if (removeIndices.count) {
		[owner deleteRowsAtIndexPaths:removeIndices withRowAnimation:UITableViewRowAnimationTop];
	}
	[owner endUpdates];
}
@end

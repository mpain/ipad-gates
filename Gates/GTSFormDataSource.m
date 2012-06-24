#import "GTSFormDataSource.h"
#import "GTSForm.h"
#import "GTSFormTableView.h"
#import "GTSFormTextFieldCell.h"
#import "GTSRowElement.h"
#import "GTSSection.h"

@implementation GTSFormDataSource {
	__weak GTSFormTableView *owner;
}

@synthesize form;

- (id)initWithTableView:(GTSFormTableView *)aTableView {
    self = [super init];
    if (self) {
		owner = aTableView;
		
		GTSProjectFormEngine *engine = [GTSProjectFormEngine sharedInstance];
        form = engine.form;
		engine.delegate = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [form sectionsCount];	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[form.sections objectAtIndex:section] title];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	GTSSection *formSection = [form.sections objectAtIndex:section];
	return formSection.hidden? 0 : formSection.visibleElementsCount;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	GTSFormTableView *table = [self convertToTableView:aTableView];
    
    GTSSection *section = [form.sections objectAtIndex:indexPath.section];
    GTSRowElement *element = [section elementAtIndex:indexPath.row];
    
    return [element getCellForTableView:table];
}

- (void)reloadAnElement:(GTSRowElement *)element {
	GTSFormCell *cell = (GTSFormCell *)[owner cellForElement:element];
	[cell updateCellFromElement];
	[cell setNeedsDisplay];
}

- (void)showOrHideElements:(NSArray *)elements {
    NSMutableArray *insertIndices = [NSMutableArray array];
    NSMutableArray *removeIndices = [NSMutableArray array];
    
    for (GTSRowElement *element in elements) {
        if (element.section.isHidden) {
            continue;
        }
        
        NSInteger section = [form.sections indexOfObject:element.section];
        NSInteger row = [element.section.elements indexOfObject:element];
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        if (element.isHidden) {
            [removeIndices addObject:path];
        } else {
            [insertIndices addObject:path];
        }
        
        if (!insertIndices.count && !removeIndices.count) {
            return;
        }
        
        [owner beginUpdates];
        if (insertIndices.count) {
            [owner insertRowsAtIndexPaths:insertIndices withRowAnimation:UITableViewScrollPositionBottom];
        }
        
        if (removeIndices.count) {
            [owner deleteRowsAtIndexPaths:removeIndices withRowAnimation:UITableViewRowAnimationTop];
        }
        [owner endUpdates];
    }
}
@end

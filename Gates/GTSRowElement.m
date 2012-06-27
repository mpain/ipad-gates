#import "GTSRowElement.h"
#import "GTSFormTableView.h"
#import "GTSFormCell.h"

@implementation GTSRowElement

@synthesize section;
@synthesize delegate;

@synthesize fetchKey;

- (NSString *)cellReusableIdentifier {
	return nil;
}

- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView {
	id cell = [tableView dequeueReusableCellWithIdentifier:[self cellReusableIdentifier]];
    
    if ([cell respondsToSelector:@selector(updateCellForElement:andTableView:)]) {
        [cell performSelector:@selector(updateCellForElement:andTableView:) withObject:self withObject:tableView];
    }
    
    return cell;
}


@end

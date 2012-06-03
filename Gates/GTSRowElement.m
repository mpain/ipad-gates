#import "GTSRowElement.h"
#import "GTSFormTableView.h"
#import "GTSFormCell.h"

@implementation GTSRowElement

@synthesize section;
@synthesize delegate;

- (NSString *)cellReusableIdentifier {
	return nil;
}

- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView {
	GTSFormCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellReusableIdentifier]];
    
    return cell;
}

@end

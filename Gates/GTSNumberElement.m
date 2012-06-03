#import "GTSNumberElement.h"
#import "GTSNumberCell.h"

@implementation GTSNumberElement

@synthesize number;
@synthesize fractionDigits;

- (NSString *)cellReusableIdentifier {
    return @"GTSNumberCellIdentifier";
}

- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView {
    GTSNumberCell *cell = (GTSNumberCell *)[super getCellForTableView:tableView];
    [cell updateCellForElement:self andTableView:tableView];
    return cell;
}
@end

#import "GTSFormDataSource.h"
#import "GTSFormTableView.h"

#import "GTSFormTextFieldCell.h"

@implementation GTSFormDataSource {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"Header: %d", section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	GTSFormTableView *table = [self convertToTableView:aTableView];
	
	GTSFormTextFieldCell *cell = (GTSFormTextFieldCell *)[table dequeueReusableCellWithIdentifier:@"GTSNumberCell"];
	cell.label.text = [NSString stringWithFormat:@"Section: %d, Row: %d", indexPath.section, indexPath.row];
	cell.textField.text = @"SimpleText";
	return cell;
}

@end

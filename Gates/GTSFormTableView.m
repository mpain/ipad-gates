#import "GTSFormTableView.h"
#import "GTSColors.h"
#import "GTSFormDataSource.h"
#import "GTSForm.h"
#import "GTSSection.h"
#import "GTSFormTableViewDelegate.h"

@implementation GTSFormTableView {
	id <UITableViewDataSource> formDataSource;
    id <UITableViewDelegate> formDelegate;
}

- (void)awakeFromNib {	
	formDataSource = [[GTSFormDataSource alloc] initWithTableView:self];
	self.dataSource = formDataSource;
	
	formDelegate = [[GTSFormTableViewDelegate alloc] initWithTableView:self];
	self.delegate = formDelegate;
	

	//self.backgroundColor = [UIColor gtsTableBackgroundColor];
	self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.separatorColor = [UIColor lightGrayColor];
	/*
	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper.png"]];
	self.backgroundView.contentMode = UIViewContentModeTopLeft;
	*/
}

- (GTSForm *)form {
    return [(GTSFormDataSource *)formDataSource form];
}

- (NSIndexPath *)indexForElement:(GTSRowElement *)element {
    for (NSInteger i = 0; i < [self.form.sections count]; i++) {
        GTSSection *currSection = [self.form.sections objectAtIndex:i];
        
		NSInteger row = [currSection visibleIndexOfElement:element];
		if (row != NSNotFound) {
			return [NSIndexPath indexPathForRow:row inSection:i];
		}
        
    }
    return nil;
}

- (UITableViewCell *)cellForElement:(GTSRowElement *)element {
    return [self cellForRowAtIndexPath:[self indexForElement:element]];
}
@end

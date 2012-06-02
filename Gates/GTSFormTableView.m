#import "GTSFormTableView.h"
#import "GTSFormDataSource.h"
#import "GTSFormTableViewDelegate.h"

@implementation GTSFormTableView {
	id <UITableViewDataSource> formDataSource;
    id <UITableViewDelegate> formDelegate;
}

- (void)awakeFromNib {
	formDataSource = [GTSFormDataSource new];
	self.dataSource = formDataSource;
	
	formDelegate = [GTSFormTableViewDelegate new];
	self.delegate = formDelegate;
	
	/*
	self.backgroundColor = [UIColor clearColor];
	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper.png"]];
	self.backgroundView.contentMode = UIViewContentModeTopLeft;
	*/
}

@end

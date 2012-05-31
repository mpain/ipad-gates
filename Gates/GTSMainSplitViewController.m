#import "GTSMainSplitViewController.h"
#import "GTSAppDelegate.h"

@interface GTSMainSplitViewController ()
@end

@implementation GTSMainSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	GTSAppDelegate *application = (GTSAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self pushToMasterController:[application.storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"]];
	[self pushToDetailController:[application.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


@end

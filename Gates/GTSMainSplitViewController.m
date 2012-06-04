#import "GTSMainSplitViewController.h"
#import "GTSProjectDialogController.h"
#import "GTSAppDelegate.h"

@interface GTSMainSplitViewController ()
@end

@implementation GTSMainSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	GTSAppDelegate *application = (GTSAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self pushToMasterController:[application.storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"]];
	
	GTSProjectDialogController *controller = [application.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
	self.title = controller.title;
	[self pushToDetailController:controller];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


@end

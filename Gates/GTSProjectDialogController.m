#import "GTSProjectDialogController.h"
#import "GTSAppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface GTSProjectDialogController ()

@end

@implementation GTSProjectDialogController

- (void)awakeFromNib {
	self.title = NSLocalizedString(@"PROJECTS_TITLE", nil);
}

- (void)createNavigationBarButtons {
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMoreItem)];
	
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	space.width = 10;
	
	UIBarButtonItem *removeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeItem)];
	
	UIBarButtonItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	space2.width = 10;
	
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshItem)];
	
	self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:addButton, space, removeButton, space2, refreshButton, nil];
}

- (void)viewWillAppear:(BOOL)animated { 
	
    [super viewWillAppear:animated]; 
	[self createNavigationBarButtons];
    [self.navigationController setToolbarHidden:NO animated:YES]; 
	
	UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	fixedSpace.width = 20;
	
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:nil];
	UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(handleButtonTakeAPhoto)];
	
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:0]; 
	
	[items addObject:cameraItem];
	[items addObject:fixedSpace];
    [items addObject:deleteItem];

    [self setToolbarItems:items animated:YES]; 
}  

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller usingDelegate: (id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate {
	
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)	||
			(delegate == nil) ||
		(controller == nil)) {
		return NO;
	}
        
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
	cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
	
    [controller presentModalViewController:cameraUI animated:YES];
    return YES;
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
	GTSAppDelegate *delegate = (GTSAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate.window.rootViewController dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
	
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
	
    if (CFStringCompare((__bridge CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
		
        editedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
		
        imageToSave = editedImage ? editedImage : originalImage;
 		
       UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    }
	
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0)	== kCFCompareEqualTo) {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
        }
    }
	
	GTSAppDelegate *delegate = (GTSAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate.window.rootViewController dismissModalViewControllerAnimated:YES];
}

- (void) handleButtonTakeAPhoto {
	GTSAppDelegate *delegate = (GTSAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self startCameraControllerFromViewController:delegate.window.rootViewController usingDelegate:self];
}
@end

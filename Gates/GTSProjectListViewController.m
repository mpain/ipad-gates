#import "GTSProjectListViewController.h"
#import "GTSProjectsService.h"
#import "GTSProject.h"

enum Sections {
	kSectionProjects = 0,
	NUM_SECTIONS
};


@implementation GTSProjectListViewController {
	__strong NSMutableArray *_projects;
}

- (void)viewDidLoad {
	_projects = [[GTSProjectsService sharedInstance] projects];
	[self createNavigationBarButtons];
}

- (UIBarButtonItem *)createNavigationBarSpacer {
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	space.width = 10;
    return space;
}

- (void)createNavigationBarButtons {
	UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createProject)];
	
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshProjectsList)];
	
	self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:createButton, [self createNavigationBarSpacer],  refreshButton, nil];
}

- (UITableView *)tableView {
	return (UITableView *)self.view;
}
			
#pragma mark - Navigation bar button handlers

- (void)createProject {
	GTSProject *newProject = [GTSProject new];
	newProject.title = @"Project";
	newProject.address = @"Address";
	
	[_projects insertObject:newProject atIndex:0];
	[((UITableView *)self.view) insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:kSectionProjects]] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)refreshProjectsList {
	for (GTSProject *project in _projects) {
		if (!project.version) {
			project.version = kProjectVersion;
			[[GTSProjectsService sharedInstance] saveProject:project];
		}
	}
	_projects = [[GTSProjectsService sharedInstance] projects];
	[self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (section == kSectionProjects) ? _projects.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CELL_IDENTIFIER = @"GTSProjectCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    GTSProject *project = [_projects objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = project.address;
	cell.textLabel.text = project.title;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		GTSProject *project = [_projects objectAtIndex:indexPath.row];
		[[GTSProjectsService sharedInstance]removeProject:project];
		 _projects = [[GTSProjectsService sharedInstance] projects];
        
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }  else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }   
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end

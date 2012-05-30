//
//  GTSDetailViewController.h
//  Gates
//
//  Created by Sergey Samoylov on 5/30/12.
//  Copyright (c) 2012 IT Territory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTSDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

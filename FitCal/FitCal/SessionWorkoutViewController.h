//
//  SessionWorkoutViewController.h
//  FitCal
//
//  Created by Prabhat Godse on 7/3/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionTableViewCell.h"

@interface SessionWorkoutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SessionTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *sessionFooterView;

@end

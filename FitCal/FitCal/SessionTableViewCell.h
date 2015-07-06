//
//  SessionTableViewCell.h
//  FitCal
//
//  Created by Prabhat Godse on 7/3/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SessionTableViewCell;

@protocol SessionTableViewCellDelegate <NSObject>

- (void)sessionCell:(SessionTableViewCell*)cell weightChange:(CGFloat)change;

- (void)sessionCellLongPress:(SessionTableViewCell *)cell;

@end
@interface SessionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *workoutTitle;
@property (weak, nonatomic) IBOutlet UILabel *setsLabel;

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeWeight;

@property (weak, nonatomic) id delegate;
+ (CGFloat)getRowHeight;
@end

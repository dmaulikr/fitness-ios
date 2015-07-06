//
//  AddWorkoutViewController.h
//  FitCal
//
//  Created by Prabhat Godse on 7/4/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddWorkoutViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>
- (IBAction)onAddWorkoutButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *workoutNameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *repsPickerView;
@end

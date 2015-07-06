//
//  AddWorkoutViewController.m
//  FitCal
//
//  Created by Prabhat Godse on 7/4/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import "AddWorkoutViewController.h"
#import "FitnessDB.h"

@interface AddWorkoutViewController ()

@end

@implementation AddWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"Add workout";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddWorkoutButton:(id)sender {
    //Save workout in session and exit
    NSManagedObjectContext *dbCtx = [FitnessDB getDB].managedObjectContext;
    
    //Get the sets
    NSInteger s1 = [self.repsPickerView selectedRowInComponent:0];
    NSInteger s2 = [self.repsPickerView selectedRowInComponent:1];
    NSInteger s3 = [self.repsPickerView selectedRowInComponent:2];;
    
    NSString *sets = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)s1, (long)s2, (long)s3];
    
    NSManagedObject *workout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:dbCtx];
    [workout setValue:sets forKey:@"sets"];
    [workout setValue:@0 forKey:@"weight"];
    [workout setValue:self.workoutNameTextField.text forKey:@"workout_title"];
    
    [[FitnessDB getDB] saveContent];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"workout_added" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSArray* components = [textView.text componentsSeparatedByString:@"\n"];
    if ([components count] > 0) {
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark UIPIckerView Protocols
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 100;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%ld", (long)row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.workoutNameTextField resignFirstResponder];
}
@end

//
//  SessionWorkoutViewController.m
//  FitCal
//
//  Created by Prabhat Godse on 7/3/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import "SessionWorkoutViewController.h"
#import "FitnessDB.h"
#import "AddWorkoutViewController.h"

@interface SessionWorkoutViewController () {
    NSArray *_workoutList;
}

@end

@implementation SessionWorkoutViewController
#define REUSE_ID @"session_cell_id"
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddButton:)];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateOnWorkoutAdded)
                                                 name:@"workout_added"
                                               object:nil];
    
    _workoutList = @[];
    [self loadWorkoutFromDB];
    
    UINib *nib = [UINib nibWithNibName:@"SessionTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:REUSE_ID];
    
    
    self.tableView.tableFooterView = self.sessionFooterView;
    
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWorkoutFromDB {
    NSManagedObjectContext *dbCtx = [FitnessDB getDB].managedObjectContext;
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:dbCtx];
    [fetch setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedArray = [dbCtx executeFetchRequest:fetch error:&error];
    _workoutList = fetchedArray;
//    for (NSManagedObject *obj in fetchedArray) {
//        NSLog(@"Weight: %@", [obj valueForKey:@"sets"]);
//        NSLog(@"Weight: %@", obj[@"workout_title"]);
//    }
}

- (void)updateOnWorkoutAdded {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self loadWorkoutFromDB];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *path = [NSIndexPath indexPathForRow:_workoutList.count-1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView reloadData];
        });
    });
}
#pragma mark TableView Protocols
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _workoutList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SessionTableViewCell *cell = (SessionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:REUSE_ID forIndexPath:indexPath];
    cell.delegate = self;
    
    NSManagedObject *wt = [_workoutList objectAtIndex:indexPath.row];
    cell.workoutTitle.text = [wt valueForKey:@"workout_title"];
    cell.setsLabel.text = [wt valueForKey:@"sets"];
    CGFloat weight = [[wt valueForKey:@"weight"] doubleValue];
    cell.weightLabel.text = [NSString stringWithFormat:@"Weight: %.1f lbs", weight];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SessionTableViewCell getRowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *obj = [_workoutList objectAtIndex:indexPath.row];
        
        [[FitnessDB getDB].managedObjectContext deleteObject:obj];
        [[FitnessDB getDB] saveContent];
        [self loadWorkoutFromDB];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
#pragma mark Session Cell Protocols
- (void)sessionCell:(SessionTableViewCell *)cell weightChange:(CGFloat)change {
    NSIndexPath *iPath = [self.tableView indexPathForCell:cell];
    NSManagedObject *wt = [_workoutList objectAtIndex:iPath.row];
    
    CGFloat weight = [[wt valueForKey:@"weight" ] doubleValue];
    
    if(weight + change <= 0.0) return;
    
    weight += change;
    [wt setValue:[NSNumber numberWithDouble:weight] forKey:@"weight"];
    [[FitnessDB getDB] saveContent];
    cell.weightLabel.text = [NSString stringWithFormat:@"Weight: %.1f lbs", weight];
    cell.weightLabel.textColor = change > 0.0 ? [UIColor greenColor] : [UIColor redColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.weightLabel.textColor = [UIColor whiteColor];
    });
}

- (void)sessionCellLongPress:(SessionTableViewCell *)cell {
    [self.tableView setEditing:YES animated:YES];
}


#pragma mark Action Buttons
- (void)onAddButton:(id)sender {
    AddWorkoutViewController *addVC = [[AddWorkoutViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}
@end

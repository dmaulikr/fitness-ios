//
//  ViewController.m
//  FitCal
//
//  Created by Prabhat Godse on 2/15/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import "ViewController.h"
#import "WeekCollectionViewCell.h"
#import "SessionWorkoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#define RESUSE_ID @"weekly_workout_cell"
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _weeklyWorkout = @[@"Bulging Arms", @"Boulder Shoulders", @"Back Shield", @"Ripped Abs", @"Arnold Chest"];
    
    [self.weeklyCollectionView registerClass:[WeekCollectionViewCell class] forCellWithReuseIdentifier:RESUSE_ID];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.weeklyCollectionView.frame.size.width, 100);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.weeklyCollectionView setCollectionViewLayout:flowLayout];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddButton:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Actions
- (IBAction)onAddButton:(id)sender {
    
}

#pragma mark CollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //7 days in a week. Duh!
    return [_weeklyWorkout count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeekCollectionViewCell *cell = (WeekCollectionViewCell*)
                                [collectionView dequeueReusableCellWithReuseIdentifier:RESUSE_ID
                                                                          forIndexPath:indexPath];
    cell.dayTitle.text = [_weeklyWorkout objectAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SessionWorkoutViewController *sessionVC = [[SessionWorkoutViewController alloc] init];
    [self.navigationController pushViewController:sessionVC animated:YES];
}
@end

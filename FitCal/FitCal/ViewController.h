//
//  ViewController.h
//  FitCal
//
//  Created by Prabhat Godse on 2/15/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    NSArray *_weeklyWorkout;
}

@property (weak, nonatomic) IBOutlet UICollectionView *weeklyCollectionView;

@end


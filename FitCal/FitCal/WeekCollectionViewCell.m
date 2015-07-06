//
//  WeekCollectionViewCell.m
//  FitCal
//
//  Created by Prabhat Godse on 2/15/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import "WeekCollectionViewCell.h"

@implementation WeekCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WeekCollectionViewCell"
                                                              owner:self
                                                            options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}
@end

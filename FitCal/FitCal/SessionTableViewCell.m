//
//  SessionTableViewCell.m
//  FitCal
//
//  Created by Prabhat Godse on 7/3/15.
//  Copyright (c) 2015 biodigital. All rights reserved.
//

#import "SessionTableViewCell.h"

@implementation SessionTableViewCell

#define WEIGHT_DELTA 2.5
- (void)awakeFromNib {
    // Initialization code
    [self.changeWeight addTarget:self action:@selector(onWeightChange:) forControlEvents:UIControlEventValueChanged];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(onLongPress:)];
    longPress.minimumPressDuration = 1.0f;
    [self addGestureRecognizer:longPress];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)onWeightChange:(UISegmentedControl*)segment {
    if ([self.delegate respondsToSelector:@selector(sessionCell:weightChange:)]) {
        CGFloat delta = segment.selectedSegmentIndex == 1 ? WEIGHT_DELTA : -1.0 * WEIGHT_DELTA;
        [self.delegate sessionCell:self weightChange:delta];
    }
}

- (void)onLongPress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sessionCellLongPress:)]) {
        [self.delegate sessionCellLongPress:self];
    }
}

+ (CGFloat)getRowHeight {
    return 115.0;
}
@end

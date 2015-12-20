//
//  TSButton.m
//  ThoughtSharing
//
//  Created by Rijo George on 16/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import "TSButton.h"

@implementation TSButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = 5.0;
    self.clipsToBounds = YES;
}


@end

//
//  TSTextField.m
//  ThoughtSharing
//
//  Created by Rijo George on 14/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import "TSTextField.h"

@implementation TSTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
     self.layer.cornerRadius = 5.0;
}



- (instancetype)initWithCoder:(NSCoder *)aDecoder{
   
    self.layer.borderWidth = 2.0;
    self.clipsToBounds = YES;
    return [super initWithCoder:aDecoder];
    
}
@end

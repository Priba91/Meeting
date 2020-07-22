//
//  FilterCellView.m
//  Convoy Caravan
//
//  Created by Priba on 9/30/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "FilterCellView.h"
#import "ColorDefinitions.h"
@implementation FilterCellView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.width/2];
    [self.checkedImageView.layer setCornerRadius:self.checkedImageView.frame.size.height/2];
    [self.checkedImageView setBackgroundColor:BASE_BAR_COLOR1];
}

- (IBAction)changeState:(id)sender {
    self.state = !self.state;
    if(self.state){
        [self.checkedImageView setHidden:NO];
    }else{
        [self.checkedImageView setHidden:YES];
    }
}


@end

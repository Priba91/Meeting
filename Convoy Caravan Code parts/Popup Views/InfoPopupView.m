//
//  InfoPopupView.m
//  Convoy Caravan
//
//  Created by Priba on 9/8/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "InfoPopupView.h"
#import "ColorDefinitions.h"
#import "Utils.h"

@implementation InfoPopupView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.backView.layer setCornerRadius:8];
    
    [self.dismissBtn setBackgroundColor:BASE_BAR_COLOR1];
    [self.dismissBtn setTintColor:[UIColor whiteColor]];
    [Utils addHalfHightCornerRadiusToView:self.dismissBtn];
}

@end

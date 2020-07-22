//
//  ReviewPlaceTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 11/1/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "ReviewPlaceTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
#import "LanguageManager.h"

@implementation ReviewPlaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.backView.layer setCornerRadius:8];
    self.backView.layer.shadowRadius = 3.5f;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    self.backView.layer.shadowOpacity = 0.2f;
    self.backView.layer.masksToBounds = NO;
    
    [Utils addHalfHightCornerRadiusToView:self.reviewBtn];
    [self.reviewHolderView setUserInteractionEnabled:NO];
    [Utils addGradientToView:self.reviewBtn];

}

- (void)populateWithPlace:(PlaceModel*)place{
    
    self.titleLbl.text = [LanguageManager setLanguageString:@"review"];
    self.reviewsCountLbl.text = [NSString stringWithFormat:@"%ld %@", (long)place.reviewsCount, [LanguageManager setLanguageString:@"reviews"]];

    self.reviewRateLbl.text = [NSString stringWithFormat:@"%.1lf", place.avgRate];
    [self.reviewHolderView setRating:place.avgRate];

    self.bottomLbl.text = [LanguageManager setLanguageString:@"you_have_been_here_to"];
    [self.reviewBtn setTitle:[LanguageManager setLanguageString:@"leave_review"] forState:UIControlStateNormal];
}
@end

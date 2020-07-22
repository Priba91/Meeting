//
//  PlaceHeaderView.m
//  Convoy Caravan
//
//  Created by Priba on 1/24/19.
//  Copyright © 2019 Priba. All rights reserved.
//

#import "PlaceHeaderView.h"
#import "ColorDefinitions.h"
#import "LanguageManager.h"
#import "ServerCommunicationManager.h"
#import "DataManager.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"


@implementation PlaceHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.placeImageView.layer setCornerRadius:8];
    [self.headerRateView setUserInteractionEnabled:NO];
    [self.headerRateView setRating:self.place.avgRate];
    [self.coverImageLayerView setBackgroundColor:[BASE_BAR_COLOR1 colorWithAlphaComponent:1.0]];
    //[Utils addGradientToView:self.headerCheckInBtn];
    [Utils addHalfHightCornerRadiusToView:self.headerCheckInBtn];

    [self.headerCheckInBtn setTitle:[LanguageManager setLanguageString:@"check_in"] forState:UIControlStateNormal];

    [self.infoBtn setTitle:[[LanguageManager setLanguageString:@"info"] uppercaseString] forState:UIControlStateNormal];
    [self.infoBtn setBackgroundColor:BASE_BAR_COLOR1];
    
    [self.reviewsBtn setTitle:[[LanguageManager setLanguageString:@"reviews"] uppercaseString] forState:UIControlStateNormal];
    [self.reviewsBtn setBackgroundColor:BASE_BAR_COLOR1];
    
    [self.activityBtn setTitle:[[LanguageManager setLanguageString:@"activity"] uppercaseString] forState:UIControlStateNormal];
    [self.activityBtn setBackgroundColor:BASE_BAR_COLOR1];
    
    [self.indicatorView setBackgroundColor:MAIN_ROUTE_COLOR];
}

- (void)setRating:(double)rating{
    self.headerRateView.hidden = NO;
    [self.headerRateView setRating:rating];
}

- (void)setPlaceDetails:(PlaceModel*)place{
    self.place = place.copy;
    
    [self.placeImageView sd_setImageWithURL:[NSURL URLWithString:self.place.imageUrl]
                           placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                    options:SDWebImageRefreshCached];
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.place.coverImageUrl] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image != nil){
            [self.coverDefaultImageView setHidden:YES];
            [self.coverImageLayerView setBackgroundColor:[BASE_BAR_COLOR1 colorWithAlphaComponent:0.6]];
        }
    }];
    self.placeNameLbl.text = self.place.name;
    [self.categotyBtn setTitle:self.place.categoryName forState:UIControlStateNormal];
}

- (IBAction)backBtnAction:(id)sender {
    [self.delegate headerBackAction];
}

- (IBAction)editBtnAction:(id)sender {
    [self.delegate headerEditAction];
}

- (IBAction)checkInBtnAction:(id)sender {
    [self.delegate headerCheckInAction];
}

- (IBAction)categoryBtnAction:(id)sender {
    [self.delegate openCategotyAction];
}

- (IBAction)infoBtnAction:(id)sender {
    [self.delegate headerInfoAction];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorLeftConstraint.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (IBAction)reviewsBtnAction:(id)sender {
    [self.delegate headerReviewAction];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorLeftConstraint.constant = self.infoBtn.frame.size.width;
        [self layoutIfNeeded];
    }];
}

- (IBAction)activityBtnAction:(id)sender {
    [self.delegate headerActivityAction];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorLeftConstraint.constant = 2 * self.infoBtn.frame.size.width;
        [self layoutIfNeeded];
    }];
}


@end

//
//  RoutePlaceTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/3/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "RoutePlaceTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
#import "ColorDefinitions.h"
#import "FeaturesModel.h"

@implementation RoutePlaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.distanceLbl setTextColor:BASE_BAR_COLOR1];
    [self.placeImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.rateView setUserInteractionEnabled:NO];
    [Utils addHalfHightCornerRadiusToView:self.checkImageView];
}

- (void)populateCellWith:(PlaceModel*)place{
    
    self.distanceLbl.text = [Utils makeDistanceString:place.distance];
    self.placeTitleLbl.text = place.name;
    self.categortyTitleLbl.text = place.categoryName;
    [self.placeImageView sd_setImageWithURL:[NSURL URLWithString:place.imageUrl]
                           placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                    options:SDWebImageRefreshCached];
    [self.rateView setRating:place.avgRate];
    
    for (int i = 0; i < self.featuresIVArray.count; i++) {
        [[self.featuresIVArray objectAtIndex:i] setImage: [UIImage imageNamed:@""]];

        if(i < place.featuresArray.count){
            FeaturesModel *model = [place.featuresArray objectAtIndex:i];
            [[self.featuresIVArray objectAtIndex:i] sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [[self.featuresIVArray objectAtIndex:i] setImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            }];
        }
        
    }
    
    if(place.isSelected){
        [self setBackgroundColor:[BASE_BAR_COLOR1 colorWithAlphaComponent:0.15]];
        [self.checkImageView setHidden:NO];
    }else{
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.checkImageView setHidden:YES];
    }
}


@end

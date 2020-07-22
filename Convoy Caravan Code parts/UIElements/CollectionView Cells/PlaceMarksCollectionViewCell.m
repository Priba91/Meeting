//
//  PlaceMarksCollectionViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/31/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "PlaceMarksCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ColorDefinitions.h"

@implementation PlaceMarksCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.iconImageView.layer setCornerRadius:2];

}

-(void)populateCellWithMedal:(FeaturesModel*)feature{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:feature.image] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }];
    self.titleLbl.text = feature.name;
    if(feature.checked){
        [self.iconImageView setTintColor:MAIN_ROUTE_COLOR];
        [self.titleLbl setTextColor:MAIN_ROUTE_COLOR];
    }else{
        [self.iconImageView setTintColor:[UIColor darkGrayColor]];
        [self.titleLbl setTextColor:[UIColor darkGrayColor]];
    }
}

@end

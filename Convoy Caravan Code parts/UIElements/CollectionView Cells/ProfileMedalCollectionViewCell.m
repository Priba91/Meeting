//
//  ProfileMedalCollectionViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/23/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "ProfileMedalCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ProfileMedalCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    //[self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.height/2];
    
}

-(void)populateCellWithMedal:(MedalModel*)medal{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:medal.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if(image){
            if(medal.isEarn){
                [self.iconImageView setImage:image];
            }else{
                [self.iconImageView setImage:[UIImage imageNamed:@"medalEmpty"]];
                //[self.iconImageView setImage:[Utils convertImageToGrayScale:image]];
            }
        }
        
    }];

}

@end

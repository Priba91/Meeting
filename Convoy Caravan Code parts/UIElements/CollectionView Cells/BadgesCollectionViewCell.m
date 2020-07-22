//
//  BadgesCollectionViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 12/16/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "BadgesCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation BadgesCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
//    self.iconViewWidth.constant = [Utils sizeForGridImagesCollectionView].height - 41;
//    self.iconViewHeight.constant = [Utils sizeForGridImagesCollectionView].height - 41;

    //Ø[self.iconImageView.layer setCornerRadius:self.iconViewWidth.constant/2];
}

-(void)populateCellWithMedal:(MedalModel*)medal{
    self.titleLbl.text = [medal.name uppercaseString];
    
    if(![medal.name containsString:@" "]){
        [self.titleLbl setNumberOfLines:1];
    }else{
        [self.titleLbl setNumberOfLines:3];
    }
                          
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:medal.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        if(image){
            if(medal.isEarn){
                [self.iconImageView setImage:image];
            }else{
                [self.iconImageView setImage:[UIImage imageNamed:@"medalEmpty"]];
            }
        }

    }];
    
}
@end

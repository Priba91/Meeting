//
//  AchivmentProfileTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/24/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "AchivmentProfileTableViewCell.h"
#import "LanguageManager.h"
#import "Utils.h"
#import "UIImageView+WebCache.h"

@implementation AchivmentProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //[self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.height/2];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.iconImageView setClipsToBounds:YES];
}


-(void)populateWithAchivment:(AchivmentModel*)achivement{
    self.titleLbl.text = achivement.name;
    self.messageLbl.text = achivement.achiDescription;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:achivement.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if(image != nil){
            if(achivement.isEarn){
                [self.iconImageView setImage:image];
            }else{
                [self.iconImageView setImage:[UIImage imageNamed:@"medalEmpty"]];
            }
        }
    }];
}

@end

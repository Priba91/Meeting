//
//  MedalHeaderTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/24/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "MedalHeaderTableViewCell.h"
#import "LanguageManager.h"
#import "Utils.h"
#import "UIImageView+WebCache.h"
#import "ColorDefinitions.h"

@implementation MedalHeaderTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    //[self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.height/2];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.iconImageView setClipsToBounds:YES];
    
    [self.progressBackBar setBackgroundColor:BACKGROUND_GRAY_COLOR];
    [self.progressBar setBackgroundColor:BASE_BAR_COLOR1];
    
    [Utils addCornerRadiusToView:self.progressBackBar radius:8];
    [Utils addCornerRadiusToView:self.progressBar radius:8];
    
    [self.earnedBackView.layer setCornerRadius:8];
}

-(void)populateWithMedal:(MedalModel*)medal{
    
    self.titleLbl.text = medal.name;
    self.messageLbl.text = medal.medalDesc;
    
    if(![medal.hint isEqualToString:@""]){
        NSString *hint = [NSString stringWithFormat:@"%@ %@", [LanguageManager setLanguageString:@"hint"], medal.hint];
        self.hintLblHeight.constant = [Utils heightWithText:hint andLabel:self.hintLbl];
        self.hintLbl.text = hint;
    }else{
        self.hintLbl.text = @"";
        self.hintLblHeight.constant = 0;
    }
    
    if(medal.level > 0 && medal.type != 1){
        self.levelLbl.text = [NSString stringWithFormat:@"%@ %ld",[LanguageManager setLanguageString:@"level"] ,(long)medal.level];
        self.levelLbl.hidden = NO;
        self.levelLblHeight.constant = 21;
    }else{
        self.levelLbl.text = @"";
        self.levelLbl.hidden = YES;
        self.levelLblHeight.constant = 0;
    }
    
    if(medal.isEarn){
        self.earnedDateLbl.text = [NSString stringWithFormat:@"%@: %@", [LanguageManager setLanguageString:@"unlocked"], medal.createdAt];
        self.earnedBackView.hidden = NO;
        self.earnedDateLbl.hidden = NO;
        self.earnedBackViewHeight.constant = 36;
    }else{
        self.earnedBackView.hidden = YES;
        self.earnedDateLbl.hidden = YES;
        self.earnedBackViewHeight.constant = 0;
    }
    
    if(medal.achivmentArray.count == 0){
        self.progressBackView.hidden = YES;
        self.progressBackViewHeight.constant = 0;
    }else{
        self.progressBackView.hidden = NO;
        self.progressBackViewHeight.constant = 72;
        
        NSInteger numOfEarned = 0;
        
        for (AchivmentModel *achi in medal.achivmentArray) {
            if(achi.isEarn) numOfEarned += 1;
        }
        
        self.progressLbl.text = [NSString stringWithFormat:[LanguageManager setLanguageString:@"achivement_progress"], (long)numOfEarned, (long)medal.achivmentArray.count];
        
        CGFloat singleConst = self.progressBackView.frame.size.width/medal.achivmentArray.count;
        
        self.progressWidth.constant = numOfEarned * singleConst;
        [self layoutIfNeeded];
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:medal.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if(image != nil){
            if(medal.isEarn){
                [self.iconImageView setImage:image];
            }else{
                [self.iconImageView setImage:[UIImage imageNamed:@"medalEmpty"]];
            }
        }
        
    }];
    
    if(medal.isEarn){
        self.hintLbl.text = @"";
        self.hintLblHeight.constant = 0;
    }else{
        self.messageLbl.text = @"";
    }
}

@end

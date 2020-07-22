//
//  ConvoyNotificationTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "ConvoyNotificationTableViewCell.h"
#import "ColorDefinitions.h"
#import "LanguageManager.h"
#import "Utils.h"

@implementation ConvoyNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.iconImageView.layer setCornerRadius:self.iconImageView.frame.size.height/2];
    
    [self.iconImageView setBackgroundColor:BASE_BAR_COLOR2];
    [self.iconImageView setTintColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)populateCellWith:(NotificationModel*)notification{
    
    self.titleLbl.text = [LanguageManager setLanguageString:@"convoy_notification"];
    self.messageLbl.text = notification.systemAlert;
    
    self.timeLbl.text = [Utils makeTimePassString:notification.timePass];

}


@end

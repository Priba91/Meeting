//
//  FriendNotificationTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "FriendNotificationTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ColorDefinitions.h"
#import "Utils.h"
#import "LanguageManager.h"

@implementation FriendNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.userProfileImageView.layer setCornerRadius:self.userProfileImageView.frame.size.height/2];
    [self.notificationIconImageView.layer setCornerRadius:self.notificationIconImageView.frame.size.height/2];
    
    [self.notificationIconImageView setBackgroundColor:BASE_BAR_COLOR1];
    [self.notificationIconImageView setTintColor:[UIColor whiteColor]];
}

- (void)populateCellWith:(NotificationModel*)notification andMessage:(NSString*)message{
    
    if(notification.type == 6){//Achivement
        [self.userProfileImageView sd_setImageWithURL:[NSURL URLWithString:notification.achivment.imageUrl]
                                     placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                              options:SDWebImageRefreshCached];
        
        self.userNameLbl.text = notification.achivment.name;
        self.messageLbl.text = [LanguageManager setLanguageString:@"new_achivment"];
        [self.notificationIconImageView setImage:[UIImage imageNamed:@"achivmentNotificationIcon"]];

        
    }else if(notification.type == 7){//Medal
        [self.userProfileImageView sd_setImageWithURL:[NSURL URLWithString:notification.medal.imageUrl]
                                     placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                              options:SDWebImageRefreshCached];
        
        self.userNameLbl.text = notification.medal.name;
        self.messageLbl.text = [LanguageManager setLanguageString:@"new_medal"];
        
        [self.notificationIconImageView setImage:[UIImage imageNamed:@"medalNotificationIcon"]];

        
    }else if(notification.type == 10){//SOS
        [self.userProfileImageView sd_setImageWithURL:[NSURL URLWithString:notification.sender.avatar]
                                     placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                              options:SDWebImageRefreshCached];
        
        self.userNameLbl.text = [NSString stringWithFormat:@"%@ - SOS", notification.sender.name];
        
        self.messageLbl.text = notification.text;
        [self.notificationIconImageView setImage:[UIImage imageNamed:@"info_medal_icon"]];

        
    }else if(notification.type == 11){//Login
        [self.userProfileImageView setImage:[UIImage imageNamed:@"infoNotification"]];
        
        self.userNameLbl.text = [LanguageManager setLanguageString:@"login"];
        self.messageLbl.text = notification.text;
        
        [self.notificationIconImageView setImage:[UIImage imageNamed:@"info_medal_icon"]];

        
    }else if(notification.type == 12){//Info
        [self.userProfileImageView setImage:[UIImage imageNamed:@"infoNotification"]];
        
        self.userNameLbl.text = [LanguageManager setLanguageString:@"info"];
        self.messageLbl.text = notification.text;
        
        [self.notificationIconImageView setImage:[UIImage imageNamed:@"info_medal_icon"]];

        
    }else{
        [self.userProfileImageView sd_setImageWithURL:[NSURL URLWithString:notification.sender.avatar]
                                     placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                              options:SDWebImageRefreshCached];
        
        self.userNameLbl.text = notification.sender.name;
        self.messageLbl.text = message;
        
        if(notification.type == 3){
            [self.notificationIconImageView setImage:[UIImage imageNamed:@"notificationMessageIcon"]];
        }else{
            [self.notificationIconImageView setImage:[UIImage imageNamed:@"notoficationFriendsIcon"]];
        }
    }

    self.timeLbl.text = [Utils makeTimePassString:notification.timePass];
    
}


@end

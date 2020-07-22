//
//  FriendRequestLoaderTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 3/4/19.
//  Copyright © 2019 Priba. All rights reserved.
//

#import "FriendRequestLoaderTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"

@implementation FriendRequestLoaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.userProfileImageView.layer setCornerRadius:self.userProfileImageView.frame.size.height/2];
    [self.notificationIconImageView.layer setCornerRadius:self.notificationIconImageView.frame.size.height/2];
    [self.spiner setColor:BASE_BAR_COLOR2];
    [self.spiner startAnimating];
    
    [self.notificationIconImageView setTintColor:[UIColor whiteColor]];
    [self.notificationIconImageView setBackgroundColor:BASE_BAR_COLOR2];
    [self.notificationIconImageView setImage:[UIImage imageNamed:@"notoficationFriendsIcon"]];
    
}

- (void)populateCellWith:(NotificationModel*)notification andMessage:(NSString*)message{
    
    [self.userProfileImageView sd_setImageWithURL:[NSURL URLWithString:notification.sender.avatar]
                                 placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                          options:SDWebImageRefreshCached];
    
    self.userNameLbl.text = notification.sender.name;
    self.messageLbl.text = message;
    self.timeLbl.text = [Utils makeTimePassString:notification.timePass];
    
}

- (void)populateCellWith:(UserModel*)user{
    
    [self.userProfileImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar]
                                 placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                          options:SDWebImageRefreshCached];
    
    self.userNameLbl.text = user.name;
    self.messageLbl.text = user.alias;
    
    self.notificationIconImageView.hidden = YES;
    self.timeLbl.hidden = YES;
    
}


@end

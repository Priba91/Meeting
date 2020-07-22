//
//  FriendRequestTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "FriendRequestTableViewCell.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"

@implementation FriendRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.userProfileImageView.layer setCornerRadius:self.userProfileImageView.frame.size.height/2];
    [self.notificationIconImageView.layer setCornerRadius:self.notificationIconImageView.frame.size.height/2];
    [self.denyBtn.layer setCornerRadius:self.confirmBtn.frame.size.height/2];
    [self.confirmBtn.layer setCornerRadius:self.confirmBtn.frame.size.height/2];

    [self.notificationIconImageView setTintColor:[UIColor whiteColor]];
    [self.notificationIconImageView setBackgroundColor:BASE_BAR_COLOR1];
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

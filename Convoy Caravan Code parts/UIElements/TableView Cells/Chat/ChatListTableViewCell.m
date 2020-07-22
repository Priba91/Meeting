//
//  ChatListTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/24/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "ChatListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ColorDefinitions.h"
#import "Utils.h"

@implementation ChatListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.messageLbl setLineBreakMode:NSLineBreakByWordWrapping];
    
    [self.profileImageView.layer setCornerRadius:self.profileImageView.frame.size.height/2];
    [self.countLbl.layer setCornerRadius:self.countLbl.frame.size.height/2];
    [self.countLbl setBackgroundColor:MAIN_ROUTE_COLOR];

}

- (void)populateWithConversation:(ConversationModel*)conversation{
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:conversation.lastReceiver.avatar]
                             placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                      options:SDWebImageRefreshCached];
    self.profileNameLbl.text = conversation.lastReceiver.name;
    self.messageLbl.text = conversation.latestMessage;
    
    if(conversation.unread > 0){
        self.countLbl.hidden = NO;
        self.countLbl.text = [NSString stringWithFormat:@"%ld", conversation.unread];
    }else{
        self.countLbl.hidden = YES;
        self.countLbl.text = @"";
    }
    
    self.timeLbl.text = [Utils makeTimePassShortString:conversation.timePass];

}

@end

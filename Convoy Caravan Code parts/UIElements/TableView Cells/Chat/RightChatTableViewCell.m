//
//  RightChatTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/20/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "RightChatTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ColorDefinitions.h"
#import "Utils.h"

@implementation RightChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.messageLbl setLineBreakMode:NSLineBreakByWordWrapping];
    
    [self.profileImageView.layer setCornerRadius:self.profileImageView.frame.size.height/2];
    [self.backView.layer setCornerRadius:16];
    [self.chatImageView.layer setCornerRadius:8];
    [self.chatImageView setClipsToBounds:YES];
}

- (void)populateWithComment:(CommentModel*)comment{
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.avatar]
                             placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                      options:SDWebImageRefreshCached];
    self.profileNameLbl.text = comment.user.name;
    self.messageLbl.text = comment.comment;
    self.timeLbl.text = [Utils makeTimePassShortString:comment.timePass];
}

- (void)populateWithMessage:(MessageModel*)message{
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:message.sender.avatar]
                             placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                      options:SDWebImageRefreshCached];
    self.profileNameLbl.text = message.sender.name;
    self.messageLbl.text = message.body;
    self.timeLbl.text = [Utils makeTimePassShortString:message.timePass];
    
    if(message.imageWidth > 0){
        self.chatImageHeight.constant = [Utils getImageHeightWithImageWidth:message.imageWidth ImageHeight:message.imageHeight imageViewWidthg:self.chatImageView.frame.size.width];
        self.chatImageView.image = message.image;
    }else{
        self.chatImageHeight.constant = 0;
    }
    
}

@end

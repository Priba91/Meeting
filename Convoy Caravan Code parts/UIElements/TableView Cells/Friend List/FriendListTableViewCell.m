//
//  FriendListTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 10/5/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "FriendListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ColorDefinitions.h"

@implementation FriendListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.rightImageView setTintColor:BASE_BAR_COLOR1];
    [self.userProfileImageView.layer setCornerRadius:self.userProfileImageView.frame.size.height/2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)populateWithUser:(UserModel*)user{
    [self.userProfileImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar]
                           placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                    options:SDWebImageRefreshCached];
    
    self.userNameLbl.text = user.name;
    self.userAliasLbl.text = user.alias;
    
}


@end

//
//  FriendListTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/5/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userAliasLbl;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *cellSelectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;

- (void)populateWithUser:(UserModel*)user;

@end

NS_ASSUME_NONNULL_END

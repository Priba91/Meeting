//
//  FriendRequestTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendRequestTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *notificationIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UIButton *denyBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;

- (void)populateCellWith:(NotificationModel*)notification andMessage:(NSString*)message;
- (void)populateCellWith:(UserModel*)user;

@end

NS_ASSUME_NONNULL_END

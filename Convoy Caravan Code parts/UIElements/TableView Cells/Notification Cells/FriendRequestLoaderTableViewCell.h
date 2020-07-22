//
//  FriendRequestLoaderTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 3/4/19.
//  Copyright © 2019 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendRequestLoaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *notificationIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spiner;

- (void)populateCellWith:(NotificationModel*)notification andMessage:(NSString*)message;
- (void)populateCellWith:(UserModel*)user;

@end

NS_ASSUME_NONNULL_END

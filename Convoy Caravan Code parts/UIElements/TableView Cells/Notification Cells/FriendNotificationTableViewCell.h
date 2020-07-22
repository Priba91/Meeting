//
//  FriendNotificationTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"
#import "MedalModel.h"
#import "AchivmentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendNotificationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *notificationIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

- (void)populateCellWith:(NotificationModel*)notification andMessage:(NSString*)message;

@end

NS_ASSUME_NONNULL_END

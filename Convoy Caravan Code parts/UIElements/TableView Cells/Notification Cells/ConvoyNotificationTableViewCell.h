//
//  ConvoyNotificationTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConvoyNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

- (void)populateCellWith:(NotificationModel*)notification;


@end

NS_ASSUME_NONNULL_END

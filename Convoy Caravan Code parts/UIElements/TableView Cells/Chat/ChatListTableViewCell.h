//
//  ChatListTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/24/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;

- (void)populateWithConversation:(ConversationModel*)conversation;

@end

NS_ASSUME_NONNULL_END

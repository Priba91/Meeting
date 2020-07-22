//
//  RightChatTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/20/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RightChatTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *chatImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatImageHeight;

- (void)populateWithComment:(CommentModel*)comment;
- (void)populateWithMessage:(MessageModel*)message;

@end

NS_ASSUME_NONNULL_END

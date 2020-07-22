//
//  WallTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 9/16/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallPostModel.h"
#import "Cosmos-Swift.h"

@interface WallTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionsViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHight;

@property (weak, nonatomic) IBOutlet UIView *cellMenuView;

@property (weak, nonatomic) IBOutlet UIView *cellOwnerMenuView;
@property (weak, nonatomic) IBOutlet UIButton *deletePostBtn;
@property (weak, nonatomic) IBOutlet UIButton *editPostBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ownerMenuHeight;

@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeListBtn;
@property (weak, nonatomic) IBOutlet UIButton *goToProfileBtn;
@property (weak, nonatomic) IBOutlet UIButton *goToPlaceBtn;
    
@property (weak, nonatomic) IBOutlet UIView *likesView;
@property (weak, nonatomic) IBOutlet UIImageView *likesIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *lastLikedNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *likesOthersCountLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likesViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *commentsCountBtn;

@property (weak, nonatomic) IBOutlet UIView *firstCommentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCommentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *firstCommentAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstComentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstCommentBodyLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstCommentTimeLbl;
@property (weak, nonatomic) IBOutlet UIView *firstCommentHolderView;
    
@property (weak, nonatomic) IBOutlet UIView *secondCommentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCommentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *secCommentAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *secCommentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *secCommentTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *secCommentBodyLbl;
@property (weak, nonatomic) IBOutlet UIView *secCommentHolderView;

@property (weak, nonatomic) IBOutlet UIButton *previewImageBtn;

@property (weak, nonatomic) IBOutlet CosmosView *rateView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rateViewHeight;

@property (nonatomic) BOOL isUserOwner;


- (void)populateWithPost:(WallPostModel*)post;

@end

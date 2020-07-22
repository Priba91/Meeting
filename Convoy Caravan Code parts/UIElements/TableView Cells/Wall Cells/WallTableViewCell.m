//
//  WallTableViewCell.m
//  Convoy Caravan
//
//  Created by Priba on 9/16/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "WallTableViewCell.h"
#import "LanguageManager.h"
#import "ColorDefinitions.h"
#import "UIImageView+WebCache.h"
#import "DataManager.h"
#import "Utils.h"
#import "PostCommentModel.h"

@implementation WallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.profileImageView.layer setCornerRadius:self.profileImageView.frame.size.height/2];

    [self.cellMenuView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.cellMenuView.layer setBorderWidth:0.5];

    [self.placeNameLbl setTextColor:BASE_BAR_COLOR1];
    
    [Utils addHalfHightCornerRadiusToView:self.likeBtn];
    [Utils addHalfHightCornerRadiusToView:self.commentBtn];

    [self.backView.layer setCornerRadius:8];
    self.layer.shadowRadius = 2.5f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.f, 2.f);
    self.layer.shadowOpacity = 0.1f;
    self.layer.masksToBounds = NO;
    
    [self.cellMenuView.layer setCornerRadius:4];
    self.cellMenuView.layer.shadowRadius = 2.5f;
    self.cellMenuView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.cellMenuView.layer.shadowOffset = CGSizeMake(2.f, 2.f);
    self.cellMenuView.layer.shadowOpacity = 0.3f;
    self.cellMenuView.layer.masksToBounds = NO;
    
    [self.cellOwnerMenuView.layer setCornerRadius:4];
    self.cellOwnerMenuView.layer.shadowRadius = 2.5f;
    self.cellOwnerMenuView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.cellOwnerMenuView.layer.shadowOffset = CGSizeMake(2.f, 2.f);
    self.cellOwnerMenuView.layer.shadowOpacity = 0.3f;
    self.cellOwnerMenuView.layer.masksToBounds = NO;
    
    [Utils addHalfHightCornerRadiusToView:self.likesIconImageView];
    self.likesIconImageView.backgroundColor = [UIColor clearColor];

    [self.firstCommentBodyLbl setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.firstCommentAvatarImageView.layer setCornerRadius:self.firstCommentAvatarImageView.frame.size.height/2];
    [self.firstCommentHolderView.layer setCornerRadius:16];
    
    [self.secCommentBodyLbl setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.secCommentAvatarImageView.layer setCornerRadius:self.secCommentAvatarImageView.frame.size.height/2];
    [self.secCommentHolderView.layer setCornerRadius:16];
     
    [self.likesIconImageView setImage:[UIImage imageNamed:@"liked"]];
    
    [self.reportBtn setTitle:[LanguageManager setLanguageString:@"report_btn"] forState:UIControlStateNormal];
    [self.editPostBtn setTitle:[LanguageManager setLanguageString:@"edit_post"] forState:UIControlStateNormal];
    [self.deletePostBtn setTitle:[LanguageManager setLanguageString:@"delete_btn"] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeCellMenu) name:@"closeWallCellMenu" object:nil];

    [self.cellMenuView setHidden:YES];
    [self.cellOwnerMenuView setHidden:YES];
}

- (void)populateWithPost:(WallPostModel*)post{
    
    self.isUserOwner = post.user.userId == [DataManager sharedInstance].logedUser.userId;
    
    if(post.likedByMe){
        [self.likeBtn setImage:[UIImage imageNamed:@"liked"] forState:normal];
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"unliked"] forState:normal];
    }
    
    if(self.isUserOwner){
        if(true){
            self.ownerMenuHeight.constant = 80;
            [self.editPostBtn setHidden:NO];
        }else{
            self.ownerMenuHeight.constant = 40;
            [self.editPostBtn setHidden:YES];
        }
    }
    
    [self.likeBtn setTitle:[LanguageManager setLanguageString:@"honk"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[LanguageManager setLanguageString:@"comments"] forState:UIControlStateNormal];
    
    self.profileNameLbl.text = post.user.name;
    self.postTimeLbl.text = [Utils makeTimePassShortString:post.timePass];
    self.messageLbl.text = post.body;
    
    if([post.imageUrl isEqualToString:@""]){
        self.imageViewHight.constant = 0;
    }else{
        self.imageViewHight.constant = [Utils getWallImageHeight:post imageViewWidthg:[UIApplication sharedApplication].keyWindow.frame.size.width-16];
        [self.postImageView sd_setImageWithURL:[NSURL URLWithString:post.imageUrl]
                          placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                   options:SDWebImageHighPriority];
    }
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:post.user.avatar]
                      placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                               options:SDWebImageRefreshCached];
    if(post.placeID != 0){
        self.placeNameLbl.text = [NSString stringWithFormat:@"%@ %@", [LanguageManager setLanguageString:@"at"], post.place.name];
        [self.goToPlaceBtn setUserInteractionEnabled:YES];
    }else{
        self.placeNameLbl.text = @"";
        [self.goToPlaceBtn setUserInteractionEnabled:NO];
        
    }
    
    if(post.postPlaceRate > 0 && post.place.placeID != 0){
        self.rateView.hidden = NO;
        self.rateView.rating = post.postPlaceRate;
        self.rateViewHeight.constant = 30;
    }else{
        self.rateView.hidden = YES;
        self.rateViewHeight.constant = 16;
    }
    
    if(post.likesCount == 0 && post.commentsCount == 0){
        self.likesViewHeight.constant = 0;
        self.likesView.hidden = YES;
        self.commentsCountBtn.hidden = YES;

        self.firstCommentViewHeight.constant = 0;
        self.firstCommentView.hidden = YES;
        self.secondCommentViewHeight.constant = 0;
        self.secondCommentView.hidden = YES;
        
    }else{
        if(post.likesCount == 0){
            self.likesViewHeight.constant = 0;
            self.likesView.hidden = YES;
        }else{
            self.likesViewHeight.constant = 27;
            self.likesView.hidden = NO;
            
            if(post.likedByMe){
                self.lastLikedNameLbl.text = [LanguageManager setLanguageString:@"you"];
                if(post.likesCount == 1){
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@" %@", [LanguageManager setLanguageString:@"honked_this"]];
                }else{
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@"%@ %ld %@",[LanguageManager setLanguageString:@"and"], post.likesCount-1, [LanguageManager setLanguageString:@"others"]];
                }
            }else{
                self.lastLikedNameLbl.text = post.likedUser.name;
                if(post.likesCount == 1){
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@" %@", [LanguageManager setLanguageString:@"honked_this"]];
                }else{
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@"%@ %ld %@",[LanguageManager setLanguageString:@"and"], post.likesCount-1, [LanguageManager setLanguageString:@"others"]];
                }
            }
        }
        
        if(post.likesCount == 0 && post.commentsCount == 0){
            self.likesViewHeight.constant = 0;
            self.likesView.hidden = YES;
            self.commentsCountBtn.hidden = YES;
            
            self.firstCommentViewHeight.constant = 0;
            self.firstCommentView.hidden = YES;
            self.secondCommentViewHeight.constant = 0;
            self.secondCommentView.hidden = YES;
            
        }else{
            if(post.likesCount == 0){
                self.likesIconImageView.hidden = YES;
                self.likesOthersCountLbl.hidden = YES;
                self.lastLikedNameLbl.hidden = YES;
            }else{
                self.likesViewHeight.constant = 27;
                self.likesView.hidden = NO;
                
                self.likesIconImageView.hidden = NO;
                self.likesOthersCountLbl.hidden = NO;
                self.lastLikedNameLbl.hidden = NO;
                
                if(post.likedByMe){
                    self.lastLikedNameLbl.text = [LanguageManager setLanguageString:@"you"];
                    if(post.likesCount == 1){
                        self.likesOthersCountLbl.text = [NSString stringWithFormat:@" %@", [LanguageManager setLanguageString:@"honked_this"]];
                    }else{
                        self.likesOthersCountLbl.text = [NSString stringWithFormat:@"%@ %ld %@",[LanguageManager setLanguageString:@"and"], post.likesCount-1, [LanguageManager setLanguageString:@"others"]];
                    }
                }else{
                    self.lastLikedNameLbl.text = post.likedUser.name;
                    if(post.likesCount == 1){
                        self.likesOthersCountLbl.text = [NSString stringWithFormat:@" %@", [LanguageManager setLanguageString:@"honked_this"]];
                    }else{
                        self.likesOthersCountLbl.text = [NSString stringWithFormat:@"%@ %ld %@",[LanguageManager setLanguageString:@"and"], post.likesCount-1, [LanguageManager setLanguageString:@"others"]];
                    }
                }
            }
            
            if (post.commentsCount == 0){
                self.commentsCountBtn.hidden = YES;
                
                self.firstCommentViewHeight.constant = 0;
                self.firstCommentView.hidden = YES;
                self.secondCommentViewHeight.constant = 0;
                self.secondCommentView.hidden = YES;
            }else{
                if(post.commentsArray.count > 0){
                    
                    self.likesViewHeight.constant = 27;
                    self.likesView.hidden = NO;
                    self.commentsCountBtn.hidden = NO;
                    if(post.commentsCount == 1){
                        [self.commentsCountBtn setTitle:[NSString stringWithFormat:@"%ld %@", (long)post.commentsCount, [LanguageManager setLanguageString:@"one_comment"]] forState:UIControlStateNormal];
                    }else{
                        [self.commentsCountBtn setTitle:[NSString stringWithFormat:@"%ld %@", (long)post.commentsCount, [LanguageManager setLanguageString:@"comments"]] forState:UIControlStateNormal];
                    }
                    
                    PostCommentModel *firstCom = post.commentsArray.firstObject;
                    self.firstCommentViewHeight.constant = 62 + [Utils heightWithText:firstCom.comment andLabel:self.firstCommentBodyLbl];
                    self.firstCommentView.hidden = NO;
                    
                    [self.firstCommentAvatarImageView sd_setImageWithURL:[NSURL URLWithString:firstCom.user.avatar]
                                                        placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                                                 options:SDWebImageRefreshCached];
                    self.firstComentNameLbl.text = firstCom.user.name;
                    self.firstCommentBodyLbl.text = firstCom.comment;
                    self.firstCommentTimeLbl.text = [Utils makeTimePassShortString:firstCom.timePass];
                    
                }else{
                    self.firstCommentView.hidden = YES;
                    self.firstCommentViewHeight.constant = 0;
                }
                
                if(post.commentsArray.count > 1){
                    PostCommentModel *secondCom = post.commentsArray.lastObject;
                    self.secondCommentViewHeight.constant = 62 + [Utils heightWithText:secondCom.comment andLabel:self.secCommentBodyLbl];
                    self.secondCommentView.hidden = NO;
                    
                    [self.secCommentAvatarImageView sd_setImageWithURL:[NSURL URLWithString:secondCom.user.avatar]
                                                      placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                                               options:SDWebImageRefreshCached];
                    self.secCommentNameLbl.text = secondCom.user.name;
                    self.secCommentBodyLbl.text = secondCom.comment;
                    self.secCommentTimeLbl.text = [Utils makeTimePassShortString:secondCom.timePass];
                    
                }else{
                    self.secondCommentView.hidden = YES;
                    self.secondCommentViewHeight.constant = 0;
                }
            }
        }
    }
}

- (IBAction)dotsBtnAction:(id)sender {
    
    if(self.isUserOwner){
        
        if(!self.cellOwnerMenuView.hidden) {
            [self.cellOwnerMenuView setHidden:YES];
            return;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeWallCellMenu" object:nil];
        [self.cellOwnerMenuView setHidden:NO];

    }else{
        if(!self.cellMenuView.hidden) {
            [self.cellMenuView setHidden:YES];
            return;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeWallCellMenu" object:nil];
        [self.cellMenuView setHidden:NO];

    }
    
}

- (void)closeCellMenu{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"closeWallCellMenu" object:nil];
    [self.cellMenuView setHidden:YES];
    [self.cellOwnerMenuView setHidden:YES];
}


@end

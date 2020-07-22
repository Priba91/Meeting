//
//  PostViewerViewController.m
//  Convoy Caravan
//
//  Created by Priba on 10/19/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "PostViewerViewController.h"
#import "WallPostModel.h"
#import "ColorDefinitions.h"
#import "LanguageManager.h"
#import "ServerCommunicationManager.h"
#import "Toast.h"
#import "CommentsViewController.h"
#import "UIImageView+WebCache.h"
#import "DataManager.h"
#import "LikedListViewController.h"
#import "PlaceViewController.h"

@interface PostViewerViewController ()

@property (nonatomic) int retryCount;

@end

@implementation PostViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTopNavigationBarWithTitle:[LanguageManager setLanguageString:@"post"]];
    
    [self setupUI];
    [self setupStrings];
    self.retryCount = 0;
    if(self.post.postID == 0) [self presentOverlayLoader];
    [self loadData];

    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGestureAction)];
    [self.view addGestureRecognizer:backTap];
}

#pragma mark - Private methods

- (void)setupUI{
    
    [self.profileImageView.layer setCornerRadius:self.profileImageView.frame.size.height/2];
    
    [self.cellMenuView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.cellMenuView.layer setBorderWidth:1.0];
    
    [self.shareBtn setTitleColor:BASE_BAR_COLOR1 forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:BASE_BAR_COLOR1 forState:UIControlStateNormal];
    [self.placeNameLbl setTextColor:BASE_BAR_COLOR1];
    
    [Utils addHalfHightCornerRadiusToView:self.likeBtn];
    [Utils addHalfHightCornerRadiusToView:self.commentBtn];
    
    [self.backView.layer setCornerRadius:8];
    self.backView.layer.shadowRadius = 2.5f;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(2.f, 2.f);
    self.backView.layer.shadowOpacity = 0.1f;
    self.backView.layer.masksToBounds = NO;
    
    [Utils addHalfHightCornerRadiusToView:self.likesIconImageView];
    self.likesIconImageView.backgroundColor = [UIColor clearColor];
    
    [self.firstCommentBodyLbl setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.firstCommentAvatarImageView.layer setCornerRadius:self.firstCommentAvatarImageView.frame.size.height/2];
    [self.firstCommentHolderView.layer setCornerRadius:16];
    
    [self.secCommentBodyLbl setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.secCommentAvatarImageView.layer setCornerRadius:self.secCommentAvatarImageView.frame.size.height/2];
    [self.secCommentHolderView.layer setCornerRadius:16];
    
    self.firstCommentViewHeight.constant = 0;
    self.firstCommentView.hidden = YES;
    self.secondCommentViewHeight.constant = 0;
    self.secondCommentView.hidden = YES;
}

- (void)setupStrings{
    if(self.post.user.userId == [DataManager sharedInstance].logedUser.userId){
        
        [self.reportBtn setTitle:[LanguageManager setLanguageString:@"delete_btn"] forState:UIControlStateNormal];
    }else{
        [self.reportBtn setTitle:[LanguageManager setLanguageString:@"report_btn"] forState:UIControlStateNormal];
    }
}

- (void)loadData{

    if(self.retryCount < 3 && self.post.postID == 0){
        NSArray *strArray = [self.postUrl componentsSeparatedByString:@"/"];
        if([[strArray objectAtIndex:4] integerValue]){
            
            NSInteger postId = [[strArray objectAtIndex:4] integerValue];
            
            [[[ServerCommunicationManager alloc] init] getPostWithId:postId success:^(NSData *response, NSInteger statusCode) {
                [self dismissOverlayLoader];
                
                NSError *error;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
                NSLog(@"%@", json);
                if(statusCode == 200){
                    self.post = [WallPostModel initWithDictionary:json];
                    self.retryCount = 0;
                    [self fillData];
                }
                
            } failure:^(NSString *error, NSInteger statusCode) {
                self.retryCount += 1;
                [self loadData];
            }];
            
        }
    }else if(self.post.postID > 0){
        
        [self fillData];
    }else{
        self.post = [[WallPostModel alloc] init];
        [self dismissOverlayLoader];
        [super presentPopupWithTitle:[LanguageManager setLanguageString:@"load_data_error"] andMessage:@"" andButtonTitle:@"Ok"];
    }
    
   
}

- (void)fillData{
    
    [self.likesIconImageView setImage:[UIImage imageNamed:@"liked"]];

    
    if(self.post.user.userId == [DataManager sharedInstance].logedUser.userId){
        
        [self.reportBtn setTitle:[LanguageManager setLanguageString:@"delete_btn"] forState:UIControlStateNormal];
        
        self.optionsViewHeight.constant = 40;
        self.deletePostBtn.hidden = NO;
    }else{
        [self.reportBtn setTitle:[LanguageManager setLanguageString:@"report_btn"] forState:UIControlStateNormal];
        self.optionsViewHeight.constant = 40;
        self.deletePostBtn.hidden = YES;
    }
    
    if(self.post.likedByMe){
        [self.likeBtn setImage:[UIImage imageNamed:@"liked"] forState:normal];
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"unliked"] forState:normal];
    }
    
    [self.likeBtn setTitle:[LanguageManager setLanguageString:@"honk"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[LanguageManager setLanguageString:@"comments"] forState:UIControlStateNormal];

    self.profileNameLbl.text = self.post.user.name;
    self.postTimeLbl.text = [Utils makeTimePassShortString:self.post.timePass];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:self.post.user.avatar]
                             placeholderImage:[UIImage imageNamed:@"profilePlaceholder"]
                                      options:SDWebImageRefreshCached];

    self.placeNameLbl.text = self.post.place.name;
    
    if(self.post.type == 1){
        [self.medalView setHidden:YES];
        self.messageLbl.text = self.post.body;
        
        
        self.rateViewHeight.constant = 30;
        if(self.post.postPlaceRate > 0){
            [self.rateView setRating:self.post.postPlaceRate];
            [self.rateView setHidden:NO];
        }
        
        if([self.post.imageUrl isEqualToString:@""]){
            self.imageViewHight.constant = 0;
        }else{
            self.imageViewHight.constant = [Utils getWallImageHeight:self.post imageViewWidthg:self.postImageView.frame.size.width];
            [self.postImageView sd_setImageWithURL:[NSURL URLWithString:self.post.imageUrl]
                                  placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                           options:SDWebImageHighPriority];
        }
    }else if(self.post.type == 7){
        [self.medalView setHidden:NO];
        self.imageViewHight.constant = 360;
        self.medalMessageLbl.text = self.post.medal.medalDesc;
        self.medalNameLbl.text = self.post.medal.name;
        
        if(self.post.medal.type != 1){
            self.medalLevelLbl.text = [NSString stringWithFormat:@"%@ %ld", [LanguageManager setLanguageString:@"medal_level"], self.post.medal.level];
            self.medalLevelHeight.constant = 33;
            
        }else{
            self.medalLevelLbl.text = @"";
            self.medalLevelHeight.constant = 33;
        }

        [self.medalImageView sd_setImageWithURL:[NSURL URLWithString:self.post.medal.imageUrl]
                              placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                       options:SDWebImageHighPriority];
        
    }else if(self.post.type == 6){
        [self.medalView setHidden:NO];
        self.imageViewHight.constant = 360;
        self.medalMessageLbl.text = self.post.achivment.achiDescription;
        self.medalNameLbl.text = self.post.achivment.name;
        self.medalLevelLbl.text = @"";
        self.medalLevelHeight.constant = 0;
        [self.medalImageView sd_setImageWithURL:[NSURL URLWithString:self.post.achivment.imageUrl]
                              placeholderImage:[UIImage imageNamed:@"placeImagePlaceholder"]
                                       options:SDWebImageHighPriority];
    }
    
    if(self.post.likesCount == 0 && self.post.commentsCount == 0){
        self.likesViewHeight.constant = 0;
        self.likesView.hidden = YES;
        self.commentsCountBtn.hidden = YES;
        
        self.firstCommentViewHeight.constant = 0;
        self.firstCommentView.hidden = YES;
        self.secondCommentViewHeight.constant = 0;
        self.secondCommentView.hidden = YES;
        
    }else{
        if(self.post.likesCount == 0){
            self.likesIconImageView.hidden = YES;
            self.likesOthersCountLbl.hidden = YES;
            self.lastLikedNameLbl.hidden = YES;
        }else{
            self.likesViewHeight.constant = 27;
            self.likesView.hidden = NO;
            
            self.likesIconImageView.hidden = NO;
            self.likesOthersCountLbl.hidden = NO;
            self.lastLikedNameLbl.hidden = NO;
            
            if(self.post.likedByMe){
                self.lastLikedNameLbl.text = [LanguageManager setLanguageString:@"you"];
                if(self.post.likesCount == 1){
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@" %@", [LanguageManager setLanguageString:@"honked_this"]];
                }else{
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@"%@ %ld %@",[LanguageManager setLanguageString:@"and"], self.post.likesCount-1, [LanguageManager setLanguageString:@"others"]];
                }
            }else{
                self.lastLikedNameLbl.text = self.post.likedUser.name;
                if(self.post.likesCount == 1){
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@" %@", [LanguageManager setLanguageString:@"honked_this"]];
                }else{
                    self.likesOthersCountLbl.text = [NSString stringWithFormat:@"%@ %ld %@",[LanguageManager setLanguageString:@"and"], self.post.likesCount-1, [LanguageManager setLanguageString:@"others"]];
                }
            }
        }
        
        if (self.post.commentsCount == 0){
            self.commentsCountBtn.hidden = YES;
            
            self.firstCommentViewHeight.constant = 0;
            self.firstCommentView.hidden = YES;
            self.secondCommentViewHeight.constant = 0;
            self.secondCommentView.hidden = YES;
        }else{
            if(self.post.commentsArray.count > 0){
                
                self.likesViewHeight.constant = 27;
                self.likesView.hidden = NO;
                self.commentsCountBtn.hidden = NO;
                if(self.post.commentsCount == 1){
                    [self.commentsCountBtn setTitle:[NSString stringWithFormat:@"%ld %@", (long)self.post.commentsCount, [LanguageManager setLanguageString:@"one_comment"]] forState:UIControlStateNormal];
                }else{
                    [self.commentsCountBtn setTitle:[NSString stringWithFormat:@"%ld %@", (long)self.post.commentsCount, [LanguageManager setLanguageString:@"comments"]] forState:UIControlStateNormal];
                }
                
                PostCommentModel *firstCom = self.post.commentsArray.firstObject;
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
            
            if(self.post.commentsArray.count > 1){
                PostCommentModel *secondCom = self.post.commentsArray.lastObject;
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

#pragma mark - Button actions

- (IBAction)shareBtnAction:(UIButton *)sender {
    
    if(self.post.postID != 0){
        NSString *textToShare = [NSString stringWithFormat:@"https://convoyclub.eu/post/%ld", (long)self.post.postID];
            
        if(![self.post.imageUrl isEqualToString:@""]){

            UIImageView *tmp = [[UIImageView alloc] init];
            [tmp sd_setImageWithURL:[NSURL URLWithString:self.post.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;

                UIImage * imageToSave = image;
                NSData * binaryImageData = UIImageJPEGRepresentation(imageToSave, 1.0);
                [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:@"convoyShare.jpeg"] atomically:YES];

                NSURL *imgUrl = [[NSURL alloc] initFileURLWithPath:[basePath stringByAppendingPathComponent:@"convoyShare.jpeg"]];
                            
                UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[imgUrl] applicationActivities:nil];
                activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //Exclude whichever aren't relevant
                [self presentViewController:activityVC animated:YES completion:nil];
            }];

        }else{
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[textToShare] applicationActivities:nil];
            activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //Exclude whichever aren't relevant
            [self presentViewController:activityVC animated:YES completion:nil];
        }
    }

}

- (IBAction)commentBtnAction:(UIButton *)sender {
        if(self.post.postID != 0){
            CommentsViewController *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentsViewController"];
            VC.post = self.post;
            [self.navigationController pushViewController:VC animated:YES];
        }
}

- (IBAction)likeListBtnAction:(UIButton *)sender {
    
    LikedListViewController *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LikedListViewController"];
    VC.post = self.post;
    VC.listType = likes;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)goToPlace:(id)sender {
    PlaceViewController *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PlaceViewController"];
    VC.place = self.post.place;
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)likeBtnAction:(UIButton *)sender {
    
    [[[ServerCommunicationManager alloc] init] postLikeWithPost:self.post success:^(NSData *response, NSInteger statusCode) {
        NSLog(@"aa");
    } failure:^(NSString *error, NSInteger statusCode) {
        NSLog(@"aa");
    }];
    
    if(!self.post.likedByMe){
        [self.post setLikedByMe:YES];
        [self.post setLikesCount:self.post.likesCount + 1];
    }else{
        [self.post setLikedByMe:NO];
        [self.post setLikesCount:self.post.likesCount - 1];
    }
    [self fillData];
}

- (IBAction)reportBtnAction:(UIButton *)sender {
    [self.cellMenuView setHidden:YES];

        if(self.post.userID == [DataManager sharedInstance].logedUser.userId){
            [[[ServerCommunicationManager alloc] init] removePostWithPost:self.post success:^(NSData *response, NSInteger statusCode) {
                if(statusCode == 200){
                    
                    [self.view makeToast:[LanguageManager setLanguageString:@"post_removed"]
                                duration:3.0
                                position:CSToastPositionBottom];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
            } failure:^(NSString *error, NSInteger statusCode) {

            }];
        }else{
            [self presentReportPopupWithTitle:[LanguageManager setLanguageString:@"report_title"] andMessage:self.post.body andButtonTitle:[LanguageManager setLanguageString:@"send_report_btn"]];
        }
    
}

- (void)dismissReportPopup{
    [super dismissReportPopup];
    [super.view endEditing:YES];
    
    NSString *reportText = [[NSUserDefaults standardUserDefaults] objectForKey:@"reportText"];
    
    if(reportText == nil || [reportText isEqualToString:[LanguageManager setLanguageString:@"write_report"]] || [reportText isEqualToString:@""]){
        [self.view makeToast:[LanguageManager setLanguageString:@"report_message_empty"] duration:2 position:CSToastPositionBottom];
    }else{
        
        [[[ServerCommunicationManager alloc] init] postReportWithPost:self.post Message:reportText success:^(NSData *response, NSInteger statusCode) {
        } failure:^(NSString *error, NSInteger statusCode) {
        }];
        
            [self.view makeToast:[LanguageManager setLanguageString:@"report_send"] duration:2 position:CSToastPositionBottom];
            [self.navigationController popViewControllerAnimated:YES];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"reportText"];
        
    }
    
}

- (IBAction)dotsBtnAction:(id)sender {
    if(self.post.postID != 0){
        [self.cellMenuView setHidden:NO];
    }
}

- (void)backGestureAction{
    [self.cellMenuView setHidden:YES];

}

- (IBAction)previewImageBtnAction:(UIButton *)sender {
    
    [self presentPhotoViewerWithImageUrl:self.post.imageUrl];
}

@end

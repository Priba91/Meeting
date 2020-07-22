//
//  MedalViewerViewController.m
//  Convoy Caravan
//
//  Created by Priba on 11/20/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "MedalViewerViewController.h"
#import "EditProfileViewController.h"
#import "ColorDefinitions.h"
#import "LanguageManager.h"
#import "ServerCommunicationManager.h"
#import "DataManager.h"
#import "UIImageView+WebCache.h"
#import "Toast.h"
#import "WallTableViewCell.h"
#import "SpinerTableViewCell.h"
#import "ChatViewController.h"
#import "MessageModel.h"
#import "MedalModel.h"
#import "AchivmentModel.h"
#import "CommentsViewController.h"
#import "ProfileMedalCollectionViewCell.h"
#import "MedalHeaderTableViewCell.h"
#import "AchivmentProfileTableViewCell.h"
#import "WallMedalTableViewCell.h"
#import "LikedListViewController.h"
#import "ImageCollectionViewCell.h"
#import "ImagesTableViewCell.h"
#import "BadgesTableViewCell.h"
#import "ImagesViewController.h"
#import "BadgesViewController.h"

@interface MedalViewerViewController ()

@property (strong, nonatomic) WallPostModel *post;
@property (nonatomic) int retryCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@end

@implementation MedalViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupStrings];
    [self loadData];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGestureAction)];
    [self.backView addGestureRecognizer:backTap];

    [self.medalTableView reloadData];
}

#pragma mark - Private methods

- (void)setupUI{
    
    [self.medalTableView.layer setCornerRadius:8];
    [self.closeBackView.layer setCornerRadius:8];
    [Utils addHalfHightCornerRadiusToView:self.closeBtn];

    [self.view setBackgroundColor:[UIColor clearColor]];
     
    [self.closeBtn setBackgroundColor:BASE_BAR_COLOR1];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self updateTableViewContentInset];
}

- (void)updateTableViewContentInset {
    CGFloat viewHeight = self.medalTableView.frame.size.height;
    CGFloat tableViewContentHeight = self.medalTableView.contentSize.height;
    CGFloat marginHeight = (viewHeight - tableViewContentHeight) / 2.0;
    
    if(viewHeight >= tableViewContentHeight){
        self.medalTableView.contentInset = UIEdgeInsetsMake(marginHeight, 0, -marginHeight, 0);
    }else{
        self.medalTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

- (void)setupStrings{

}

- (void)loadData{

}

#pragma mark - TableView Data and Delegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if(indexPath.row == 0){
         MedalHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MedalHeaderTableViewCell" forIndexPath:indexPath];
        [cell populateWithMedal:self.medal];
        return cell;
    }else if(indexPath.row-1 < self.medal.achivmentArray.count){
        AchivmentProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AchivmentProfileTableViewCell" forIndexPath:indexPath];
        AchivmentModel *tmp = [self.medal.achivmentArray objectAtIndex:indexPath.row-1];
        [cell populateWithAchivment:tmp];
        
        return cell;
    }else{
        return [[UITableViewCell alloc] init];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.medal.medalID > 0){
        return 1;
//        if(self.medal.type != 1){
//            return self.medal.achivmentArray.count + 1;
//        }else{
//            return 1;
//        }
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


#pragma mark - Button actions

- (IBAction)closeBtn:(UIButton *)sender {
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)backGestureAction{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)shareBtn:(id)sender {
    NSString *textToShare = [NSString stringWithFormat:@"https://convoyclub.eu/post/%ld", (long)self.post.postID];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[textToShare] applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //Exclude whichever aren't relevant
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end

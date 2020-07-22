//
//  PlaceUserReviewTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 11/8/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewModel.h"
#import "Cosmos-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceUserReviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet CosmosView *rateView;


- (void)populateWithComment:(ReviewModel*)review;

@end

NS_ASSUME_NONNULL_END

//
//  ReviewPlaceTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 11/1/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"
#import "Cosmos-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReviewPlaceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CosmosView *reviewHolderView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *reviewsCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *bottomLbl;
@property (weak, nonatomic) IBOutlet UILabel *reviewRateLbl;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;


- (void)populateWithPlace:(PlaceModel*)place;

@end

NS_ASSUME_NONNULL_END

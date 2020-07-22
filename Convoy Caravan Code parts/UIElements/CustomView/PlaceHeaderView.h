//
//  PlaceHeaderView.h
//  Convoy Caravan
//
//  Created by Priba on 1/24/19.
//  Copyright © 2019 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"
#import "Cosmos-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PlaceHeaderDelegate <NSObject>
- (void)headerBackAction;
- (void)headerEditAction;
- (void)headerInfoAction;
- (void)headerReviewAction;
- (void)headerActivityAction;
- (void)headerCheckInAction;
- (void)openCategotyAction;

@end

@interface PlaceHeaderView : UIView

@property (strong, nonatomic) PlaceModel *place;

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIView *coverImageLayerView;
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLbl;
@property (weak, nonatomic) IBOutlet UIView *reviewHolderView;
@property (weak, nonatomic) IBOutlet CosmosView *headerRateView;
@property (weak, nonatomic) IBOutlet UIButton *headerCheckInBtn;
@property (weak, nonatomic) IBOutlet UIButton *categotyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coverDefaultImageView;

@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorLeftConstraint;

@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewsBtn;
@property (weak, nonatomic) IBOutlet UIButton *activityBtn;


- (void)setRating:(double)rating;
- (void)setPlaceDetails:(PlaceModel*)place;

@property (nonatomic, assign)id<PlaceHeaderDelegate> delegate;


@end

NS_ASSUME_NONNULL_END

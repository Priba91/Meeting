//
//  RoutePlaceTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/3/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"
#import "Cosmos-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoutePlaceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *categortyTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *distanceLbl;
@property (weak, nonatomic) IBOutlet CosmosView *rateView;
@property (nonatomic, retain) IBOutletCollection(UIImageView) NSArray *featuresIVArray;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

- (void)populateCellWith:(PlaceModel*)place;

@end

NS_ASSUME_NONNULL_END

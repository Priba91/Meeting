//
//  PlaceMarksCollectionViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/31/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeaturesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceMarksCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

-(void)populateCellWithMedal:(FeaturesModel*)feature;

@end

NS_ASSUME_NONNULL_END

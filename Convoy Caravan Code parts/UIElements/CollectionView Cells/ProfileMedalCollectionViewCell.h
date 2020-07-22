//
//  ProfileMedalCollectionViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/23/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedalModel.h"
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileMedalCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectionBtn;

-(void)populateCellWithMedal:(MedalModel*)medal;

@end

NS_ASSUME_NONNULL_END

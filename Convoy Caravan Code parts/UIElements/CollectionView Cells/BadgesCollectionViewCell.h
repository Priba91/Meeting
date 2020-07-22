//
//  BadgesCollectionViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 12/16/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedalModel.h"
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface BadgesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *selectionBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewWidth;

-(void)populateCellWithMedal:(MedalModel*)medal;

@end

NS_ASSUME_NONNULL_END

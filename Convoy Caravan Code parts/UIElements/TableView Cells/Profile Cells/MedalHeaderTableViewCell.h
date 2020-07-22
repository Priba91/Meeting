//
//  MedalHeaderTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/24/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedalHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *levelLblHeight;
@property (weak, nonatomic) IBOutlet UILabel *levelLbl;
@property (weak, nonatomic) IBOutlet UILabel *hintLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hintLblHeight;
@property (weak, nonatomic) IBOutlet UIView *progressBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidth;
@property (weak, nonatomic) IBOutlet UIView *progressBackBar;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;
@property (weak, nonatomic) IBOutlet UILabel *earnedDateLbl;

@property (weak, nonatomic) IBOutlet UIView *progressBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressBackViewHeight;

@property (weak, nonatomic) IBOutlet UIView *earnedBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *earnedBackViewHeight;

-(void)populateWithMedal:(MedalModel*)medal;

@end

NS_ASSUME_NONNULL_END

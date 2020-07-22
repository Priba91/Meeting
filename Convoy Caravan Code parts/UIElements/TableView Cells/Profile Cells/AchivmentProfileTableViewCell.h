//
//  AchivmentProfileTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/24/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchivmentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AchivmentProfileTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UILabel *levelLbl;

-(void)populateWithAchivment:(AchivmentModel*)achivement;

@end

NS_ASSUME_NONNULL_END

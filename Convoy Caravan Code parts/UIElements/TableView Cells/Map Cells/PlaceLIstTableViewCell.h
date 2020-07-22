//
//  PlaceLIstTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 9/20/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cosmos-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceLIstTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

NS_ASSUME_NONNULL_END

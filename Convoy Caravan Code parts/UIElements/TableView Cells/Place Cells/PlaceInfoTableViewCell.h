//
//  PlaceInfoTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/31/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *webImageView;
@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *webSiteLbl;
@property (weak, nonatomic) IBOutlet UILabel *worktimeLbl;

- (void)populateWithPlace:(PlaceModel*)place;

@end

NS_ASSUME_NONNULL_END

//
//  AboutPlaceTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/31/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AboutPlaceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *aboutlbl;

- (void)populateWithPlace:(PlaceModel*)place;

@end

NS_ASSUME_NONNULL_END

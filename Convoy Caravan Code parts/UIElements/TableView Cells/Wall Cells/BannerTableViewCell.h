//
//  BannerTableViewCell.h
//  Convoy Caravan
//
//  Created by Priba on 10/10/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

-(void) setImageWithUrl:(NSString*)urlStr;

@end

NS_ASSUME_NONNULL_END

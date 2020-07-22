//
//  MedalViewerViewController.h
//  Convoy Caravan
//
//  Created by Priba on 11/20/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MedalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedalViewerViewController : BaseViewController

@property (strong, nonatomic) MedalModel *medal;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medalTableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *medalTableView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIView *closeBackView;

@end

NS_ASSUME_NONNULL_END

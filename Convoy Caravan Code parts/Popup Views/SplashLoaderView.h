//
//  SplashLoaderView.h
//  Convoy Caravan
//
//  Created by Priba on 10/11/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLMultiColorLoader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SplashLoaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *splashImageView;
@property (nonatomic, strong) BLMultiColorLoader *loader;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;

@end

NS_ASSUME_NONNULL_END

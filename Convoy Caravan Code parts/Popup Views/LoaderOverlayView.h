//
//  LoaderOverlayView.h
//  Convoy Caravan
//
//  Created by Priba on 10/15/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLMultiColorLoader.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoaderOverlayView : UIView

@property (nonatomic, strong) BLMultiColorLoader *loader;

@end

NS_ASSUME_NONNULL_END

//
//  UIWindow+NPAdditions.m
//  NasaPatrola
//
//  Created by Aleksandra on 9/12/16.
//  Copyright © 2016 Nemanja Krstic. All rights reserved.
//

#import "UIWindow+NPAdditions.h"

@implementation UIWindow (NPAdditions)

#pragma mark - Public methods

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = self.rootViewController;
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

#pragma mark - Private methods

+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]])
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    else if ([vc isKindOfClass:[UITabBarController class]])
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    else if (vc.presentedViewController)
        return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
    else
        return vc;
}

@end

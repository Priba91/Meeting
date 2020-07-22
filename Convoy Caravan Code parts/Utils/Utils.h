//
//  Utils.h
//  Convoy Caravan
//
//  Created by Priba on 9/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WallPostModel.h"
#import "MaterialShowcase-Swift.h"

@interface Utils : NSObject

+ (void)addGradientToView:(UIView *)view;

+ (void)addHalfHightCornerRadiusToView:(UIView *)view;
+ (void)addCornerRadiusToView:(UIView *)view radius:(float)radius;
+ (void)addCornerRadiusToView:(UIView *)view withHalfSizeOfView:(UIView *)targetView;

+ (void)addPaddingToTextField:(UITextField*)textField;
+ (void)prepareTextField:(UITextField*)textField;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+(NSString*)createLocationString:(CLLocationCoordinate2D)location;
+(CLLocationCoordinate2D)createLocationFromString:(NSString*)coordStr;
+ (BOOL)isIphoneXSeries;
+ (NSString*) deviceName;

+ (BOOL)hasInternetConnection;
+ (NSString*)makeDistanceString:(double)distance;
+ (NSString*)makeTimePassString:(NSInteger)timePass;
+ (CGFloat)getWallImageHeight:(WallPostModel*)post imageViewWidthg:(CGFloat)ivWidth;
+ (BOOL)isIphoneSmallSeries;
+ (NSString*)makeTimePassShortString:(NSInteger)timePass;
+ (void)addChatGradientToView:(UIView *)view;
+ (CGFloat)getImageHeightWithWidth:(CGFloat)imageWidth  imageViewWidthg:(CGFloat)ivWidth;
+ (CGFloat)getImageHeightWithImageWidth:(CGFloat)imageWidth ImageHeight:(CGFloat)imageHeight imageViewWidthg:(CGFloat)ivWidth;
+ (UIImage *)convertImageToGrayScale:(UIImage *)image;
+ (NSMutableArray*)getNotificationMessagesArray;
+ (MaterialShowcase*)prepareMaterialShowcaseWithTitle:(NSString*)title Message:(NSString*)message TargetView:(UIView*)target;
+ (MaterialShowcase*)prepareMaterialShowcaseForTabButtonWithTitle:(NSString*)title Message:(NSString*)message TargetView:(UIBarButtonItem*)target;
+ (BOOL)validateEmail:(NSString *)email;

+ (CGFloat)heightWithText:(NSString *)text andLabel:(UILabel*)label;
+ (CGSize)sizeForImagesCollectionView;
+ (CGSize)sizeForGridImagesCollectionView;
+ (CGSize)sizeForMedalCollectionView;
+ (NSString*)parseDateString:(NSString*)str;
+ (void)addStatusGradientToView:(UIView *)view;

@end

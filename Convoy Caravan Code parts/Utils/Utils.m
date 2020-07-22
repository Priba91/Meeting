//
//  Utils.m
//  Convoy Caravan
//
//  Created by Priba on 9/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "Utils.h"
#import "ColorDefinitions.h"
#import <sys/utsname.h>
#import "Reachability.h"
#import "LanguageManager.h"
#import "LanguageManager.h"
#import "NotificationMessageModel.h"

@implementation Utils

+ (void)addGradientToView:(UIView *)view{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = [UIApplication sharedApplication].keyWindow.frame;
    gradient.colors = @[(id)BASE_BAR_COLOR1.CGColor, (id)BASE_BAR_COLOR2.CGColor];

    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    
    [view.layer insertSublayer:gradient atIndex:0];
    [view setClipsToBounds:YES];
}

+ (void)addStatusGradientToView:(UIView *)view{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = [UIApplication sharedApplication].keyWindow.frame;
    gradient.colors = @[(id)[BASE_BAR_COLOR1 colorWithAlphaComponent:0.8].CGColor, (id)UIColor.clearColor.CGColor];
    
    gradient.startPoint = CGPointMake(0.5, 0.0);
    gradient.endPoint = CGPointMake(0.5, 0.03);
    
    [view.layer insertSublayer:gradient atIndex:0];
    [view setClipsToBounds:YES];
}

+ (void)addChatGradientToView:(UIView *)view{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = [UIApplication sharedApplication].keyWindow.frame;
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)BACKGROUND_GRAY_COLOR.CGColor];
    
    gradient.startPoint = CGPointMake(0.5, 0.0);
    gradient.endPoint = CGPointMake(0.5, 0.7);
    
    [view.layer insertSublayer:gradient atIndex:0];
    [view setClipsToBounds:YES];
}

+ (void)addHalfHightCornerRadiusToView:(UIView *)view{
    [view.layer setCornerRadius:view.frame.size.height/2];
}

+ (void)addCornerRadiusToView:(UIView *)view radius:(float)radius{
    [view.layer setCornerRadius:radius];
}

+ (void)addCornerRadiusToView:(UIView *)view withHalfSizeOfView:(UIView *)targetView{
    [view.layer setCornerRadius:targetView.frame.size.height*2/3];
}

+ (void)addPaddingToTextField:(UITextField*)textField{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(16, 16, 16, 16)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

+ (void)prepareTextField:(UITextField*)textField{
    
    textField.backgroundColor = TEXT_FIELD_COLOR1;
    [Utils addHalfHightCornerRadiusToView:textField];
    [Utils addPaddingToTextField:textField];
}

+ (MaterialShowcase*)prepareMaterialShowcaseWithTitle:(NSString*)title Message:(NSString*)message TargetView:(UIView*)target{
    MaterialShowcase *showCase = [[MaterialShowcase alloc] init];
    
    [showCase setTargetViewWithView:target];
    
    [showCase setPrimaryTextFont: [UIFont systemFontOfSize:17 weight:UIFontWeightBold]];
    [showCase setSecondaryTextFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]];
    [showCase setTargetHolderColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2]];
    
    [showCase setPrimaryText:title];
    [showCase setSecondaryText:message];
    
    [showCase setBackgroundPromptColor:BASE_BAR_COLOR1];
    
    return showCase;
}

+ (MaterialShowcase*)prepareMaterialShowcaseForTabButtonWithTitle:(NSString*)title Message:(NSString*)message TargetView:(UIBarButtonItem*)target{
    MaterialShowcase *showCase = [[MaterialShowcase alloc] init];
    
    [showCase setTargetViewWithBarButtonItem:target];
    
    [showCase setPrimaryTextFont: [UIFont systemFontOfSize:17 weight:UIFontWeightBold]];
    [showCase setSecondaryTextFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]];
    [showCase setTargetHolderColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4]];
    
    [showCase setPrimaryText:title];
    [showCase setSecondaryText:message];
    
    [showCase setBackgroundPromptColor:BASE_BAR_COLOR1];
    
    return showCase;
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


+(NSString*)createLocationString:(CLLocationCoordinate2D)location {
    
    NSString *locationStr = [NSString stringWithFormat:@"%lf,%lf", location.latitude, location.longitude];
    
    return locationStr;
}

+(CLLocationCoordinate2D)createLocationFromString:(NSString*)coordStr{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 0;
    coordinate.longitude = 0;
    
    NSArray *items = [coordStr componentsSeparatedByString:@","];   //take the one array for split the string
    
    coordinate.longitude = [items[1] floatValue];
    coordinate.latitude = [items[0] floatValue];
    
    return coordinate;
}

+ (BOOL)isIphoneSmallSeries{
    if([UIApplication sharedApplication].keyWindow.frame.size.height <= 568){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isIphoneXSeries{
    if([[UIScreen mainScreen] nativeBounds].size.height >= 2436){
        return YES;
    }if([[UIScreen mainScreen] nativeBounds].size.height == 1792){ //XR
        return YES;
    }else{
        return NO;
    }
}

+ (NSString*) deviceName{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      : @"Simulator",
                              @"x86_64"    : @"Simulator",
                              @"iPod1,1"   : @"iPod Touch",        // (Original)
                              @"iPod2,1"   : @"iPod Touch",        // (Second Generation)
                              @"iPod3,1"   : @"iPod Touch",        // (Third Generation)
                              @"iPod4,1"   : @"iPod Touch",        // (Fourth Generation)
                              @"iPod7,1"   : @"iPod Touch",        // (6th Generation)
                              @"iPhone1,1" : @"iPhone",            // (Original)
                              @"iPhone1,2" : @"iPhone",            // (3G)
                              @"iPhone2,1" : @"iPhone",            // (3GS)
                              @"iPad1,1"   : @"iPad",              // (Original)
                              @"iPad2,1"   : @"iPad 2",            //
                              @"iPad3,1"   : @"iPad",              // (3rd Generation)
                              @"iPhone3,1" : @"iPhone 4",          // (GSM)
                              @"iPhone3,3" : @"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" : @"iPhone 4S",         //
                              @"iPhone5,1" : @"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" : @"iPhone 5",          // (model A1429, everything else)
                              @"iPad3,4"   : @"iPad",              // (4th Generation)
                              @"iPad2,5"   : @"iPad Mini",         // (Original)
                              @"iPhone5,3" : @"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" : @"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" : @"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" : @"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" : @"iPhone 6 Plus",     //
                              @"iPhone7,2" : @"iPhone 6",          //
                              @"iPhone8,1" : @"iPhone 6S",         //
                              @"iPhone8,2" : @"iPhone 6S Plus",    //
                              @"iPhone8,4" : @"iPhone SE",         //
                              @"iPhone9,1" : @"iPhone 7",          //
                              @"iPhone9,3" : @"iPhone 7",          //
                              @"iPhone9,2" : @"iPhone 7 Plus",     //
                              @"iPhone9,4" : @"iPhone 7 Plus",     //
                              @"iPhone10,1": @"iPhone 8",          // CDMA
                              @"iPhone10,4": @"iPhone 8",          // GSM
                              @"iPhone10,2": @"iPhone 8 Plus",     // CDMA
                              @"iPhone10,5": @"iPhone 8 Plus",     // GSM
                              @"iPhone10,3": @"iPhone X",          // CDMA
                              @"iPhone10,6": @"iPhone X",          // GSM
                              
                              @"iPad4,1"   : @"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   : @"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   : @"iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   : @"iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   : @"iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad6,7"   : @"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   : @"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   : @"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   : @"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    
    return deviceName;
}

+ (BOOL)hasInternetConnection {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

+ (NSString*)makeDistanceString:(double)distance {
    NSString *str = @"";
    
    if ([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus]!=kCLAuthorizationStatusNotDetermined){
        if(distance > 1000){
            str = [NSString stringWithFormat:@"%i km", (int)distance/1000];
        }else{
            str = [NSString stringWithFormat:@"%i m", (int)distance];
        }
        
    }
    
    return str;
}

+ (NSString*)makeTimePassString:(NSInteger)timePass {
    NSString *str = @"";
    NSString *sufix = @"";
    
    if(timePass == 0){
        return [LanguageManager setLanguageString:@"now"];
    }
    
    if(timePass < 60){
        if(timePass != 1){
            sufix = @"_many";
        }
        
        str = [NSString stringWithFormat:@"%i %@", (int)timePass, [LanguageManager setLanguageString:[NSString stringWithFormat:@"minut%@", sufix]]];
    }else if(timePass < 1440){
        if((int)timePass/60 != 1){
            sufix = @"_many";
        }
        
        str = [NSString stringWithFormat:@"%i %@", (int)timePass/60, [LanguageManager setLanguageString:[NSString stringWithFormat:@"hour%@", sufix]]];
    }else if(timePass < 525600){
        if((int)timePass/1440 != 1){
            sufix = @"_many";
        }
        str = [NSString stringWithFormat:@"%i %@", (int)timePass/1440, [LanguageManager setLanguageString:[NSString stringWithFormat:@"day%@", sufix]]];
    }else if(timePass < 15768000){
        if((int)timePass/525600 != 1){
            sufix = @"_many";
        }
        str = [NSString stringWithFormat:@"%i %@", (int)timePass/1440, [LanguageManager setLanguageString:[NSString stringWithFormat:@"month%@", sufix]]];
    }else{
        if((int)timePass/15768000 != 1){
            sufix = @"_many";
        }
        
        str = [NSString stringWithFormat:@"%i %@", (int)timePass/525600, [LanguageManager setLanguageString:[NSString stringWithFormat:@"year%@", sufix]]];
    }
    
    return str;
}

+ (NSString*)makeTimePassShortString:(NSInteger)timePass {
    NSString *str = @"";
    NSString *sufix = @"_short";
    
    if(timePass == 0){
        return [LanguageManager setLanguageString:@"now"];
    }
    
    if(timePass < 60){
        
        str = [NSString stringWithFormat:@"%i %@", (int)timePass, [LanguageManager setLanguageString:[NSString stringWithFormat:@"minut%@", sufix]]];
    }else if(timePass < 1440){

        str = [NSString stringWithFormat:@"%i %@", (int)timePass/60, [LanguageManager setLanguageString:[NSString stringWithFormat:@"hour%@", sufix]]];
    }else if(timePass < 43200){
        str = [NSString stringWithFormat:@"%i %@", (int)timePass/1440, [LanguageManager setLanguageString:[NSString stringWithFormat:@"day%@", sufix]]];
    }else if(timePass < 518400){
        str = [NSString stringWithFormat:@"%i %@", (int)timePass/43200, [LanguageManager setLanguageString:[NSString stringWithFormat:@"month%@", sufix]]];
    }else{

        str = [NSString stringWithFormat:@"%i %@", (int)timePass/525600, [LanguageManager setLanguageString:[NSString stringWithFormat:@"year%@", sufix]]];
    }
    
    return str;
}

+ (CGFloat)getWallImageHeight:(WallPostModel*)post  imageViewWidthg:(CGFloat)ivWidth{
    
    double height = post.imageHeight * ivWidth/post.imageWidth;
//h:w = h1:w2
//    double ratio = post.imageWidth/post.imageHeight;
//    if(ratio > 1.06){
//        return 1.2 * ivWidth;ƒ
//    }else if (ratio < 0.93) {
//        return 0.8 * ivWidth;
//    }else{
//        return ivWidth;
//    }
    if(height > 280){
        return 280;
    }
    
    return height;
}

+ (CGFloat)getImageHeightWithImageWidth:(CGFloat)imageWidth ImageHeight:(CGFloat)imageHeight imageViewWidthg:(CGFloat)ivWidth{
    double height = imageHeight * ivWidth/imageWidth;

    return height;
}

+ (UIImage *)convertImageToGrayScale:(UIImage *)inputImage {
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciimage = [CIImage imageWithCGImage:inputImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:ciimage forKey:kCIInputImageKey];
    [filter setValue:@0.0f forKey:kCIInputSaturationKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
    
    
//    // Create image rectangle with current image width/height
//    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
//
//    // Grayscale color space
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
//
//    // Create bitmap content with current image size and grayscale colorspace
//    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
//
//    // Draw image into current context, with specified rectangle
//    // using previously defined context (with grayscale colorspace)
//    CGContextDrawImage(context, imageRect, [image CGImage]);
//
//    // Create bitmap image info from pixel data in current context
//    CGImageRef imageRef = CGBitmapContextCreateImage(context);
//
//    // Create a new UIImage object
//    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
//
//    // Release colorspace, context and bitmap information
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
//    CFRelease(imageRef);
//
//    // Return the new grayscale image
//    return newImage;
}

+ (NSMutableArray*)getNotificationMessagesArray{
    NSMutableArray *outArray = [[NSMutableArray alloc] init];
    NSArray *savedArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"notificationMsgArray"];
    
    for (NSString *str in savedArray) {
        NotificationMessageModel *model = [NotificationMessageModel initWithString:str];
        BOOL isFound = NO;
        for (NotificationMessageModel *nmm in outArray) {
            if(nmm.conversationID == model.conversationID){
                [nmm.messagesIDArray addObjectsFromArray:model.messagesIDArray];
                isFound = YES;
                break;
            }
        }
        if(!isFound){
            [outArray addObject:model];
        }
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"notificationMsgArray"];
    return outArray;
}

+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    BOOL result = [emailTest evaluateWithObject:email];
    
    return result;
}

+ (CGFloat)heightWithText:(NSString *)text andLabel:(UILabel*)label{
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil];
    CGSize strSize = [[NSAttributedString alloc] initWithString:text attributes:attributes].size;
    
    double numRows = ceil(strSize.width / label.frame.size.width) + 2;
    
    [label setNumberOfLines:numRows];
    CGFloat height = numRows*strSize.height;

    
    if (height < strSize.height){
        return strSize.height;
    }
    
    return height;
}

+ (CGSize)sizeForImagesCollectionView{

    CGFloat size = ([UIApplication sharedApplication].keyWindow.frame.size.width - 40 - 32)/5;
    
    return CGSizeMake(size, size);
}

+ (CGSize)sizeForMedalCollectionView{
    
    CGFloat size = ([UIApplication sharedApplication].keyWindow.frame.size.width - 40)/5;
    
    return CGSizeMake(size, size);
}

+ (CGSize)sizeForGridImagesCollectionView{
    
    CGFloat size = ([UIApplication sharedApplication].keyWindow.frame.size.width - 50)/3;
    
    return CGSizeMake(size, size);
}

+ (NSString*)parseDateString:(NSString*)str{
    
    NSString *dateStr = [NSString stringWithFormat:@"%@",str];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    [dateFormat setDateFormat:@"MMMM dd, YYYY"];
    NSString* temp = [dateFormat stringFromDate:date];
    
    return temp;
}



@end

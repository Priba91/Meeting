//
//  LanguageManager.h
//  Convoy Caravan
//
//  Created by Priba on 9/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageManager : NSObject

+ (instancetype)sharedInstance;

+ (NSString*)setLanguageString:(NSString*)string;
+ (NSString*)getLanguageExtension;

@end

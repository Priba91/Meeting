//
//  LanguageManager.m
//  Convoy Caravan
//
//  Created by Priba on 9/4/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "LanguageManager.h"

@implementation LanguageManager

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (NSString*)setLanguageString:(NSString*)string
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"language_str"] != nil){
        NSString *str;
        NSString *path;
        
        path = [[NSBundle mainBundle] pathForResource:[self getLanguageExtension] ofType:@"lproj"];
        
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        str = [languageBundle localizedStringForKey:string value:@"" table:nil];
        return str;
    }else{
        return NSLocalizedString(string, nil);
    }
    
}

+ (NSString*)getLanguageExtension
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"language_str"] != nil){
        
        NSString *langStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"language_str"];
        
        if([langStr isEqualToString:@"SW"]){
            return @"sw";
        }else{
            return @"en";
        }
    }else{
        NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
        NSDictionary *languageDic = [NSLocale componentsFromLocaleIdentifier:language];
        NSString *languageCode = [languageDic objectForKey:@"kCFLocaleLanguageCodeKey"];
        
        return languageCode;
    }
}

@end

//
//  SosPopup.h
//  Convoy Caravan
//
//  Created by Priba on 11/13/19.
//  Copyright © 2019 Priba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SosPopup : UIView <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UITextView *messageTextView;


@property (weak, nonatomic) IBOutlet UIButton *sendSosBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *sosIconImageView;

@end

NS_ASSUME_NONNULL_END

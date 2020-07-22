//
//  InfoPopupView.h
//  Convoy Caravan
//
//  Created by Priba on 9/8/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportPopup : UIView <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UITextView *reportTextView;

@property (weak, nonatomic) IBOutlet UIButton *sendReportBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *reportiIconImageView;


@end

//
//  InfoPopupView.m
//  Convoy Caravan
//
//  Created by Priba on 9/8/18.
//  Copyright © 2018 Priba. All rights reserved.
//

#import "ReportPopup.h"
#import "ColorDefinitions.h"
#import "Utils.h"
#import "LanguageManager.h"

@implementation ReportPopup 

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.backView.layer setCornerRadius:8];
    [self.reportTextView.layer setCornerRadius:8];

    [self.reportTextView.layer setBorderWidth:1.5];
    [self.reportTextView.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGestureAction)];
    [self.backgroundView addGestureRecognizer:backTap];
    [self.reportiIconImageView setTintColor:BASE_BAR_COLOR1];
    [Utils addGradientToView:self.sendReportBtn];

    [Utils addHalfHightCornerRadiusToView:self.sendReportBtn];
    self.reportTextView.text = [LanguageManager setLanguageString:@"write_report"];
    self.reportTextView.textColor = [UIColor lightGrayColor];
    self.reportTextView.delegate = self;
    [self.reportTextView setContentInset:UIEdgeInsetsMake(8, 8, 8, 8)];
}

- (void)backGestureAction{
    [self endEditing:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeReportView" object:nil userInfo:nil];
}

- (IBAction)reportBtnAction:(id)sender {
    [self endEditing:YES];

}

#pragma mark - Text View Delegate

- (void)textViewDidChange:(UITextView *)textView {;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:[LanguageManager setLanguageString:@"write_report"]]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = [LanguageManager setLanguageString:@"write_report"];
        textView.textColor = [UIColor lightGrayColor];
    }
    
    [textView resignFirstResponder];
}

@end

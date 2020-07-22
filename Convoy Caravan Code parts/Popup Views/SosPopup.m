//
//  SosPopup.m
//  Convoy Caravan
//
//  Created by Priba on 11/13/19.
//  Copyright © 2019 Priba. All rights reserved.
//

#import "SosPopup.h"
#import "ColorDefinitions.h"
#import "Utils.h"
#import "LanguageManager.h"

@implementation SosPopup

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.backView.layer setCornerRadius:8];
    [self.messageTextView.layer setCornerRadius:8];

    [self.messageTextView.layer setBorderWidth:1.5];
    [self.messageTextView.layer setBorderColor:[[UIColor systemRedColor] CGColor]];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGestureAction)];
    [self.backgroundView addGestureRecognizer:backTap];

    [Utils addHalfHightCornerRadiusToView:self.sosIconImageView];
    [Utils addHalfHightCornerRadiusToView:self.sendSosBtn];

    [self.sendSosBtn setTitle:[[LanguageManager setLanguageString:@"send_sos"] uppercaseString] forState:UIControlStateNormal];
    
    self.messageTextView.text = [LanguageManager setLanguageString:@"write_sos_message"];
    self.messageTextView.textColor = [UIColor lightGrayColor];
    self.messageTextView.delegate = self;
    [self.messageTextView setContentInset:UIEdgeInsetsMake(8, 8, 8, 8)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willShowKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willHideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)backGestureAction{
    [self endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeSosPopup" object:@{@"sosText":@""}];
}

- (IBAction)reportBtnAction:(id)sender {
    [self endEditing:YES];

}

#pragma mark - Text View Delegate

- (void)textViewDidChange:(UITextView *)textView {;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:[LanguageManager setLanguageString:@"write_sos_message"]]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = [LanguageManager setLanguageString:@"write_sos_message"];
        textView.textColor = [UIColor lightGrayColor];
    }
    
    [textView resignFirstResponder];
}

#pragma mark - Button Actions -

- (IBAction)sendSosBtnAction:(id)sender {
    
    NSString *message = self.messageTextView.text;
    if([message isEqualToString:[LanguageManager setLanguageString:@"write_sos_message"]]){
        message = @"";
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeSosPopup" object:@{@"sosText":message}];
}

#pragma mark - Keyboard methods -

- (void)willShowKeyboard:(NSNotification*)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
     
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGFloat cons = 120;
        if([Utils isIphoneXSeries]){
            cons = 80;
        }
        
        CGRect f = self.frame;
        f.origin.y = -cons;
        self.frame = f;
    }];
    
}

- (void)willHideKeyboard:(NSNotification*)notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.frame;
        f.origin.y = 0.0f;
        self.frame = f;
    }];
}

@end

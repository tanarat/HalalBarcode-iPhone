//
//  ViewController.h
//  BarcodeDemo
//
//  Created by Teeppiphat Phokaewkul on 11/15/55 BE.
//  Copyright (c) 2555 HummingBits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ViewController : UIViewController <ZBarReaderDelegate, UIWebViewDelegate>
{
    UIImage *resultImage;
    UITextField *resultText;
    UIWebView *webContentView;
}

@property (nonatomic, retain) UIImage *resultImage;
@property (nonatomic, retain) IBOutlet UIWebView *webContentView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sendButton;
@property (strong, nonatomic) IBOutlet UITextField *resultText;

- (IBAction) scanButtonTapped;
- (IBAction) sendButtonTapped:(id)sender;

@end

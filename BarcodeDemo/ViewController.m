//
//  ViewController.m
//  BarcodeDemo
//
//  Created by Teeppiphat Phokaewkul on 11/15/55 BE.
//  Copyright (c) 2555 HummingBits. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize resultImage, resultText, sendButton, webContentView;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webContentView.delegate = self;
    [webContentView setBackgroundColor:[UIColor clearColor]];
    self.webContentView.scalesPageToFit = YES;
    self.webContentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    [self webContentLoadRequest];
}


-(void) webContentLoadRequest
{
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://161.200.192.38/silkadmin/halal/search?barcode=%@&cachebuster=%0.0f",
                                       resultText.text,
                                       [[NSDate date]timeIntervalSince1970]]];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval: 10.0];
    [webContentView loadRequest:requestObj];
}


#pragma mark - **********************************
#pragma mark : *** webView Delegate
#pragma mark - **********************************

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //[self showLoading];
    
    NSLog(@"webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[self hideLoading];
    NSLog(@"webViewDidFinishLoad");
}




- (IBAction) scanButtonTapped
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentModalViewController: reader
                            animated: YES];
}

- (IBAction)sendButtonTapped:(id)sender
{
    [self webContentLoadRequest];
}



- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    resultText.text = symbol.data;
    
    
    [self webContentLoadRequest];
    
    // EXAMPLE: do something useful with the barcode image
    resultImage = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
}



- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}


- (void)viewDidUnload {
    [self setResultText:nil];
    [self setSendButton:nil];
    [super viewDidUnload];
}
@end

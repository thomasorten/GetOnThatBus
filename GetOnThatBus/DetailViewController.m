//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Thomas Orten on 5/28/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *routesLabel;
@property (weak, nonatomic) IBOutlet UITextView *transfersTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addressLabel.text =  [self.stop objectForKey:@"cta_stop_name"];
    self.routesLabel.text = [self.stop objectForKey:@"routes"];;
    self.transfersTextView.text = [self.stop objectForKey:@"inter_modal"];;
}

@end

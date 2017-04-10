//
//  ViewController.m
//  Demo
//
//  Created by Marian Frische on 05.03.16.
//  Copyright © 2016 proximi.io. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ProximiioDelegate>
{
    MKPointAnnotation *_annotation;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *token = @"REPLACE_YOUR_PROXIMIIO_TOKEN";
    
    [[Proximiio sharedInstance] setDelegate:self];
    [[Proximiio sharedInstance] authWithToken:token callback:^(ProximiioState result) {
        if (result == kProximiioReady) {
            NSLog(@"proximi.io is authorized and ready");
            [[Proximiio sharedInstance] requestPermissions];
        } else {
            NSLog(@"proximi.io authorization unsuccessful, please check your token");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)proximiioPositionUpdated:(CLLocation *)location
{
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance([location coordinate], 1, 1) animated:YES];
    
    if(!_annotation)
    {
        _annotation = [[MKPointAnnotation alloc] init];
        [_annotation setCoordinate:[location coordinate]];
        [_annotation setTitle:@"Detected Position"];
        [_mapView addAnnotation:_annotation];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            [_annotation setCoordinate:[location coordinate]];
        }];
    }
}

@end

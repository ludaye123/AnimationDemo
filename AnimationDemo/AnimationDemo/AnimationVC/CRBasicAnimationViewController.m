//
//  CRBasicAnimationViewController.m
//  AnimationDemo
//
//  Created by LS on 18/12/2017.
//  Copyright © 2017 LS. All rights reserved.
//

#import "CRBasicAnimationViewController.h"

#import <CoreGraphics/CoreGraphics.h>

@interface CRBasicAnimationViewController ()

@end

@implementation CRBasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交互式动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = ^{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.backgroundColor = [UIColor orangeColor];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 1001;
        [self.view addSubview:imageView];
        
        return imageView;
    }();
    
    
    UISlider *slider = ^{
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        slider.minimumValue = 0;
        slider.maximumValue = 1;
        [slider addTarget:self action:@selector(handleSliderAction:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
        
        return slider;
    }();
    
    ^{
        NSDictionary *viewDict = NSDictionaryOfVariableBindings(imageView, slider);
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40.0-[imageView]-40.0-|" options:0 metrics:nil views:viewDict]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70.0-[imageView(300.0)]" options:0 metrics:nil views:viewDict]];

        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40.0-[slider]-40.0-|" options:0 metrics:nil views:viewDict]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-30.0-[slider(40.0)]" options:0 metrics:nil views:viewDict]];
    }();
    
    // add animation
    ^{
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        basicAnimation.fromValue = @(0);
        basicAnimation.toValue = @(M_PI);
        basicAnimation.duration = (NSTimeInterval)1;
        basicAnimation.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.17 :0.67 :0.71 :0.15];
        [imageView.layer addAnimation:basicAnimation forKey:@"rotation.y"];
        imageView.layer.speed = 0.0;
    }();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event

- (void)handleSliderAction:(UISlider *)sender {
//    NSLog(@"%f", [sender value]);
    UIImageView *imageView = [self.view viewWithTag:1001];
    imageView.layer.timeOffset = (NSTimeInterval)[sender value];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  W6 - UIDynamics
//
//  Created by Daniel Mathews on 2015-06-10.
//  Copyright © 2015 Daniel Mathews. All rights reserved.
//

#import "ViewController.h"

const float kSquareViewBoxHeight = 100;

@interface ViewController ()

@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravity;
@property (nonatomic) UICollisionBehavior *collision;
@property (nonatomic) UIView *alertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
}

- (IBAction)showAlertPressed:(UIButton *)sender {
    
    if (!self.alertView) {
        [self createAlertView];
    }
    
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.alertView snapToPoint:self.view.center];
    [self.animator addBehavior:snapBehaviour];
}

- (void) createAlertView {
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 150)];
    alertView.backgroundColor = [UIColor redColor];
    alertView.alpha = 1.0;
    alertView.layer.cornerRadius = 10;
    alertView.layer.shadowColor = [UIColor blackColor].CGColor;
    alertView.layer.shadowOffset = CGSizeMake(0, 10);
    alertView.layer.shadowOpacity = 0.7;
    alertView.layer.shadowRadius = 5.0;
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setFrame:CGRectMake(alertView.frame.size.width - 20, 0, 20, 20)];
    [closeButton setTintColor:[UIColor whiteColor]];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:closeButton];
    
    self.alertView = alertView;
    
    [self.view addSubview:self.alertView];
    
}

- (void) dismissAlert:(UIButton *)sender {
    
    [self.animator removeAllBehaviors];
    
    UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.alertView]];
    [self.animator addBehavior:gravityBehaviour];
    
    UIDynamicItemBehavior *itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems: @[ self.alertView ]];
    [itemBehaviour addAngularVelocity:-(CGFloat)M_PI forItem:self.alertView];
    [self.animator addBehavior:itemBehaviour];
    
    [UIView animateWithDuration:2 animations:^{
        
        self.alertView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.alertView removeFromSuperview];
        self.alertView = nil;
    }];
    

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

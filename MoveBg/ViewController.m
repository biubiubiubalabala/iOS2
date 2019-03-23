//
//  ViewController.m
//  MoveBg
//
//  Created by 李斯然 on 2019/3/23.
//  Copyright © 2019年 siranlee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/***/
@property (nonatomic,strong)UIImageView * imagView;
/***/
@property (nonatomic,assign)int temp;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.使用uiview的动画
    CGFloat h;
    CGFloat w;
    UIImage * image = [UIImage imageNamed:@"timg"];
    if (image.size.height<self.view.frame.size.height) {
        h = self.view.frame.size.height;
        w = image.size.width/image.size.height * h;
    }else{
        h = image.size.height;
        w = image.size.width;
    }
    self.imagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -(self.view.frame.size.height-h)/2.0, w, h)];
    self.imagView.image = image;
    self.imagView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imagView];
    //使用kvo实现来回循环
//    [self addObserver:self forKeyPath:@"temp" options:NSKeyValueObservingOptionNew context:nil];
    //2.使用cabasicanimation的动画
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [UIView animateWithDuration:4 animations:^{
        self.imagView.transform = CGAffineTransformTranslate(self.imagView.transform, -(self.imagView.frame.size.width-self.view.frame.size.width), 0);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:4 animations:^{
            self.imagView.transform = CGAffineTransformTranslate(self.imagView.transform, (self.imagView.frame.size.width-self.view.frame.size.width), 0);
        }completion:^(BOOL finished) {
            self.temp = !self.temp;
        }];
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.temp = 1;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = @((self.imagView.frame.size.width/2));
    //是从中心点开始移动的
    animation.toValue = @(-(self.imagView.frame.size.width/2-self.view.frame.size.width));
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = YES;
    animation.duration = 7;
    [self.imagView.layer addAnimation:animation forKey:nil];
}
-(void)move{
   
}
@end

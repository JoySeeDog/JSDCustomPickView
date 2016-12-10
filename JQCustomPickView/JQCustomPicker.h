//
//  JQCustomPicker.h
//  JQCustomPickView
//
//  Created by jianquan on 2016/10/19.
//  Copyright © 2016年 JoySeeDog. All rights reserved.
//
#define SCREEN_HEIGHT                                             ([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
#define SCREEN_WIDTH                                              ([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)

#define SCALE_6                                                   (SCREEN_WIDTH / 375)
#import <UIKit/UIKit.h>

@protocol JQPickerDelegate <NSObject>

@optional

- (void)pickerCallBack:(NSString *)leftString rightString:(NSString *)rightString;

@end

@interface JQCustomPicker : UIView

@property (nonatomic, weak) id<JQPickerDelegate> delegate;
- (instancetype)initWithSelectedBackColor:(UIColor *)selectedBackColor
                                textColor:(UIColor *)textColor
                               plainColor:(UIColor *)plainColor
                                    title:(NSString *)title
                              leftArray:(NSArray *)leftArray
                               rightArray:(NSArray *)rightArray;

- (void)showInView:(UIView *)superView;
@end

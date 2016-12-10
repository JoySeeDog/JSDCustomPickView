//
//  JQCustomPicker.m
//  JQCustomPickView
//
//  Created by jianquan on 2016/10/19.
//  Copyright © 2016年 JoySeeDog. All rights reserved.
//


#import "JQCustomPicker.h"



@interface JQCustomPicker()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIColor *selectedBackColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *plainColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *leftArray;
@property (nonatomic, strong) NSArray *rightArray;

@property (nonatomic, copy) NSString *left;
@property (nonatomic, copy) NSString *right;

@end
@implementation JQCustomPicker

- (instancetype)initWithSelectedBackColor:(UIColor *)selectedBackColor textColor:(UIColor *)textColor plainColor:(UIColor *)plainColor title:(NSString *)title leftArray:(NSArray *)leftArray rightArray:(NSArray *)rightArray{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.title = title;
        self.selectedBackColor  = selectedBackColor;
        self.textColor  = textColor;
        self.plainColor = plainColor;
        self.leftArray = [NSArray arrayWithArray:leftArray];
        self.rightArray = [NSArray arrayWithArray:rightArray];
        [self commonInit];
    }
    return self;
    
}

- (void)commonInit {
    [self addSubview:self.backgroundButton];
    [self.backgroundButton addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.cancelButton];
    [self.headerView addSubview:self.confirmButton];
    [self.headerView addSubview:self.pickerView];
    
    
}

- (void)removePickView {
    [UIView animateWithDuration:0.3 animations:^{
        self.headerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 245*SCALE_6);
        self.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)confirmButtonAction {
    [self removePickView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerCallBack:rightString:)]) {
        [self.delegate pickerCallBack:self.left rightString:self.right];
    }
}

- (void)showInView:(UIView *)superView {
    
    [UIView animateWithDuration:0.3 animations:^{
        [superView addSubview:self];
        self.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.headerView.frame = CGRectMake(0, SCREEN_HEIGHT - 245*SCALE_6, SCREEN_WIDTH, 245*SCALE_6);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}



#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        return self.leftArray.count;
    }else if (component==1) {
        return self.rightArray.count;
    }else {
    return self.rightArray.count;
    }
    
    return 0;
}


-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35.0*SCALE_6;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREEN_WIDTH/3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (!component) {
        self.left = self.leftArray[row];
        [pickerView selectRow:row inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
        
        [pickerView selectRow:row inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
        
    }else if(component==1){
        self.right = self.rightArray[row];
        
        [pickerView selectRow:row inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    }else {
     self.right = self.rightArray[row];
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0) {
        return self.leftArray[row];
        
    }else if(component==1){
        return self.rightArray[row];
    }else {
    return self.rightArray[row];
    }
    
    
    
}

//Change style
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
    CGFloat width = [self pickerView:self.pickerView widthForComponent:component];
    CGFloat rowheight =[self pickerView:self.pickerView rowHeightForComponent:(component)];
    
    UIView *myView = [[UIView alloc]init];
    myView.frame =CGRectMake(0.0f, 0.0f, width, rowheight);
    UILabel *txtlabel = [[UILabel alloc] init];
    txtlabel.textColor = self.plainColor;
    txtlabel.tag=200;
    txtlabel.font = [UIFont systemFontOfSize:15*SCALE_6];
    txtlabel.textAlignment  = NSTextAlignmentCenter;
    txtlabel.frame = myView.frame;
    txtlabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    [myView addSubview:txtlabel];
    
    UIView* topLine   =   [pickerView.subviews objectAtIndex:1];
    UIView* botomLine   =   [pickerView.subviews objectAtIndex:2];
    topLine.hidden = YES;
    botomLine.hidden = YES;
    
    
    BOOL isSetttingBackColor = NO;
    
    UIView *subview = [self.pickerView.subviews firstObject];
    
    for ( UIView *pickerColumnView in subview.subviews) {
        
        NSLog(@"pickerColumnView class %@",[pickerColumnView class]);

        UIView *pickerView = [pickerColumnView.subviews lastObject];
        if (!isSetttingBackColor) {
             pickerView.backgroundColor = self.selectedBackColor;
            isSetttingBackColor = !isSetttingBackColor;
        }
       
        UIView *tableView = [pickerView.subviews lastObject];
        for (UIView *cell in tableView.subviews) {
            NSLog(@"cell class %@",[cell class]);
            UIView *cellview  = [cell.subviews lastObject];
            UIView *labelSuper = [cellview.subviews lastObject];
            UILabel *label = [labelSuper.subviews lastObject];
            label.textColor = [UIColor whiteColor];
        }

    }
    
    
    return myView;
}


#pragma -mark getter
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45*SCALE_6, SCREEN_WIDTH, 245*SCALE_6)];
        // 显示选中框
        _pickerView.showsSelectionIndicator = NO;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}


- (UIButton *)backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backgroundButton.backgroundColor = [UIColor clearColor];
        [_backgroundButton addTarget:self action:@selector(removePickView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundButton;
    
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView= [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 245*SCALE_6)];
        _headerView.backgroundColor = self.selectedBackColor;
        
    }
    return _headerView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45*SCALE_6)];
        _titleLabel.text = self.title;
        _titleLabel.font = [UIFont systemFontOfSize:15*SCALE_6];
        _titleLabel.textColor = [self.textColor colorWithAlphaComponent:0.5];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}



- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60*SCALE_6, 45*SCALE_6)];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15*SCALE_6];
        [_cancelButton setTitleColor:self.textColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(removePickView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelButton;
    
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 48*SCALE_6, 0, 48*SCALE_6,45*SCALE_6)];
        [_confirmButton setTitle:@"Done" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:self.textColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15*SCALE_6];;
        [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
    
}






@end

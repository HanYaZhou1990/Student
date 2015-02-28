//
//  PublicSaveViewController.m
//  KH_MobileShop
//
//  Created by yons on 13-10-16.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "PublicSaveViewController.h"
#import "MessageSave.h"
#import "ValidateTool.h"
@interface PublicSaveViewController ()
{
    UILabel *shortLimitLabel;
    UILabel *longLimitLabel;
}
@end

@implementation PublicSaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.titleStr;
    
    [self leftBarItem];
    
    if ([self.isSaveVerification isEqualToString:@"1"])
    {
        // 设置保存按键
        [self setRightNavigationBar];
    }
    
    if ([self.isUsedStr isEqualToString:@"短文本"])
    {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(-1, 10, SCREEN_WIDTH+2, 40)];
        bgView.backgroundColor = [UIColor whiteColor];
//        bgView.layer.cornerRadius = 5.0f;
        bgView.layer.borderColor = [UIColor grayColor].CGColor;
        bgView.layer.borderWidth = 0.5;
        [self.view addSubview:bgView];
        
        _textField = [[UITextField alloc]init];
        if (IOS7)
        {
            _textField.frame = CGRectMake(10, 13, SCREEN_WIDTH - 20, 40);
        }
        else
        {
            _textField.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, 40);
        }
        if (self.textFieldStr==nil||[self.textFieldStr isEqualToString:@""])
        {
            _textField.placeholder = @"请输入内容";
        }
        else
        {
            _textField.text = self.textFieldStr;
        }
        _textField.backgroundColor = [UIColor clearColor];
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_textField becomeFirstResponder];
        [self.view addSubview:_textField];
        
        if (_maxLenth>0)
        {
            shortLimitLabel = [[UILabel alloc] init];
            if (IOS7)
            {
                _textField.frame = CGRectMake(10, 13, SCREEN_WIDTH - 75, 40);
                shortLimitLabel.frame = CGRectMake(_textField.frame.origin.x + _textField.frame.size.width + 5, 13, 40, 40);
            }
            else
            {
                _textField.frame = CGRectMake(10, 20, SCREEN_WIDTH - 75, 40);
                shortLimitLabel.frame = CGRectMake(_textField.frame.origin.x + _textField.frame.size.width + 5, 20, 40, 40);
            }
            if (self.textFieldStr==nil||[self.textFieldStr isEqualToString:@""])
            {
                shortLimitLabel.text = [NSString stringWithFormat:@"%d", _maxLenth];
            }
            else
            {
                _textField.text = self.textFieldStr;
                shortLimitLabel.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)_textField.text.length, _maxLenth];
            }
            shortLimitLabel.textColor = [UIColor grayColor];
            shortLimitLabel.font = [UIFont systemFontOfSize:14.0f];
            shortLimitLabel.textAlignment = NSTextAlignmentRight;
            shortLimitLabel.backgroundColor = [UIColor clearColor];
            [self.view addSubview:shortLimitLabel];
        }
        
    }
    else
    {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(-1, 10, SCREEN_WIDTH+2, 154)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.borderColor = [UIColor grayColor].CGColor;
        bgView.layer.borderWidth = 0.5;
        [self.view addSubview:bgView];
        
        _uiTextView = [[UITextView alloc]init];
        _uiTextView.frame = CGRectMake(10, 15, SCREEN_WIDTH - 20, 125);
        _uiTextView.text = self.textFieldStr;
        _uiTextView.font = [UIFont systemFontOfSize:16];
        _uiTextView.backgroundColor = [UIColor clearColor];
        _uiTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _uiTextView.returnKeyType = UIReturnKeyDone;
        _uiTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _uiTextView.delegate = self;
        [_uiTextView becomeFirstResponder];
        [self.view addSubview:_uiTextView];
        
        if (_maxLenth>0)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
            
            longLimitLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 15, _uiTextView.frame.origin.y+_uiTextView.frame.size.height+3, 80, 20)];
            longLimitLabel.textColor = [UIColor grayColor];
            longLimitLabel.font = [UIFont systemFontOfSize:14.0f];
            longLimitLabel.textAlignment = NSTextAlignmentRight;
            longLimitLabel.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)_uiTextView.text.length, _maxLenth];
            [self.view addSubview:longLimitLabel];
        }
        
    }
 
}

- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 21.5, 13.5);
    [backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)popViewController
{
    if ([self.isSaveVerification isEqualToString:@"0"])
    {
        //不需要验证 直接保存
        NSString *testStr;
        if ([self.isUsedStr isEqualToString:@"短文本"])
        {
            [_textField resignFirstResponder];
            testStr=_textField.text;
        }
        else
        {
            [_uiTextView resignFirstResponder];
            testStr = _uiTextView.text;
        }
        //传值
        MessageSave *mS = [MessageSave new];
        mS.saveMessage = testStr;
        mS.titleString = self.titleStr;
        [self.publicSaveVCdelegate publicSaveMessage:mS];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//设置右边的添加按键
- (void)setRightNavigationBar
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(10, 7, 80, 30);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)btnClick
{
    NSString *testStr;
    if ([self.isUsedStr isEqualToString:@"短文本"])
    {
        [_textField resignFirstResponder];
        testStr=_textField.text;
    }
    else
    {
        [_uiTextView resignFirstResponder];
        testStr = _uiTextView.text;
    }

    NSString *text = [testStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (text==nil ||[text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        if ([self.isUsedStr isEqualToString:@"短文本"])
        {
             [_textField becomeFirstResponder];
        }
        else
        {
             [_uiTextView becomeFirstResponder];
        }
        
    }
    else
    {
        if (self.isValidateStr.length>0)
        {
           if ([self.isValidateStr isEqualToString:@"邮箱"])
            {
                //邮箱
                BOOL isUse = [ValidateTool validateEmail:testStr];
                if (isUse==NO)
                {
                    [PublicConfig waringInfo:@"邮箱格式不正确"];
                    return;
                }
            }
            else if ([self.isValidateStr isEqualToString:@"手机号码"])
            {
                //手机号码
                BOOL isUse = [ValidateTool validateMobile:testStr];
                if (isUse==NO)
                {
                    [PublicConfig waringInfo:@"手机号码格式不正确"];
                    return;
                }
            }
            else if ([self.isValidateStr isEqualToString:@"身份证号"]||[self.isValidateStr isEqualToString:@"身份证"])
            {
                //身份证号
                BOOL isUse = [ValidateTool validateIdentityCard:testStr];
                if (isUse==NO)
                {
                    [PublicConfig waringInfo:@"身份证号格式不正确"];
                    return;
                }
            }
            else if ([self.isValidateStr isEqualToString:@"护照"])
            {
                //护照
                BOOL isUse = [ValidateTool validatePassport:testStr];
                if (isUse==NO)
                {
                    [PublicConfig waringInfo:@"护照格式不正确"];
                    return;
                }
            }
            else if ([self.isValidateStr isEqualToString:@"年龄"])
            {
                //年龄
                BOOL isUse = [ValidateTool validateAge:testStr];
                if (isUse==NO)
                {
                    [PublicConfig waringInfo:@"年龄格式不正确"];
                    return;
                }
            }
        }
        //传值
        MessageSave *mS = [MessageSave new];
        mS.saveMessage = text;
        mS.titleString = self.titleStr;
        [self.publicSaveVCdelegate publicSaveMessage:mS];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma -
#pragma mark UITextFieldDelagate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.isSaveVerification isEqualToString:@"1"])
    {
        [self btnClick];
    }
    if ([self.isSaveVerification isEqualToString:@"0"])
    {
        [self popViewController];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_maxLenth>0)
    {
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength <= _maxLenth || replaceLength <= selectedLength)
        {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (_maxLenth>0)
    {
        if (textField.text.length > _maxLenth && textField.markedTextRange == nil)
        {
            textField.text = [textField.text substringToIndex:_maxLenth];
        }
        shortLimitLabel.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)textField.text.length, _maxLenth];
    }
}

#pragma -
#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //若输入换行符隐藏键盘
    if ([text isEqualToString:@"\n"])
    {
        if ([self.isSaveVerification isEqualToString:@"1"])
        {
            [self btnClick];
        }
        if ([self.isSaveVerification isEqualToString:@"0"])
        {
            [self popViewController];
        }
    }
    if (_maxLenth>0)
    {
        longLimitLabel.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)_uiTextView.text.length, _maxLenth];
    }
    return YES;
}

- (void)textViewDidChange:(NSNotificationCenter *)notification
{
    if (_maxLenth > 0 && _uiTextView.text.length > _maxLenth && _uiTextView.markedTextRange == nil)
    {
        _uiTextView.text = [_uiTextView.text substringToIndex:_maxLenth];
        longLimitLabel.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)_uiTextView.text.length, _maxLenth];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

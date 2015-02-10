//
//  CoachDetailViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/6.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CoachDetailViewController.h"
#import "CoachDetailModel.h"
#import "UIImageView+WebCache.h"

@interface CoachDetailViewController ()<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    CoachDetailModel *coachDetailModel;
    
    UIButton *dailyBtn;
    UIButton *nightBtn;
    UIButton *weekendBtn;
    
    UILabel *btnLabel;
    
    UIButton *orderBtn;
    
    int btnType;
    
    
}
@end

@implementation CoachDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"教练详情";
    
    [self leftBarItem];
    
    btnType = -1;
    
    [self getData];
    
    [self setTheScrollView];
    
}

- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 21.5, 13.5);    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark - 数据相关
-(void)getData
{
    coachDetailModel = [[CoachDetailModel alloc]init];
    
}

#pragma mark -
#pragma mark - 初始化各View

//设置tableview属性
- (void)setTheScrollView
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT)];
    [scrollView setDelegate:self];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    [self.view addSubview:scrollView];
}

-(void)setUseView
{
    UIView *oneBgView = [[UIView alloc]init];
    oneBgView.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 200);
    oneBgView.layer.masksToBounds = YES;
    oneBgView.layer.cornerRadius = 4;
    oneBgView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:oneBgView];
    
    UIImageView *bgImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 85)];
    bgImageView.image = [UIImage imageNamed:@"square_item_bg.png"];
    [oneBgView addSubview:bgImageView];
    
    //头像
    UIImageView *headImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 60, 60)];
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.cornerRadius=30;
    NSString *imageStr = coachDetailModel.headImage;
    if (imageStr==nil||[imageStr isEqualToString:@""])
    {
        headImageView.image = [UIImage imageNamed:@"memberBg.png"];
    }
    else
    {
        NSString *__imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)imageStr, nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"memberBg.png"];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:__imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL)
         {
         }];
    }
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [oneBgView addSubview:headImageView];
    
    UILabel *userNameLabel = [[UILabel alloc]init];
    userNameLabel.frame = CGRectMake(75, 14, 60, 15);
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.textColor = [UIColor blackColor];
    userNameLabel.font = [UIFont systemFontOfSize:13];
    userNameLabel.backgroundColor = [UIColor clearColor];
    userNameLabel.text = coachDetailModel.userName;
    [oneBgView addSubview:userNameLabel];
    
    UILabel *drivingSchoolLabel = [[UILabel alloc]init];
    drivingSchoolLabel.frame = CGRectMake(140, 14, SCREEN_WIDTH-220, 15);
    drivingSchoolLabel.textAlignment = NSTextAlignmentLeft;
    drivingSchoolLabel.textColor = [UIColor grayColor];
    drivingSchoolLabel.font = [UIFont systemFontOfSize:12];
    drivingSchoolLabel.backgroundColor = [UIColor clearColor];
    drivingSchoolLabel.text = coachDetailModel.drivingSchool;
    [oneBgView addSubview:drivingSchoolLabel];
    
    UILabel *scoreLabel = [[UILabel alloc]init];
    scoreLabel.frame = CGRectMake(SCREEN_WIDTH-20-62, 5, 60, 15);
    scoreLabel.textAlignment = NSTextAlignmentRight;
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.font = [UIFont systemFontOfSize:13];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.text = [NSString stringWithFormat:@"%@分",coachDetailModel.score];
    [oneBgView addSubview:scoreLabel];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.frame = CGRectMake(75, 37, SCREEN_WIDTH-20-75, 15);
    phoneLabel.textAlignment = NSTextAlignmentRight;
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = [UIFont systemFontOfSize:11];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = [NSString stringWithFormat:@"电话:%@",coachDetailModel.phone];
    [oneBgView addSubview:phoneLabel];
    
    UILabel *feesLabel = [[UILabel alloc]init];
    feesLabel.frame = CGRectMake(75, 55, SCREEN_WIDTH-20-75, 20);
    feesLabel.textAlignment = NSTextAlignmentLeft;
    feesLabel.textColor = RGBA(0, 165, 109, 1);
    feesLabel.font = [UIFont systemFontOfSize:16];
    feesLabel.backgroundColor = [UIColor clearColor];
    feesLabel.text = coachDetailModel.fees;
    [oneBgView addSubview:feesLabel];
    
    UILabel *goNumberLabel = [[UILabel alloc]init];
    goNumberLabel.frame = CGRectMake(75, 75, 115, 15);
    goNumberLabel.textAlignment = NSTextAlignmentLeft;
    goNumberLabel.textColor = [UIColor grayColor];
    goNumberLabel.font = [UIFont systemFontOfSize:10];
    goNumberLabel.backgroundColor = [UIColor clearColor];
    goNumberLabel.text = [NSString stringWithFormat:@"%@人上过",coachDetailModel.goNumber];
    [oneBgView addSubview:goNumberLabel];
    
    UILabel *studyNumberLabel = [[UILabel alloc]init];
    studyNumberLabel.frame = CGRectMake(SCREEN_WIDTH-30-(SCREEN_WIDTH-190), 75, SCREEN_WIDTH-190, 15);
    studyNumberLabel.textAlignment = NSTextAlignmentRight;
    studyNumberLabel.textColor = [UIColor grayColor];
    studyNumberLabel.font = [UIFont systemFontOfSize:10];
    studyNumberLabel.backgroundColor = [UIColor clearColor];
    studyNumberLabel.text = [NSString stringWithFormat:@"%@人正在学习",coachDetailModel.studyNumber];
    [oneBgView addSubview:studyNumberLabel];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, 90, SCREEN_WIDTH-20, 1);
    lineLabel.backgroundColor = RGBA(235, 235, 235, 1);
    [oneBgView addSubview:lineLabel];
    
    NSArray *btnTitleArray = @[@"日常班",@"夜间班",@"双休班"];
    
    for (int i=0; i<btnTitleArray.count; i++)
    {
        UIButton *useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        useBtn.frame = CGRectMake(75+((SCREEN_WIDTH-95)/btnTitleArray.count)*i, 100, (SCREEN_WIDTH-95)/btnTitleArray.count, 30);
        [useBtn setBackgroundColor:[UIColor whiteColor]];
        [useBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        [useBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateHighlighted];
        [useBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
        [useBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
        useBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        useBtn.layer.masksToBounds=YES;
        useBtn.layer.cornerRadius=10;
        useBtn.layer.borderWidth = 1;
        useBtn.layer.borderColor = RGBA(0, 165, 109, 1).CGColor;
        useBtn.tag = 100+i;
        if (i==0)
        {
            dailyBtn = useBtn;
        }
        else if (i==1)
        {
            nightBtn = useBtn;
        }
        else if (i==2)
        {
            weekendBtn = useBtn;
        }
        [useBtn addTarget:self action:@selector(useBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [oneBgView addSubview:useBtn];
    }
    
    btnLabel = [[UILabel alloc]init];
    btnLabel.frame = CGRectMake(75, 135, SCREEN_WIDTH-95, 30);
    btnLabel.textAlignment = NSTextAlignmentLeft;
    btnLabel.numberOfLines = 2;
    btnLabel.textColor = [UIColor grayColor];
    btnLabel.font = [UIFont systemFontOfSize:10];
    btnLabel.backgroundColor = [UIColor clearColor];
    btnLabel.text = @"";
    [oneBgView addSubview:btnLabel];
    
    
    orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.frame = CGRectMake(75, 165, SCREEN_WIDTH-170, 40);
    [orderBtn setBackgroundColor:[UIColor whiteColor]];
    [orderBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [orderBtn setTitle:@"立即预约" forState:UIControlStateHighlighted];
    [orderBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    [orderBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    orderBtn.layer.masksToBounds=YES;
    orderBtn.layer.cornerRadius=10;
    orderBtn.layer.borderWidth = 1;
    orderBtn.layer.borderColor = RGBA(0, 165, 109, 1).CGColor;
    [orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [oneBgView addSubview:orderBtn];
    
}

#pragma mark -
#pragma mark - 点击事件
-(void)useBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag)
    {
        case 100:
        {
            //日常班
            btnType = 1;
        }
            break;
        case 101:
        {
            //夜间班
            btnType = 2;
        }
            break;
        case 102:
        {
            //双休班
            btnType = 3;
        }
            break;
            
        default:
            break;
    }
}

-(void)orderBtnClick:(id)sender
{
    if (btnType==-1)
    {
        [PublicConfig waringInfo:@"请先选择预约班次"];
    }
    else
    {
        //预约
        [orderBtn setBackgroundColor:RGBA(0, 165, 109, 1)];
        [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [orderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        
    }
}



#pragma mark -
#pragma mark - UIScrollViewDelegate


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

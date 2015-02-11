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
#import "OrderCoachViewController.h"

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
    coachDetailModel.headImage = @"http://img4.duitang.com/uploads/item/201404/15/20140415233353_WwtCY.thumb.700_0.jpeg";
    coachDetailModel.userName = @"韩亚周";
    coachDetailModel.drivingSchool =  @"友谊驾校 C照";
    coachDetailModel.score =  @"4.8";
    coachDetailModel.fees =  @"3000元 / 12节";
    coachDetailModel.goNumber =  @"128人上过";
    coachDetailModel.studyNumber =  @"1280人正在学习";
    coachDetailModel.phone =  @"15093372739";
    coachDetailModel.userInfo = @"操作教练：高中以上文凭，驾龄5年以上，无重大违法肇事行为，最近一个扣分周期无满分记录，照片，驾校手续，以驾校的名义向运管部门申请培训后参加考试，合格以后颁发操作教练员证";
    coachDetailModel.schoolInfo =  @"1、交通主管部门批准的正规驾校；2、一流的训练场地，具有位于市中心的地理优势，幽雅的训练环境；3、一流的教练员队伍，严把培训质量关是学校的第一宗旨，对每位学员负责，使每位学员都能学到真正的驾驶、车辆故障排除技术；4、充足的练车时间，无论白天、晚上、双休日只要您有时间，就可到校练车";
    coachDetailModel.paperImage =  @"http://image.baidu.com/i?ct=503316480&z=0&tn=baiduimagedetail&ipn=d&word=%E6%95%99%E7%BB%83%E8%AF%81&step_word=&pn=1&spn=0&di=190406708250&pi=&rn=1&is=&istype=2&ie=utf-8&oe=utf-8&in=22579&cl=2&lm=-1&st=-1&cs=2506799597%2C3754191755&os=166540971%2C3510408157&adpicid=0&ln=1000&fr=&fmq=1423634132825_R&ic=0&s=&se=1&sme=0&tab=&width=&height=&face=0&ist=&jit=&cg=&objurl=http%3A%2F%2Fimg.jxedt.com%2Fjl_pl%2F201212%2F23104542609.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Frs_z%26e3B3xj1p_z%26e3Bv54AzdH3F8a8mbAzdH3F";
    coachDetailModel.userAddress =  @"中州大道东风路交叉口路东";
    coachDetailModel.curriculumArray =  @[@"1.初级班   8小时 单人单车",@"2.中级班   12小时 单人单车",@"3.高级班   8小时 1人单车"];
    coachDetailModel.timeArray =  @[@"空闲",@"普通",@"普通",@"空闲",@"普通",@"普通",@"空闲",@"非常繁忙",@"普通",@"空闲",@"繁忙",@"普通"];
}

#pragma mark -
#pragma mark - 初始化各View

//设置tableview属性
- (void)setTheScrollView
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT)];
    [scrollView setDelegate:self];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    [self.view addSubview:scrollView];
    
    [self setUseView];
}

-(void)setUseView
{
    UIView *oneBgView = [[UIView alloc]init];
    oneBgView.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 205);
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
    phoneLabel.frame = CGRectMake(75, 32, SCREEN_WIDTH-20-75, 15);
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = [UIFont systemFontOfSize:11];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = [NSString stringWithFormat:@"电话:%@",coachDetailModel.phone];
    [oneBgView addSubview:phoneLabel];
    
    UILabel *feesLabel = [[UILabel alloc]init];
    feesLabel.frame = CGRectMake(75, 50, SCREEN_WIDTH-20-75, 20);
    feesLabel.textAlignment = NSTextAlignmentLeft;
    feesLabel.textColor = RGBA(0, 165, 109, 1);
    feesLabel.font = [UIFont systemFontOfSize:16];
    feesLabel.backgroundColor = [UIColor clearColor];
    feesLabel.text = coachDetailModel.fees;
    [oneBgView addSubview:feesLabel];
    
    UILabel *goNumberLabel = [[UILabel alloc]init];
    goNumberLabel.frame = CGRectMake(75, 70, 115, 15);
    goNumberLabel.textAlignment = NSTextAlignmentLeft;
    goNumberLabel.textColor = [UIColor grayColor];
    goNumberLabel.font = [UIFont systemFontOfSize:10];
    goNumberLabel.backgroundColor = [UIColor clearColor];
    goNumberLabel.text = [NSString stringWithFormat:@"%@人上过",coachDetailModel.goNumber];
    [oneBgView addSubview:goNumberLabel];
    
    UILabel *studyNumberLabel = [[UILabel alloc]init];
    studyNumberLabel.frame = CGRectMake(SCREEN_WIDTH-30-(SCREEN_WIDTH-190), 70, SCREEN_WIDTH-190, 15);
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
        useBtn.frame = CGRectMake(75+((SCREEN_WIDTH-95)/btnTitleArray.count)*i, 100, (SCREEN_WIDTH-95)/btnTitleArray.count-10, 30);
        [useBtn setBackgroundColor:[UIColor whiteColor]];
        [useBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        [useBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateHighlighted];
        [useBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
        [useBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
        useBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        useBtn.layer.masksToBounds=YES;
        useBtn.layer.cornerRadius=15;
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
    btnLabel.frame = CGRectMake(75, 133, SCREEN_WIDTH-95, 30);
    btnLabel.textAlignment = NSTextAlignmentLeft;
    btnLabel.numberOfLines = 2;
    btnLabel.textColor = [UIColor grayColor];
    btnLabel.font = [UIFont systemFontOfSize:12];
    btnLabel.backgroundColor = [UIColor clearColor];
    btnLabel.text = @"日常班为周一至周五白天下午上课";
    [oneBgView addSubview:btnLabel];
    
    
    orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.frame = CGRectMake(75, 165, SCREEN_WIDTH-170, 30);
    [orderBtn setBackgroundColor:RGBA(0, 165, 109, 1)];
    [orderBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [orderBtn setTitle:@"立即预约" forState:UIControlStateHighlighted];
    [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    orderBtn.layer.masksToBounds=YES;
    orderBtn.layer.cornerRadius=10;
    [orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [oneBgView addSubview:orderBtn];
    
    [self setCurriculumView];
    
}

//课程表
-(void)setCurriculumView
{
    NSUInteger useCount = coachDetailModel.curriculumArray.count;
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, 225, SCREEN_WIDTH, 55+useCount*25);
    [scrollView addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH-30, 15);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = RGBA(0, 165, 109, 1);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.text = @"课程表";
    [bgView addSubview:titleLabel];
    
    if (coachDetailModel.curriculumArray.count>0)
    {
        for (int i=0; i<coachDetailModel.curriculumArray.count; i++)
        {
            UILabel *leftLabel = [[UILabel alloc] init];
            leftLabel.frame = CGRectMake(15, 35+i*30, SCREEN_WIDTH-30, 30);
            leftLabel.textAlignment = NSTextAlignmentLeft;
            leftLabel.textColor = [UIColor blackColor];
            leftLabel.backgroundColor = [UIColor clearColor];
            leftLabel.font = [UIFont boldSystemFontOfSize:13];
            leftLabel.text = [coachDetailModel.curriculumArray objectAtIndex:i];
            [bgView addSubview:leftLabel];
        }
    }
    
    CGFloat height = bgView.frame.origin.y+bgView.frame.size.height;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, bgView.frame.size.height-1, SCREEN_WIDTH, 1);
    lineLabel.backgroundColor = RGBA(235, 235, 235, 1);
    [bgView addSubview:lineLabel];
    
    [self setUserInfoViewByHeight:height];
}

//我的自述
-(void)setUserInfoViewByHeight:(CGFloat)height
{
    NSString *contentStr = coachDetailModel.userInfo;
    CGFloat widthUse = SCREEN_WIDTH-30;
    CGFloat heightUse = [PublicConfig height:contentStr widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:12]];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, height, SCREEN_WIDTH, 55+heightUse);
    [scrollView addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH-30, 15);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = RGBA(0, 165, 109, 1);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.text = @"我的自述";
    [bgView addSubview:titleLabel];
    
    //自述
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.numberOfLines = 0;
    contentLabel.frame = CGRectMake(15, 45, widthUse, heightUse);
    contentLabel.text = contentStr;
    [bgView addSubview:contentLabel];
    
    
    CGFloat heightTemp = bgView.frame.origin.y+bgView.frame.size.height;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, bgView.frame.size.height-1, SCREEN_WIDTH, 1);
    lineLabel.backgroundColor = RGBA(235, 235, 235, 1);
    [bgView addSubview:lineLabel];
    
    [self setSchoolInfoViewByHeight:heightTemp];

}

//驾校信息
-(void)setSchoolInfoViewByHeight:(CGFloat)height
{
    NSString *contentStr = coachDetailModel.schoolInfo;
    CGFloat widthUse = SCREEN_WIDTH-30;
    CGFloat heightUse = [PublicConfig height:contentStr widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:12]];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, height, SCREEN_WIDTH, 55+heightUse);
    [scrollView addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH-30, 15);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = RGBA(0, 165, 109, 1);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.text = @"驾校信息";
    [bgView addSubview:titleLabel];
    
    //驾校信息
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.numberOfLines = 0;
    contentLabel.frame = CGRectMake(15, 45, widthUse, heightUse);
    contentLabel.text = contentStr;
    [bgView addSubview:contentLabel];
    
    
    CGFloat heightTemp = bgView.frame.origin.y+bgView.frame.size.height;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, bgView.frame.size.height-1, SCREEN_WIDTH, 1);
    lineLabel.backgroundColor = RGBA(235, 235, 235, 1);
    [bgView addSubview:lineLabel];
    
    [self setPaperInfoViewByHeight:heightTemp];
}

//教练证
-(void)setPaperInfoViewByHeight:(CGFloat)height
{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, height, SCREEN_WIDTH, 55+120);
    [scrollView addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH-30, 15);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = RGBA(0, 165, 109, 1);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.text = @"教练证";
    [bgView addSubview:titleLabel];
    
    //
    UIImageView *contentImgView =  [[UIImageView alloc] initWithFrame:CGRectMake(15, 45, SCREEN_WIDTH-30, 120)];
    if (coachDetailModel.paperImage.length==0)
    {
        contentImgView.image = [UIImage imageNamed:@"memberBg.png"];
    }
    else
    {
        NSString *__imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)coachDetailModel.paperImage, nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"memberBg.png"];
        [contentImgView sd_setImageWithURL:[NSURL URLWithString:__imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL)
         {
         }];
    }
    contentImgView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:contentImgView];
    
    
    CGFloat heightTemp = bgView.frame.origin.y+bgView.frame.size.height;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, bgView.frame.size.height-1, SCREEN_WIDTH, 1);
    lineLabel.backgroundColor = RGBA(235, 235, 235, 1);
    [bgView addSubview:lineLabel];
    
    [self setTimeInfoViewByHeight:heightTemp];
}

-(void)setTimeInfoViewByHeight:(CGFloat)height
{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, height, SCREEN_WIDTH, 280);
    [scrollView addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH-30, 15);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = RGBA(0, 165, 109, 1);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.text = @"教练2015年时间表";
    [bgView addSubview:titleLabel];
    
    //时间表
    UIImageView *contentImgView =  [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-293)/2, 45, 293, 173)];
    contentImgView.image = [UIImage imageNamed:@"square_detail_timetable_bg.png"];
    [bgView addSubview:contentImgView];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(0, 0, 293, 23);
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.font = [UIFont boldSystemFontOfSize:13];
    timeLabel.text = @"2015年";
    [contentImgView addSubview:timeLabel];
    
    for (int i=0; i<coachDetailModel.timeArray.count; i++){
        long xx = i%4;
        long yy = i/4;
        
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.frame = CGRectMake(xx*(293/4), 38+50*yy, 68, 50);
        stateLabel.textAlignment = NSTextAlignmentRight;
        stateLabel.textColor = [UIColor grayColor];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.font = [UIFont systemFontOfSize:13];
        stateLabel.text = [coachDetailModel.timeArray objectAtIndex:i];
        [contentImgView addSubview:stateLabel];
    }
    
    //教练地址
    UIImageView *contentLabelImgView =  [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-293)/2, 228, 293, 39.5)];
    contentLabelImgView.image = [UIImage imageNamed:@"square_detail_location.png"];
    [bgView addSubview:contentLabelImgView];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.frame = CGRectMake(30, 5, 263, 20);
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.textColor = [UIColor whiteColor];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.text = coachDetailModel.userAddress ;
    [contentLabelImgView addSubview:addressLabel];
    
    CGFloat heightTemp = bgView.frame.origin.y+bgView.frame.size.height;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, bgView.frame.size.height-1, SCREEN_WIDTH, 1);
    lineLabel.backgroundColor = RGBA(235, 235, 235, 1);
    [bgView addSubview:lineLabel];
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, heightTemp);
}

#pragma mark -
#pragma mark - 点击事件
-(void)useBtnClick:(id)sender
{
    //默认三个都是原状态
    [self setStateBtn];
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag)
    {
        case 100:
        {
            //日常班
            btnType = 1;
            btnLabel.text = @"日常班为周一至周五上午下午上课";
            [dailyBtn setBackgroundColor:RGBA(0, 165, 109, 1)];
            [dailyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [dailyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        }
            break;
        case 101:
        {
            //夜间班
            btnType = 2;
            btnLabel.text = @"夜间班为周一至周五下午6点至9点上课";
            [nightBtn setBackgroundColor:RGBA(0, 165, 109, 1)];
            [nightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [nightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        }
            break;
        case 102:
        {
            //双休班
            btnType = 3;
            btnLabel.text = @"夜间班为周六至周日全天上课";
            [weekendBtn setBackgroundColor:RGBA(0, 165, 109, 1)];
            [weekendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [weekendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
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
        
        OrderCoachViewController *vc = [[OrderCoachViewController alloc]init];
        vc.orderType = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//设置状态
-(void)setStateBtn
{
    [dailyBtn setBackgroundColor:[UIColor whiteColor]];
    [dailyBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    [dailyBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
    
    [nightBtn setBackgroundColor:[UIColor whiteColor]];
    [nightBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    [nightBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
    
    [weekendBtn setBackgroundColor:[UIColor whiteColor]];
    [weekendBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    [weekendBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
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

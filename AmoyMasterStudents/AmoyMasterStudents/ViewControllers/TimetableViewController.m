//
//  TimeTableViewController.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/26.
//  Copyright (c) 2015年 XHH. All rights reserved.

#import "TimetableViewController.h"
#import "RegisterViewController.h"
#import "CourseView.h"
#import "ResultTimeTableController.h"
#import <QuartzCore/QuartzCore.h>


// 排课，上课前通知
@interface TimetableViewController () <CourseViewDelegate>
{
    NSString *_courseType; // 排课上课or排课补课
    NSString *_coach; // 教练名称
    NSString *_course_date; // 上课时间
    NSString *_content; // 上课内容
    NSString *_beginTime; // 上课时间
    NSString *_endTime; // 结束上课时间
    int _flag; // 标记点击的是哪个按钮
    int _type; // 当前推送通知类型
    NSString *_url; // 网络请求地址
    NSDictionary *_params; // 网络请求参数
    CourseView *_courseView;
    UIScrollView *_timeTableScrollView;
    
}

@end

@implementation TimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TSFSutentColor;
    
    UIScrollView *timeTableScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    timeTableScrollView.showsVerticalScrollIndicator = false;

    _timeTableScrollView = timeTableScrollView;
    [self.view addSubview:timeTableScrollView];

    DLog(@"TimeTableViewController -- 传过来的内容:%@", _timeTableDict);
    _type = [self.timeTableDict[@"t"] intValue];
    /*
     200 ： 排课上课通知
     280 ： 排课补课通知
     */
    if (_type == 200) {
        _courseType = @"上课";
        // 响应教练排课的key是order_id
        
#pragma mark - 去服务器请求课程时间和内容
        NSString *url = [NSString stringWithFormat:@"%@%@", BASE_PLAN_URL,trainee_course_getPlanDetail];
        if(self.timeTableDict[@"order_id"] == nil){
            [SVProgressHUD showErrorWithStatus:@"没有排课内容"];
            return;
        }
        int order_id = [self.timeTableDict[@"order_id"] intValue];
        NSDictionary *params = @{@"orderId":@(order_id),@"token":[PublicConfig valueForKey:userToken]};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
            if ([responseObject[@"code"] intValue] == 0) {
                DLog(@" TimetableViewController responseObject %@", responseObject);
                NSDictionary *_data = responseObject[@"data"];
                _coach = _data[@"master_name"];
                _content = _data[@"class_desc"];
                _course_date = _data[@"course_date"];
                NSArray *course_datas = [_course_date componentsSeparatedByString:@";"];
                NSString *startTime = _data[@"begin"];
                
                // 在时间之前加"上课时间",在时间之后加beginTime
                NSString *replaceString = [NSString stringWithFormat:@"  %@\n上课时间    ",startTime];

                _course_date = [_course_date stringByReplacingOccurrencesOfString:@";" withString:replaceString];
                if (_courseView) {
                    _courseView.textLines = (int)course_datas.count; //  有多少个行间距需要加，不加1是因为count行就有count-1个行间距，加上最后一行上课内容(+1)
                    _courseView.notificationTitle.text = [NSString stringWithFormat:@"您的师傅 %@ 邀请您加入课程学习",_coach];
                    _beginTime = [NSString stringWithFormat:@"%@    %@",_course_date,startTime];
                    NSString *content = [NSString stringWithFormat:@"%@时间    %@\n%@内容    %@",_courseType, _beginTime,_courseType,_content];
//                    NSString *content = [NSString stringWithFormat:@"%@时间    %@    %@\n%@内容    %@", _courseType, _course_date,_beginTime, _courseType, _content];
                    _courseView.notificationContent.attributedText = [self stringToAttributeString:content];

                    [_courseView setNeedsLayout];
                }
                
            }else{
                DLog(@"排课详情获取失败：%@",responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLog(@"排课详情请求失败：%@",error);
        }];
        
    }else if(_type == 280){
        _courseType = @"补课";
        _beginTime = self.timeTableDict[@"begin"];
        _content = self.timeTableDict[@"desc"];
        _coach = self.timeTableDict[@"m_name"];
        
    }else if(_type == 201){ // 上课前
        _courseType = @"上课";
        _beginTime = self.timeTableDict[@"begin"];
        _content = self.timeTableDict[@"desc"];
        _coach = self.timeTableDict[@"m_name"];
        
    }
    
    self.title = [NSString stringWithFormat:@"%@确认", _courseType];
    [self addSubViews];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat padding = 17;
    _courseView.x = padding;
    _courseView.y = self.view.height * 0.1;
    _courseView.width = self.view.width - 2*padding;
    _timeTableScrollView.contentSize = CGSizeMake(self.view.width, CGRectGetMaxY(_courseView.frame) + self.view.height * 0.1);
}



- (void)addSubViews{
    
    // 白色的view
    CourseView *courseView = [[CourseView alloc] init];
    courseView.delegate = self;
    courseView.notificationTitle.text = [NSString stringWithFormat:@"您的师傅 %@ 邀请您加入课程学习",_coach];
    courseView.textLines =  1; // 默认是一个行间距需要加
//    NSString *content = [NSString stringWithFormat:@"%@时间    %@    %@\n%@内容    %@", _courseType, _course_date,_beginTime, _courseType, _content];
    NSString *content = [NSString stringWithFormat:@"%@时间    %@\n%@内容    %@",_courseType, _beginTime,_courseType,_content];
    courseView.notificationContent.attributedText = [self stringToAttributeString:content];
    [_timeTableScrollView addSubview:courseView];
    
    _courseView = courseView;

}

// 调整行距的富文本
- (NSMutableAttributedString *)stringToAttributeString:(NSString *)content{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:12];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    return attributedString;
    
}


# pragma 实现代理方法
- (void)haveTimeBtClick{
//    if (self.timeTableDict[@"class_id"] == nil || self.timeTableDict[@"order_id"] == nil) {
//        [SVProgressHUD showErrorWithStatus:@"课程不存在"];
//        return;
//    }
    
    _flag = 1; // 我有时间
    if(_type == 200){ // 上课排课
        _url = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL, trainee_course_replyOrder];
        _params = @{@"order_id":self.timeTableDict[@"order_id"],@"type":@(_flag),@"token":[PublicConfig valueForKey:userToken]};
    }else if(_type == 280){ // 补课排课
        _url = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL, trainee_course_replyOrder];
        _params = @{@"order_id":self.timeTableDict[@"class_id"],@"type":@(_flag),@"token":[PublicConfig valueForKey:userToken]};
    }else if(_type == 201){ // 上课前
        _url = [NSString stringWithFormat:@"%@%@", BASE_PLAN_URL, trainee_course_confirm];
        _params = @{@"class_id":self.timeTableDict[@"class_id"],@"token":[PublicConfig valueForKey:userToken]};
    }
    [self pushViewController];
}

- (void)noTimeBtClick{
//    if (self.timeTableDict[@"class_id"] == nil || self.timeTableDict[@"order_id"] == nil) {
//        [SVProgressHUD showErrorWithStatus:@"课程不存在"];
//        return;
//    }
    _flag = 2; // 我没时间
    if(_type == 200){ // 上课
        _url = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL, trainee_course_replyOrder];
        _params = @{@"order_id":self.timeTableDict[@"order_id"],@"type":@(_flag),@"token":[PublicConfig valueForKey:userToken]};
    }else if(_type == 280){ // 补课
        _url = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL, trainee_course_replyOrder];
        _params = @{@"order_id":self.timeTableDict[@"class_id"],@"type":@(_flag),@"token":[PublicConfig valueForKey:userToken]};
    }else if(_type == 201){ // 上课前
        _url = [NSString stringWithFormat:@"%@%@", BASE_PLAN_URL, trainee_course_reject];
        _params = @{@"class_id":self.timeTableDict[@"class_id"],@"token":[PublicConfig valueForKey:userToken]};
    }
    [self pushViewController];
}

- (void)pushViewController{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:_url parameters:_params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"------%@", responseObject);
        
        if ([responseObject[@"code"] intValue] == 0) { // 成功
            ResultTimeTableController *result = [[ResultTimeTableController alloc] init];
            result.flag = _flag;
            result.class_desc = _content;
            [self.navigationController pushViewController:result animated:YES];
        }else{
            DLog(@"%@",responseObject[@"msg"]);
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"操作请求失败，请稍后再试"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  KnowledgeDetailViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "KnowledgeDetailViewController.h"

@interface KnowledgeDetailViewController () {
    UILabel    *_contentLable;
}

@end

@implementation KnowledgeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _titleString;
    
    [self leftBarItem];
    
    _contentLable = [[UILabel alloc] init];
    _contentLable.numberOfLines = 0;
    _contentLable.font = [UIFont systemFontOfSize:16.0];
    _contentLable.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_contentLable];
    
    
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_knowledge_detail];
    
    NSDictionary *params = @{@"code":_codeString,@"markRead":@"true",@"token":userToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue]==NO){
            NSDictionary *dataDic = [responseDic valueForKey:@"data"];
            if (dataDic){
                CGFloat height = [PublicConfig height:dataDic[@"content"] widthOfFatherView:SCREEN_WIDTH - 20 textFont:[UIFont systemFontOfSize:16.0]];
                _contentLable.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, height);
                _contentLable.text = dataDic[@"content"];
            }
        }else{
            NSString *msgStr = [responseDic valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"获取文章详情失败"]];
        }
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              [SVProgressHUD showErrorWithStatus:@"获取文章详情请求失败"];
          }];
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

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

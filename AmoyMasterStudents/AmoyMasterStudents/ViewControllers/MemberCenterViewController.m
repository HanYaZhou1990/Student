//
//  MemberCenterViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "MemberCenterViewController.h"
#import "ChangePhoneViewController.h"
#import "ChangePwdViewController.h"
#import "TimeLineViewController.h"
#import "AFNetworking.h"
#import <AVFoundation/AVFoundation.h>
#import "PublicSaveViewController.h"
#import "MessageSave.h"
#import "UIImageView+WebCache.h"

@interface MemberCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,PublicSaveViewControllerDelegate>
{
    UITableView *myTableView;
    NSArray *sectionOneLArray;
    NSArray *sectionTwoLArray;
    
    UIImageView *headImageView;
    NSString *userNameString;
    NSString *headImageUrl;
}
@end

@implementation MemberCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[UIImage imageNamed:@"icon_main_person.png"] selectedImage:[UIImage imageNamed:@"icon_main_person.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人中心";
    
    sectionOneLArray = @[@"昵称",@"当前账号",@"联系方式",@"修改密码"];
    sectionTwoLArray = @[@"当前教练",@"我的时间线",@"当前学习进度",@"当前考试进度",@"身份证名称",@"身份证照片"];
    
    [self setTheTableView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMemberData) name:refreshMemberCenterVCNotification object:nil];
}

//设置tableview属性
- (void)setTheTableView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -220, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT+220) style:UITableViewStyleGrouped];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    [self.view addSubview:myTableView];
}

#pragma mark -
#pragma mark - 数据相关
-(void)refreshMemberData
{
    //刷新数据
}

#pragma mark -
#pragma mark - 修改头像

-(void)upLoadHeadImageView:(UIImage *)image
{
    headImageView.image = image;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    //压缩图片
    NSData *imageToSendData = UIImageJPEGRepresentation(image, 0.5);
    NSString *imgName = @"currentImage@2x.png";
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_traineeWrite_updateAvatar];
    
    NSDictionary *param = @{@"token":userToken};
    
    //上传图片请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:imageToSendData name:@"file" fileName:imgName mimeType:@"image/png"];
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         
         NSDictionary *responseDic = (NSDictionary *)responseObject;
         
         //打印结果 方便查看
         NSString *responseString = [PublicConfig dictionaryToJson:responseDic];
         DLog(@"返回结果字符串 : %@",responseString);
         
         NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
         if ([resultCode boolValue]==NO)
         {
             NSString *dataStr = [responseDic valueForKey:@"data"];
             headImageUrl =dataStr;
             [myTableView reloadData];
         }
         else
         {
             [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         [SVProgressHUD showErrorWithStatus:@"图片上传请求失败"];
     }];
}

-(void)tapMyDetailImg:(id)sender
{
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
}
#pragma -
#pragma mark UIActionSheetDelegate

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255)
    {
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            switch (buttonIndex)
            {
                case 2:
                    // 取消
                    return;
                case 0:
                {
                    if (IOS8)
                    {
                        //判断ios8的相机访问权限
                        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
                        {
                            //无权限
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法拍照" message:@"请在设备的'设置-隐私-相机'中允许淘师傅访问相机。"
                                                                           delegate:nil cancelButtonTitle:@"确定"          otherButtonTitles:nil];
                            [alert show];
                            return;
                        }
                        else if (authStatus ==AVAuthorizationStatusNotDetermined) //第一次使用，则会弹出是否打开权限
                        {
                            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
                             {
                                 if(granted)
                                 {//点击允许访问时调用
                                     //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                                     // 相机
                                     
                                 }
                                 else
                                 {
                                     //点击不允许时调用
                                     return ;
                                 }
                             }];
                        }
                    }
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                }
                    break;
                    
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else
        {
            if (buttonIndex == 1)
            {
                
                return;
            }
            else
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        imagePickerController.navigationBar.tintColor=[UIColor blackColor];
        //        [imagePickerController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
        
        [self.navigationController presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

#pragma -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"更新图片中..." animated:YES];
    [picker dismissViewControllerAnimated:YES completion:
     ^{
         UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
         image = [self fixOrientation:image];
         
         [self upLoadHeadImageView:image];
     }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

//控制拍照图片的方向
- (UIImage *)fixOrientation:(UIImage *)aImage
{
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


#pragma -
#pragma mark PublicSaveViewControllerDelegate
-(void)publicSaveMessage:(id)sender
{
    MessageSave *messageSave = (MessageSave *)sender;
    if ([messageSave.titleString isEqualToString:@"修改昵称"])
    {
        //昵称
        userNameString = messageSave.saveMessage;
    }
    [myTableView reloadData];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return sectionOneLArray.count;
    }
    else if (section==2)
    {
        return sectionTwoLArray.count;
    }
    else if (section==3)
    {
        return 1;
    }
    else if (section==4)
    {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    //    if (cell==nil)
    //    {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    //    }
    
    if (indexPath.section==0)
    {
        UIImageView *bgView = [[UIImageView alloc]init];
        bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320);
        bgView.image = [UIImage imageNamed:@"memberBg.png"];
        [cell.contentView addSubview:bgView];
        
        //头像 头像可点击编辑  名字
        headImageView =  [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 230, 60, 60)];
        if (headImageUrl.length>0)
        {
            NSString *__imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)headImageUrl, nil, nil, kCFStringEncodingUTF8));
            
            [headImageView sd_setImageWithURL:[NSURL URLWithString:__imageUrl] placeholderImage:[UIImage imageNamed:@"account_default_avatar.png"] completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL)
             {
             }];
        }
        else
        {
            headImageView.image =  [UIImage imageNamed:@"account_default_avatar.png"];
        }
        headImageView.layer.masksToBounds=YES;
        headImageView.layer.cornerRadius=30;
        headImageView.layer.borderWidth=2.0;
        headImageView.layer.borderColor=[UIColor whiteColor].CGColor;
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMyDetailImg:)];
        [headImageView addGestureRecognizer:singleTap];
        [cell.contentView addSubview:headImageView];
    }
    else
    {
        cell.textLabel.textColor = RGBA(0, 165, 109, 1);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
        
        if (indexPath.section==1)
        {
            cell.textLabel.text = [sectionOneLArray objectAtIndex:indexPath.row];
            if (indexPath.row==0)
            {
                cell.detailTextLabel.text = [PublicConfig isSpaceString:userNameString andReplace:@"韩亚周"];
            }
            else if (indexPath.row==1)
            {
                cell.detailTextLabel.text = @"hanyz";
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            else if (indexPath.row==2)
            {
                cell.detailTextLabel.text = @"15093387753";
            }
        }
        if (indexPath.section==2)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [sectionTwoLArray objectAtIndex:indexPath.row];
            if (indexPath.row==0)
            {
                cell.detailTextLabel.text = @"友谊驾校/孙璋";
            }
            else if (indexPath.row==1)
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            else if (indexPath.row==2)
            {
                cell.detailTextLabel.text = @"1.倒库(1/20)";
            }
            else if (indexPath.row==3)
            {
                cell.detailTextLabel.text = @"笔试-通过(模拟考80分)";
            }
            else if (indexPath.row==4)
            {
                cell.detailTextLabel.text = @"韩亚周";
            }
        }
        if (indexPath.section==3)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.text = @"红包金额";
            cell.detailTextLabel.text = @"50元";
        }
        if (indexPath.section==4)
        {
            cell.textLabel.text = @"退出登录";
        }
    }
    
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            //姓名
            PublicSaveViewController *psVC = [[PublicSaveViewController alloc]init];
            //传个人信息
            psVC.isSaveVerification = @"1";
            psVC.titleStr =@"修改昵称";
            psVC.textFieldStr = userNameString;
            psVC.isUsedStr = @"短文本";
            psVC.publicSaveVCdelegate = self;
            psVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:psVC animated:YES];
        }
        else if (indexPath.row==2)
        {
            //联系方式
            ChangePhoneViewController *vc = [[ChangePhoneViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==3)
        {
            //修改密码
            ChangePwdViewController *vc = [[ChangePwdViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==2)
    {
        if (indexPath.row==1)
        {
            //时间线
            TimeLineViewController *vc = [[TimeLineViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if (indexPath.section==4)
    {
        //发送登录协议
        [[NSNotificationCenter defaultCenter]postNotificationName:logoutDidSuccessNotification object:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        return 0.0001;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return 0.0001;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 320;
    }
    return 44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

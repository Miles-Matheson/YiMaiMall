//
//  LDMineInfoController.m
//  StairOrder
//
//  Created by Miles on 2017/8/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDMineInfoController.h"
#import "MyPersonalTableViewCell.h"
#import "MMAlertView.h"
#import "MMSheetView.h"
#import "DatePickerView.h"
#import "PersonalModel.h"
#import "BDImagePicker.h"
#import "LDErrorInfo.h"
#import "UIImage+Common.h"
#import "LDBaseTabBarController.h"

@interface LDMineInfoController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)PersonalModel *model;
@property (nonatomic,strong)UIImage *headImage;
@property (nonatomic,strong)UIImage *CompanyPhotoImage;

//修改后的头像地址
@property(nonatomic,copy)NSString *changePhoto;

@end

@implementation LDMineInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = WhiteColor;
    
    self.navigationItem.title = @"个人资料";

    //解决导航栏透明问题
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:navView];
    
    [self createView];
    
    [self createData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createData) name:LOGINSUCCESS object:nil];
}

-(void)createData{
//    ws(bself);
//    [[APIManager sharedManager] getPersonalMessageWithBlock:^(NSInteger result, PersonalModel *model) {
//
//        bself.model = model;
//        [bself.aTableView reloadData];
//
//    } fail:^(NSString *errorString) {
//
//    }];
}

-(void)createView{
    
    self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    
    self.aTableView.delegate = self;
    self.aTableView.dataSource = self;
    [self.view addSubview:self.aTableView];

    [self.aTableView registerClass:[MyPersonalTableViewCell class] forCellReuseIdentifier:@"MyPersonalTableViewCell"];
    [self.aTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"personal"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
        return 20;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return CGFLOAT_MIN;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       if (indexPath.row == 0) {
           MyPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPersonalTableViewCell"];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           cell.titLab.text = @"头像";
            cell.showPhoto = YES;
            if (self.headImage != nil) {
                cell.imgView.image = self.headImage;
            }else{
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.model.HeadURL] placeholderImage:[UIImage imageNamed:@"set_tx_def"]] ;
            }
           return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            }
            if (indexPath.row != 1) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = @"用户名称";
                 cell.detailTextLabel.text = @"180199617171";
            }else if (indexPath.row == 2){
                 cell.textLabel.text = @"店铺名称";
                cell.detailTextLabel.text = @"卡旺卡";
            }else{
                 cell.textLabel.text = @"我的二维码";
            }
             return cell;
        }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
         return SIZEFIT(90);
    }
    return SIZEFIT(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.model == nil) {
        [Dialog toastCenter:@"请求数据失败"];
        return;
    }
    
    if (indexPath.section == 0) {
        ws(bself);
        if (indexPath.row == 0) {//头像
            [self chooseImg];
        }
    }else {//点击保存

    }
}

//性别
-(void)chooseSex{
    
    MMPopupItemHandler block = ^(NSInteger index){
        
        if (index == 0) {

            [self.aTableView reloadData];
            
        }
  
    };
    
    NSArray *items =
    @[MMItemMake(@"男", MMItemTypeNormal, block),MMItemMake(@"女", MMItemTypeNormal, block)];
    
    MMSheetViewConfig * config = [MMSheetViewConfig globalConfig];
    
    config.defaultTextCancel = @"取消";
    
    MMSheetView * sheetView = [[MMSheetView alloc] initWithTitle:nil items:items];
    
    [sheetView showWithBlock:nil];
}

-(void)chooseImg{
    
    MMPopupItemHandler block = ^(NSInteger index){
        
        switch (index) {
            case 0://程序相机拍照
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                //照相机
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                if([[[UIDevice
                      currentDevice] systemVersion] floatValue]>=8.0) {
                    
                    self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
                }
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
                break;
            case 1://相册
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                //图库
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    };
    NSArray *items =
    @[MMItemMake(@"相机" , MMItemTypeNormal, block),MMItemMake(@"相册", MMItemTypeNormal, block)];
    MMSheetViewConfig * config = [MMSheetViewConfig globalConfig];
    config.defaultTextCancel = @"取消";
    MMSheetView * sheetView = [[MMSheetView alloc] initWithTitle:@"选择来源" items:items];
    [sheetView showWithBlock:nil];
}

#pragma mark - UIImagePickerViewController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    //防止头像旋转
    image = [image fixOrientation:image];
    //压缩图片
     NSData *imageData = UIImagePNGRepresentation(image);

    image = [UIImage imageWithData:imageData];

    __weak MyPersonalTableViewCell *cell;
 
    cell  = [self.aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

//    [ToolManager showWithMessage:@"正在加载图片..."];
    
    NSDictionary * param = @{@"token":kToken,
                             @"client":@"ios"};
 
    ws(bself);
    
//    [XBUrl uplodatImageWithpath:@"Tool/UploadImage" imgeData:imageData param:param name:@"image" CallBack:^(float Progress) {
//        [SVProgressHUD showProgress:Progress status:@"正在上传..."];
//
//    } success:^(NSURLSessionDataTask *task, id data) {
//        RC001;
//
//        if (bself.isSelectHeadCell) {
//            bself.model.Head = data[@"data"];
//            bself.headImage = [[UIImage alloc]init];
//            bself.headImage = [image copy];
//            cell.imgView.image = bself.headImage;
//        }else{
//            bself.model.CompanyPhoto = data[@"data"];
//            bself.CompanyPhotoImage = [[UIImage alloc]init];
//            bself.CompanyPhotoImage = [image copy];
//            cell.imgView.image = bself.CompanyPhotoImage;
//        }
//        bself.canSave = YES;
//        [SVProgressHUD showSuccessWithStatus:data[@"message"]];
//        [SVProgressHUD dismissWithDelay:0.3];
//
//    } fail:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
//
//        [SVProgressHUD dismiss];
//        [LDErrorInfo getErrorInfo:error];
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//提交参数
-(void)saveMessageWithUserName:(NSString *)userName withNickName:(NSString *)nickName withRealName:(NSString *)realName CompanyName:(NSString *)companyName CompanyAddress:(NSString *)companyAddress {
    

//    [ToolManager showStatusWithMessage:@"正在提交..."];

//    [[APIManager sharedManager]savePersonMessageWithInfo:userInfo Block:^(id data) {
//
//        [ToolManager dismiss];
//
//        if ([data[@"result"] integerValue] == -2) {
//            RC001;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [bself createData];
//            });
//            return;
//        }else if ([data[@"result"] integerValue] != 1){
//
//            [bself.view showCenterToast:data[@"message"]];
//            return;
//        }else{
//
//            NSString *phone = [kUserDefault objectForKey:PHONENUM];
//            [kUserDefault setBool:YES forKey:phone];
//
//            [ToolManager showStatusWithMessage:@"修改成功!"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:USERINFOCHANGE object:nil];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                [ToolManager dismiss];
//                KeyWindow.rootViewController = [[LDBaseTabBarController alloc] init];
//            });
//        }
//    } fail:^(NSString *errorString) {
//        [ToolManager dismiss];
//    }];
}

- (void)dealloc
{
    [NSNotic_Center removeObserver:self];
}
@end

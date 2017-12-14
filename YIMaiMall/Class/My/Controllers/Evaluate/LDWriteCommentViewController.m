//
//  NewOrdersCommentViewController.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/7/13.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDWriteCommentViewController.h"
#import "AddCommentCell.h"
#import "LDCommitTextViewCell.h"
#import "LDCommitImageCell.h"
#import "LDSendInfoCell.h"
#import "OrdersModel.h"
#import "MMAlertView.h"
#import "MMSheetView.h"
#import "YMUrl.h"
#import "UIImage+Common.h"

@interface LDWriteCommentViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)OrdersModel *ordersModel;

@property (nonatomic,strong)NSMutableArray *imageUrlArray;

@end

@implementation LDWriteCommentViewController


-(OrdersModel *)ordersModel{
    
    if (_ordersModel == nil) {
        
        _ordersModel = [[OrdersModel alloc] init];
    }
    return _ordersModel;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单评价";

    _imageUrlArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    
    //解决导航栏透明问题
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];

    [self createView];
    [self createData];
}

-(void)createView{
    
    self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStyleGrouped];
    self.aTableView.delegate = self;
    self.aTableView.dataSource = self;
    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.aTableView];
    
    [self.aTableView registerClass:[AddCommentCell class] forCellReuseIdentifier:@"AddCommentCell"];
    [self.aTableView registerClass:[LDSendInfoCell class] forCellReuseIdentifier:@"LDSendInfoCell"];
    [self.aTableView registerClass:[LDCommitTextViewCell class] forCellReuseIdentifier:@"LDCommitTextViewCell"];
    [self.aTableView registerClass:[LDCommitImageCell class] forCellReuseIdentifier:@"LDCommitImageCell"];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ws(bself);
    if (indexPath.section == 0) {
        
        OrdersDetailModel *model = self.ordersModel.OrderDetail[indexPath.section];
        
        AddCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCommentCell"];
        cell.startTouckClick = ^(NSInteger count) {
            
            for (OrdersDetailModel *dModel in self.ordersModel.OrderDetail) {
            
                dModel.score = count;
            }
        };
        cell.model = model;
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        LDCommitTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCommitTextViewCell"];
        
        return cell;
    }else if (indexPath.section == 2){
        LDCommitImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCommitImageCell"];
        cell.addImageCallBack = ^(BOOL isAddImage, NSInteger index) {
            
            if (isAddImage) {
                [bself chooseImg];
            }else{
                [bself.imageUrlArray removeObjectAtIndex:index];
            }
        };
        return cell;
    }else{
        LDSendInfoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LDSendInfoCell"];
        cell.sendBtnClick = ^{
            
            [bself submitAction];
        };
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 165;
    }
    return 120;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
    
}

-(void)submitAction{
    
     NSMutableArray *commodity = [[NSMutableArray alloc]init];
    
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSString *pic  = nil;
    
    for (int i = 0; i < _imageUrlArray.count; i ++) {
        
        NSString *urlPath = _imageUrlArray[i];
        
        if (urlPath.length > 0) {
            
            if (i == 0) {
                pic = urlPath;
            }else{
                 pic = [NSString stringWithFormat:@"%@,%@",pic,urlPath];
            }
        }
    }

    if (pic != nil) {
        [dic setValue:pic forKey:@"pic"];
    }

    LDCommitTextViewCell*cell = [self.aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    NSString *content = cell.textView.text;
    
    for (OrdersDetailModel *dModel in self.ordersModel.OrderDetail) {
    
        dModel.content = content;
        
        if (dModel.content.length > 200) {
            
            [Dialog toastCenter:@"评价内容过长，请小于100字"];
            return;
        }
        
        [dic setValue:[NSNumber numberWithInteger:dModel.CommodityID] forKey:@"commodityid"];
        
        [dic setValue:[NSNumber numberWithInteger:dModel.SKUID] forKey:@"skuid"];
        
        [dic setValue:@(dModel.score) forKey:@"score"];
        
        [dic setValue:dModel.content forKey:@"content"];
        
        [commodity addObject:dic];
        
    }
    
        NSDictionary *dataDic = @{@"orderid":self.ID,@"commodity":commodity};
    
        [self submitWithDic:dataDic];

    
}

-(void)submitWithDic:(NSDictionary *)dataDic{
    
    WS(weakSelf);
    
//    [ToolManager showWithMessage:@"正在提交评价..."];

    
//    [[APIManager sharedManager] sunmitCommentWithData:dataDic CallBlock:^(id data) {
//        [ToolManager dismiss];
//        RC001;
//        
//        [Dialog toastCenter:@"评价成功"];
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:ORDERCHANGE object:nil];
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:USERINFOCHANGE object:nil];
//
//        if (weakSelf.DetailRefreshBlock) {
//
//            _DetailRefreshBlock();
//        }
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//        
//    } fail:^(NSString *errorString) {
//        
//    }];
}


-(void)createData{
    
    ws(bself);
    NSDictionary *dataDic = @{@"orderid":self.ID};
    
//    [ToolManager showWithMessage:@"正在加载..."];
    
//    [[APIManager sharedManager] getNoEvaluationListWithData:dataDic CallBlock:^(id data) {
//        
//        OrdersModel *dataModel = [OrdersModel mj_objectWithKeyValues:data];
//        
//        for (OrdersDetailModel *dModel in dataModel.OrderDetail) {
//            
//            dModel.score = 5;
//            dModel.content = @"";
//        }
//        
//        bself.ordersModel = dataModel;
//        
//        [bself.aTableView reloadData];
//        
//    } fail:^(NSString *errorString) {
//        
//    }];
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
    //    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSData *imageData = UIImagePNGRepresentation(image);
    
    image = [UIImage imageWithData:imageData];
    
    __weak LDCommitImageCell *cell = [self.aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    
    [cell createImage];
    
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
//        [bself.imageUrlArray replaceObjectAtIndex:cell.uploadImgView.tag withObject:data[@"data"]];
//
//        cell.uploadImgView.image = [image copy];
//
//        [SVProgressHUD showSuccessWithStatus:data[@"message"]];
//        [SVProgressHUD dismissWithDelay:0.3];
//
//    } fail:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
//
//        [SVProgressHUD dismiss];
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end

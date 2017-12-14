//
//  EditAddressViewController.m
//  BaseFrame
//
//  Created by Zxs on 17/1/3.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "EditAddressViewController.h"
#import "RegisterCell.h"
#import "MMChoiceOneView.h"
#import "ProvinceModel.h"
#import "LDSendInfoCell.h"
#import "LDAddressListController.h"

@interface EditAddressViewController ()<UITableViewDelegate,UITableViewDataSource,MMChoiceViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,assign)NSInteger proRow;
@property (nonatomic,assign)NSInteger cityRow;
@property (nonatomic,assign)NSInteger areaRow;

@property(nonatomic,strong)UITableView * editAddressTable;
@property(nonatomic,strong)MMChoiceOneView * addressChoiceView;
@property(nonatomic,strong)NSMutableArray * provinceArray;
@property(nonatomic,strong)NSDictionary *provinceAndCityInfo;//用于保存查询到的省市县信息  仅在编辑地址时候用到


@end

@implementation EditAddressViewController


-(NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [[NSMutableArray alloc]init];
    }
    return _provinceArray;
}
-(MMChoiceOneView *)addressChoiceView
{
    if (!_addressChoiceView) {
        _addressChoiceView = [[MMChoiceOneView alloc]init];
        _addressChoiceView.delegate = self;
        _addressChoiceView.pickerView.delegate = self;
        _addressChoiceView.pickerView.dataSource = self;
    }
    return _addressChoiceView;
}
-(UITableView *)editAddressTable
{
    if (!_editAddressTable) {
        
        _editAddressTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _editAddressTable.delegate = self;
        _editAddressTable.dataSource = self;
        _editAddressTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _editAddressTable.tableFooterView = [UIView new];
        
        [_editAddressTable registerClass:[RegisterCell class] forCellReuseIdentifier:ReuseIdentifier_Normal];
        [_editAddressTable registerClass:[RegisterCell class] forCellReuseIdentifier:ReuseIdentifier_Address];
        [_editAddressTable registerClass:[RegisterCell class] forCellReuseIdentifier:ReuseIdentifier_DefaultAddress];
        [_editAddressTable registerClass:[LDSendInfoCell class] forCellReuseIdentifier:@"LDSendInfoCell"];
    }
    return _editAddressTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解决导航栏透明问题
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    if (self.addressModel) {
        self.title = @"编辑地址";
    }else{
        self.title = @"新增收货地址";
        self.addressModel = [[LDAddressListModel alloc]init];
        _addressModel.ID = nil;
    }
    
    [self.view addSubview:self.editAddressTable];
    
    [self getCityAreaRequest];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 5;
    }else{
        return 1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            return SIZEFIT(80);
        }else{
            return  SIZEFIT(55);
        }
    }else if (indexPath.section == 1 ){
        return SIZEFIT(55);
    }else{
        return SIZEFIT(77);
    }
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZEFIT(10);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {//第0区
        RegisterCell * cell;
        
        if (indexPath.row != 3) {
            cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier_Normal forIndexPath:indexPath];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier_Address forIndexPath:indexPath];
        }
        //        cell.isLOGIN = YES;
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"姓名";
                if (self.addressModel.ID!=nil) {
                    cell.contentTF.text = self.addressModel.truename;
                }else{
                    cell.contentTF.placeholder = @"收货人姓名";
                }
                break;
            case 1:
                cell.titleLabel.text = @"手机号码";
                if (self.addressModel.ID!=nil) {
                    cell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
                    cell.contentTF.text = self.addressModel.mobile;
                }else{
                    cell.contentTF.placeholder = @"请输入收货人手机号码";
                    cell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
                }
                break;
            case 2:
                cell.titleLabel.text = @"省、市";
                cell.contentTF.textAlignment = NSTextAlignmentRight;
                if (self.addressModel.ID!=nil) {
                    
                    if (_provinceAndCityInfo) {
                        
                    NSString *ProvinceName =   [LLUtils strRelay:_provinceAndCityInfo[@"ProvinceName"]];
                    NSString *CityName =   [LLUtils strRelay:_provinceAndCityInfo[@"CityName"]];
                    NSString *CountyName =   [LLUtils strRelay:_provinceAndCityInfo[@"AreaName"]];

                    cell.contentTF.text = [NSString stringWithFormat:@"%@%@%@",ProvinceName,CityName,CountyName];
                        
                    }

                }else{
                    cell.contentTF.placeholder = @"请选择";
                }
                cell.isArea = YES;
                cell.contentTF.enabled = NO;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 3:
                if (self.addressModel.ID!=nil) {
                    cell.placeLabel.hidden = YES;
                    cell.addressTV.text = self.addressModel.areaInfo;
                }else{
                    cell.contentTF.placeholder = @"请选择";
                }
                break;
            case 4:
                cell.titleLabel.text = @"邮政编码";
                if (self.addressModel.ID!=nil) {
                    cell.contentTF.text = self.addressModel.zip;
                    cell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
                }else{
                    cell.contentTF.placeholder = @"邮政编码";
                    cell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
                }
                return cell;
                
                break;
                
            default:
                break;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 1){//第1区
        
        RegisterCell  *defultCell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier_DefaultAddress forIndexPath:indexPath];
        defultCell.titleLabel.text = @"设置为默认地址";
        [defultCell.defaultSwitch setOn:self.addressModel.isDefault];
        
        return defultCell;
        
    }else{//第二区
        ws(bself);
        LDSendInfoCell *sendCell = [tableView dequeueReusableCellWithIdentifier:@"LDSendInfoCell"];
        sendCell.sendBtnClick = ^{
            [bself saveOrReSetAddress];//编辑 / 新增地址
        };
        return sendCell;
    }
    
    return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.editAddressTable deselectRowAtIndexPath:[self.editAddressTable indexPathForSelectedRow] animated:YES];
    if (indexPath.row==2 && indexPath.section == 0) {
        [self.addressChoiceView show];
    }
}
#pragma mark --- PickView代理方法UIPickerViewDelegate   UIPickerViewDataSource
-(void)MMChoiceViewChoiced:(UIPickerView*)picker{
    
    ProvinceModel * proModel = self.provinceArray[_proRow];
    
    CityModel * cityModel = proModel.childs[_cityRow];
    
    AreaModel * areaModel = cityModel.childs[_areaRow];
    
    self.addressModel.areaInfo = [NSString stringWithFormat:@"%@%@%@",[LLUtils strRelay:proModel.name] ,[LLUtils strRelay:cityModel.name],[LLUtils strRelay:areaModel.name]];

//    self.addressModel.ID = proModel.ID;
//    self.addressModel.ID = cityModel.ID;
    self.addressModel.areaId = areaModel.ID;//保存县级id

    RegisterCell * areaCell = [_editAddressTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    areaCell.contentTF.text =self.addressModel.areaInfo;
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return [MyAdapter laDapter:40];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        return self.provinceArray.count;
    }else if(self.provinceArray.count>_proRow){
        
        ProvinceModel * proModel = self.provinceArray[_proRow];
        if (component==1){
            return proModel.childs.count;
        }else{
            CityModel * cityModell = proModel.childs[_cityRow];
            return cityModell.childs.count;
        }
    }
    return 0;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    ProvinceModel * provinceModel = self.provinceArray[row];
    NSAttributedString * string;
    if (component==0) {
        string = [[NSAttributedString alloc]initWithString:provinceModel.name attributes:@{NSFontAttributeName:[MyAdapter lfontADapter:13]}];
    }else{
        ProvinceModel * proModel = self.provinceArray[_proRow];
        if(component==1){
            CityModel * cityModel = proModel.childs[row];
            
            string = [[NSAttributedString alloc]initWithString:cityModel.name attributes:@{NSFontAttributeName:[MyAdapter lfontADapter:13]}];
        }else{
            CityModel * cityModel = proModel.childs[_cityRow];
            AreaModel * areaModel = cityModel.childs[row];
            string = [[NSAttributedString alloc]initWithString:areaModel.name attributes:@{NSFontAttributeName:[MyAdapter lfontADapter:13]}];
        }
    }
    return string;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==2) {
        _areaRow = (NSInteger)row;
    }else{
        if(component==0){
            _proRow = (NSInteger)row;
            _cityRow=0;
            _areaRow=0;
            [self.addressChoiceView.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.addressChoiceView.pickerView selectRow:0 inComponent:2 animated:YES];
        }else {
            _cityRow = (NSInteger)row;
            _areaRow=0;
            [self.addressChoiceView.pickerView selectRow:0 inComponent:2 animated:YES];
        }
        [self.addressChoiceView.pickerView reloadAllComponents];
    }
}

#pragma mark --- 获取省市区
-(void)getCityAreaRequest{
    WS(bself);

    [self.view showWithMessage:@"加载中..."];
    
    [[APIManager sharedManager] getAreaDataCallBack:^(id data) {
        
        [bself.view dismiss];
        bself.provinceArray  = [ProvinceModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"childs"]];
        
        for (int i = 0; i< bself.provinceArray.count; i++) {
            
            ProvinceModel * proModel = _provinceArray[i];
            
            if (proModel.ID==bself.addressModel.ID) {
                
                bself.proRow = i;
                
                [bself.addressChoiceView.pickerView selectRow:i inComponent:0 animated:YES];
                
                for (int j=0; j<proModel.childs.count; j++) {
                    
                    CityModel * cityModel = proModel.childs[j];
                    
                    if (cityModel.ID==bself.addressModel.ID) {
                        
                        bself.cityRow=(NSInteger )j;
                        [bself.addressChoiceView.pickerView selectRow:j inComponent:1 animated:YES];
                        
                        for (int z=0; z<cityModel.childs.count; z++) {
                            
                            AreaModel * areaModel =cityModel.childs[z];
                            
                            if (areaModel.ID==bself.addressModel.ID) {
                                
                                bself.areaRow= (NSInteger)z;
                                
                                [bself.addressChoiceView.pickerView selectRow:z inComponent:2 animated:YES];
                                break ;
                            }
                        }
                    }
                }
            }
        }
        
        if (bself.addressModel.ID) {
          [bself getProvinceAndCityInfoWithAreaID:bself.addressModel.areaId];
            
        }
        
    } fail:^(NSString *errorString) {
        
    }];
}

#pragma mark --- 保存
-(void)saveOrReSetAddress{
    
    WS(bself);
    
    RegisterCell * nameCell = [_editAddressTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (nameCell.contentTF.text.length<1) {
        [Dialog toastCenter:@"收货人姓名不能为空"];
        return;
    }
    self.addressModel.truename = nameCell.contentTF.text;
    
    RegisterCell * mobileCell = [_editAddressTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (![LLUtils validateMobile:mobileCell.contentTF.text]) {
        [Dialog toastCenter:@"请填写正确的手机号码"];
        return;
    }
    self.addressModel.mobile = mobileCell.contentTF.text;
    
    
    RegisterCell * areaCell = [_editAddressTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (areaCell.contentTF.text.length<1) {
        [Dialog toastCenter:@"请选择所在区域"];
        return;
    }
    
    RegisterCell * addressCell = [_editAddressTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (addressCell.addressTV.text.length<5) {
        [Dialog toastCenter:@"请填写详细地址"];
        return;
    }
    self.addressModel.areaInfo = addressCell.addressTV.text;
    
    RegisterCell * AmECodeCell = [_editAddressTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    self.addressModel.zip = AmECodeCell.contentTF.text;
    
    RegisterCell * defaultAddressCell = [_editAddressTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    self.addressModel.isDefault = defaultAddressCell.defaultSwitch.on;
    
    NSString *addressTV =   [LLUtils strRelay:addressCell.addressTV.text];
    
    NSString *address  = [NSString stringWithFormat:@"%@",addressTV];

    
    if (self.addressModel.ID) {//这是编辑地址
        
        NSDictionary *param = @{
                                
                                @"id":self.addressModel.ID,          //收货地址编号（long）,
                                @"areaInfo":address?address:@"",//详细地址（string，长度1~255）,
                                @"mobile":self.addressModel.mobile?self.addressModel.mobile:@"",//手机号码（string，1开头10位数字）,
                                @"truename":self.addressModel.truename?self.addressModel.truename:@"",//姓名（string，长度20）,
                                @"zip":self.addressModel.zip?self.addressModel.zip:@"",//邮编（string，6位数字）,
                                @"areaId":self.addressModel.areaId?self.addressModel.areaId:@"",//areaId:地区编号（long）
                                };
        
        [[APIManager sharedManager] resetPswWithData:param CallBack:^(id data) {
            

        } fail:^(NSString *errorString) {
            
        }];
    }else{                      //新增地址
        
        NSDictionary *param = @{
                                @"areaInfo":address?address:@"",//详细地址（string，长度1~255）,
                                @"mobile":self.addressModel.mobile?self.addressModel.mobile:@"",//手机号码（string，1开头10位数字）,
                                @"truename":self.addressModel.truename?self.addressModel.truename:@"",//姓名（string，长度20）,
                                @"zip":self.addressModel.zip?self.addressModel.zip:@"",//邮编（string，6位数字）,
                                @"areaId":self.addressModel.areaId?self.addressModel.areaId:@"",//areaId:地区编号（long）
                                };
        [[APIManager sharedManager] addUserAddressWithData:param CallBack:^(id data) {
            
            [bself.view showCenterToast:data[@"msg"]];
            
            if ([data[@"state"] boolValue]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:RELOADADDRESS object:nil];
                [bself.navigationController popViewControllerAnimated:YES];
            }
        } fail:^(NSString *errorString) {
            
        }];
    }
}

-(NSDictionary *)getProvinceAndCityInfoWithAreaID:(NSString *)areaid{
    
    _provinceAndCityInfo = [[NSDictionary alloc]init];
    
    for (ProvinceModel * model  in _provinceArray) {
        
        for (CityModel *cityModel in model.childs) {
            
            for (AreaModel *areaModel in cityModel.childs) {
                
                if ([areaid isEqualToString:areaModel.ID]) {

                    _provinceAndCityInfo = @{
                                              @"ProvinceID":model.ID,
                                              @"ProvinceName":model.name,
                                              @"CityID":cityModel.ID,
                                              @"CityName":cityModel.name,
                                              @"AreaID":areaModel.ID,
                                              @"AreaName":areaModel.name,
                                              };
                    break;
                }
            }
        }
    }
    [self.editAddressTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    return _provinceAndCityInfo;
}

@end

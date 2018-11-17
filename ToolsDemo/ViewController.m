//
//  ViewController.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/11.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "ViewController.h"
#import "ZLMaskView.h"
#import "ZlDatabaseManager.h"
#import "Student.h"
#import "CommonMaskView.h"
#import "ShareViewController.h"
#import "MemberManagementViewController.h"
#import "CustomViewController.h"
#import <AipOcrSdk/AipOcrSdk.h>
#import <objc/runtime.h>
#import <UShareUI/UShareUI.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "PNChart.h"
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static NSString *TABLENAME = @"Student";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *mytableView;

@property(nonatomic,strong)NSMutableArray *datasource;

@end

@implementation ViewController
{
    NSInteger count;
    NSIndexPath *indexpath;

    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
    
}

-(UITableView *)mytableView{
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mytableView.backgroundColor = [UIColor whiteColor];
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
    }
    return _mytableView;
}

-(NSMutableArray *)datasource{
    
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  ///  ZLMaskView *maskView = [[ZLMaskView alloc]initWithFrame:self.view.bounds];
   // maskView.limitHeight = 50.0f;
    //maskView.contentView_y = 500;
  //  [self.view addSubview:maskView];
    
//    Student *student = [[Student alloc]init];
////       [[ZlDatabaseManager shareManager] createTableWithModel:student withFileName:@"Student" withPrimaryKey:@"name"];
//    [[ZlDatabaseManager shareManager] selectDataWithModel:student withFileName:@"Student" withLimit:1];
     [[AipOcrService shardService] authWithAK:@"Wzlr8b9uWLXSOoQfR7xP7COR" andSK:@"gTo50d0F0Vv3yjnLwbipD0LRvY59aUHA"];
    
    [self initUI];
    [self.view addSubview:self.mytableView];

    [self getDataSource];
//
    [self configCallback];
    
//    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
//    lineChart.showYGridLines = YES;
//    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
//
//    // Line Chart No.1
//    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
//    PNLineChartData *data01 = [PNLineChartData new];
//    data01.color = PNFreshGreen;
//    data01.itemCount = lineChart.xLabels.count;
//    data01.getData = ^(NSUInteger index) {
//        CGFloat yValue = [data01Array[index] floatValue];
//        return [PNLineChartDataItem dataItemWithY:yValue];
//    };
//    // Line Chart No.2
//    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
//    PNLineChartData *data02 = [PNLineChartData new];
//    data02.color = PNTwitterColor;
//    data02.itemCount = lineChart.xLabels.count;
//    data02.getData = ^(NSUInteger index) {
//        CGFloat yValue = [data02Array[index] floatValue];
//        return [PNLineChartDataItem dataItemWithY:yValue];
//    };
//
//    lineChart.chartData = @[data01, data02];
//    [lineChart strokeChart];
//
//    [self.view addSubview:lineChart];
    
    
}

- (void)configCallback {
    __weak typeof(self) weakSelf = self;
    
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        NSLog(@"%@", result);
        NSString *title = @"识别结果";
        NSMutableString *message = [NSMutableString string];
        
        if(result[@"words_result"]){
            if([result[@"words_result"] isKindOfClass:[NSDictionary class]]){
                [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
                    }else{
                        [message appendFormat:@"%@: %@\n", key, obj];
                    }
                    
                }];
            }else if([result[@"words_result"] isKindOfClass:[NSArray class]]){
                for(NSDictionary *obj in result[@"words_result"]){
                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@\n", obj[@"words"]];
                    }else{
                        [message appendFormat:@"%@\n", obj];
                    }
                    
                }
            }
            
        }else{
            [message appendFormat:@"%@", result];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
    };
    
    _failHandler = ^(NSError *error){
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
    };
}

-(void)initUI{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addData)];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"-" style:UIBarButtonItemStylePlain target:self action:@selector(deleteData)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


-(void)getDataSource{
    
     Student *student = [[Student alloc]init];
      self.datasource =   [[ZlDatabaseManager shareManager] selectDataWithModel:student withFileName:TABLENAME withLimit:0];
    
    if (self.datasource.count > 0) {
        
        [self.mytableView reloadData];
    }
}

-(void)addData{
     Student *student = [[Student alloc]init];
        student.name = [NSString stringWithFormat:@"%ld",count];
        student.age = @"12";
        UIImage *image = [UIImage imageNamed:@"X3"];
        student.gradute = [[ZlDatabaseManager shareManager] imageToString:image];
    student.friends = [[NSMutableArray alloc]initWithObjects:@"1", @"2",nil];
        student.sex = @"zll";
    student.pats = @{@"zl":@[@"1",@"2"],@"14":@"!%",@"rt":@"0-"};
        count ++;
     BOOL reult =  [[ZlDatabaseManager shareManager] insertDataWithModel:student withFileName:TABLENAME];
    
    if (reult) {
        
        [self getDataSource];
    }
}


-(void)deleteData{
    
   BOOL reult =  [[ZlDatabaseManager shareManager] dropFileName:TABLENAME];
    
    if (reult) {
        
        [self getDataSource];
        [self.mytableView reloadData];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Student *student  = self.datasource[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-----%@",student.name,student.sex];
    
    cell.detailTextLabel.text = student.sex;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    Student *model = self.datasource[indexPath.row];
//
//    model.sex = @"King";
//
//   BOOL result = [[ZlDatabaseManager shareManager]updateDataWithModel:model withFileName:TABLENAME withpriamrykey:model.name];
//
//    if (result) {
//
//        [self.mytableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//    }
    
//    CommonMaskView *maskView = [[CommonMaskView alloc]initWithFrame:self.view.bounds];
//
//    [maskView show];
    
//    CustomViewController *tempVC = [[CustomViewController alloc]init];
//    [self.navigationController pushViewController:tempVC animated:YES];
    
    [self bankCardOCROnline];
}

- (void)bankCardOCROnline{
    
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont
                                 andImageHandler:^(UIImage *image) {
                                     
                                     [[AipOcrService shardService] detectIdCardFrontFromImage:image
                                                                                  withOptions:nil
                                                                               successHandler:_successHandler
                                                                                  failHandler:_failHandler];
                                 }];
    
    [self presentViewController:vc animated:YES completion:nil];
    
//    UIViewController * vc =
//    [AipCaptureCardVC ViewControllerWithCardType:CardTypeBankCard
//                                 andImageHandler:^(UIImage *image) {
//
//                                     [[AipOcrService shardService] detectBankCardFromImage:image
//                                                                            successHandler:_successHandler
//                                                                               failHandler:_failHandler];
//
//                                 }];
//    [self presentViewController:vc animated:YES completion:nil];
    
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    //设置文本
//    messageObject.text = @"1111111";
//
//    //调用分享接口
//
//        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//
//            if (error) {
//                UMSocialLogInfo(@"************Share fail with error %@*********",error);
//                NSLog(@"%@",error);
//            }else{
//                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                    UMSocialShareResponse *resp = data;
//                    //分享结果消息
//                    UMSocialLogInfo(@"response message is %@",resp.message);
//                    //第三方原始返回的数据
//                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//
//                }else{
//                    UMSocialLogInfo(@"response data is %@",data);
//                }
//            }
//
//        }];
    
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Student *model = self.datasource[indexPath.row];
        [[ZlDatabaseManager shareManager]deleteDataWithModel:model.name withFileName:TABLENAME];
        [self.datasource removeObjectAtIndex:indexPath.row];
        [self.mytableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


//- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    // delete action
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//        [tableView setEditing:NO animated:YES];
//
//    }];
//
//
//    return @[deleteAction];
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

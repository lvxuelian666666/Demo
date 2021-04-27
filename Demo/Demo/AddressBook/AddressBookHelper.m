//
//  AddressBookHelper.m
//  MeiTanJiangHu
//
//  Created by Shelly on 2019/6/4.
//  Copyright © 2019年 mtjh. All rights reserved.
//

#import "AddressBookHelper.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

static AddressBookHelper *_addressBook;
@implementation AddressBookHelper

+(AddressBookHelper *)share
{
    if (!_addressBook) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _addressBook = [[AddressBookHelper alloc]init];
        });
    }
    return _addressBook;
}

//+(BOOL)addContactName:(NSString *)name phoneNum:(NSString *)num withLabel:(NSString *)label
//{
//
//}

-(BOOL)addContactName:(NSString *)name phoneNum:(NSString *)num withLabel:(NSString *)label
{
     CNContactStore *store = [[CNContactStore alloc] init];
    //判断通讯录是否授权
    CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (authStatus) {
        case CNAuthorizationStatusAuthorized:
            
            break;
        case CNAuthorizationStatusDenied:
            
            break;
        case CNAuthorizationStatusNotDetermined:
        {
            __weak typeof(self) weakSelf = self;
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    NSLog(@"授权成功");
                }else{
                    NSLog(@"授权失败");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf gotoSetting];
                    });
                }
            }];
        }
            break;
        default:
            break;
    }
    
    
    
   

    
    
    //创建一条空的联系人
    CNMutableContact *contact = [[CNMutableContact alloc]init];
    contact.nickname = name;
    contact.phoneNumbers = @[@"13624284360"];
    //设置名字
    contact.givenName = name;
    //设置姓氏
    contact.familyName = name;
    
    
    //创建添加联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc]init];
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    
    //进行联系人写入操作
    
    [store executeSaveRequest:saveRequest error:nil];
    
    
    //检索联系人  检索这个名字的
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:name];
    //提取数据
    NSArray *contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey,CNContactNamePrefixKey] error:nil];
    
    
    return YES;
}

#pragma mark -- 引导到设置页面去设置
-(void)gotoSetting
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您还没有设置通讯录权限" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *doneAlert = [UIAlertAction actionWithTitle:@"设置通讯录权限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alertController addAction:doneAlert];

}

-(void)addContactName:(NSString *)name phoneNum:(NSString *)num
{
    //检索用户是否存在
    CNContactStore *store = [[CNContactStore alloc] init];
    //检索条件
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:name];
    //提取数据
    NSArray *contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactNamePrefixKey,CNContactGivenNameKey] error:nil];
    if (contacts.count > 0) {
        
    }
}

-(void)addAlertTitle:(NSString *)title 
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"手机通通讯录 内已存在该用户，是否继续添加?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *doneAlertAction = [UIAlertAction actionWithTitle:@"添加到现有联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:doneAlertAction];
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAlertAction];
    
    
    
}


@end

//
//  DiaryEditor.m
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "DiaryEditor.h"
#import "HJAddNoteAPI.h"
#import "ZLCameraViewController.h"
#import "HJIcoCell.h"

static const NSUInteger kPhotoMaxCount = 3;

@interface DiaryEditor ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextViewDelegate>
{
    UILabel *label;

}
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic)   ZLCameraViewController *cameraVc;
@property (nonatomic , strong) NSMutableArray *photoAssets;
@property (nonatomic, strong) NSMutableArray *ImagDatas;
@property (nonatomic, strong) UIImage *photoIconImage;

@end
@implementation DiaryEditor

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑";
    
    self.ImagDatas = [NSMutableArray array];

    label = [UILabel lh_labelWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-10, 20) text:@"在这里写下你的减肥日记吧~" textColor:kGrayColor font:FontNormalSize textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor clearColor]];
    label.enabled=NO;
    [self.text addSubview:label];
    self.text.delegate = self;
    
    self.sendBtn.layer.cornerRadius = 5;
    
    [self.sendBtn addTarget:self action:@selector(addNoteAct) forControlEvents:UIControlEventTouchUpInside];
    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 240, kScreenWidth, 70) collectionViewLayout:flowout];
    self.collectionView.backgroundColor = kWhiteColor;
    [self.topView addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HJIcoCell" bundle:nil] forCellWithReuseIdentifier:@"HJIcoCell"];
}
- (void)addNoteAct {
    
    for (NSInteger i=0;i<self.photoAssets.count-1;i++) {
        
        id asset = self.photoAssets[i];
        UIImage *img = [[UIImage alloc] init];
        if ([asset isKindOfClass:[ALAsset class]]) {
            CGImageRef imgRef = [asset thumbnail];
            img = [UIImage imageWithCGImage:imgRef];
            
        } else if([asset isKindOfClass:[NSDictionary class]]){
            NSArray *key = [asset allKeys];
            img = [asset objectForKey:key[0]];
        }
        NSData *imgData = UIImageJPEGRepresentation(img, 0.6);
        [self.ImagDatas addObject:imgData];
       // NSLog(@"imgData- %@",self.ImagDatas);
    }
    
    if (self.text.text.length == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入内容"];
    }else {
        
        [[[HJAddNoteAPI addNoteWithcontent:self.text.text image:self.ImagDatas] netWorkClient]uploadFileInView:self.view successBlock:^(id responseObject) {
            
            HJAddNoteAPI *api = responseObject;
            if (api.code == 1) {
                [self.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            }
        }];
    
    }
//    if (self.photoAssets.count <2) {
//        
//        [SVProgressHUD showInfoWithStatus:@"请选择照片"];
//        
//    }
}
#pragma mark - Methods

- (void)selectPhotos {
    
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    cameraVc.maxCount = kPhotoMaxCount - self.photoAssets.count + 1;
    __weak typeof(self) weakSelf = self;
    
    [cameraVc startCameraOrPhotoFileWithViewController:self complate:^(id object) {
        
        //如果是本地图片多选
        if ([object isKindOfClass:[NSArray class]]) {
            
            [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    NSMutableArray *photoAssets = [[obj allValues]mutableCopy];
                    [photoAssets addObject:self.photoIconImage];
                   // weakSelf.photoAssets = photoAssets;
                  [weakSelf.photoAssets insertObject:obj atIndex:0];
                  
                    
                }else{
                    //改动
                    [weakSelf.photoAssets insertObject:obj atIndex:0];
                }
                
                
                if (weakSelf.photoAssets.count > 6) {
                    
                    [self.photoAssets removeLastObject];
                }
                
                [weakSelf.collectionView reloadData];
            }];
        }
    }];
    self.cameraVc = cameraVc;
}
#pragma mark---------collectionViewDelegate----------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.photoAssets.count>3) {
        
        return 3;
    }
    return self.photoAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJIcoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HJIcoCell" forIndexPath:indexPath];
    //*******
    id asset = [self.photoAssets objectAtIndex:indexPath.row];

    if ([asset isKindOfClass:[ALAsset class]]) {
        
        [cell.ico setImage:[UIImage imageWithCGImage:[asset thumbnail]]];
        
    }else if([asset isKindOfClass:[NSDictionary class]]){
        NSArray *key = [asset allKeys];
        UIImage *imag = [asset objectForKey:key[0]];
        [cell.ico setImage:imag];
        
    }else if([asset isKindOfClass:[UIImage class]]){
        
        [cell.ico setImage:asset];
    }
    //拍照图标不显示删除按钮
    if (indexPath.row == self.photoAssets.count-1) {
        
        cell.deleteBtn.hidden = YES;
    }else {
        
        cell.deleteBtn.hidden = NO;
    }
    
    //没有拍照图标全部可以删除
    if (self.photoAssets.count == kPhotoMaxCount && ![self.photoAssets containsObject:self.photoIconImage]) {
        
        cell.deleteBtn.hidden = NO;
    }
    
    WEAK_SELF();
    [cell.deleteBtn lh_setTapActionWithBlock:^{
        
        [weakSelf.photoAssets removeObjectAtIndex:indexPath.row];
        
        if (![weakSelf.photoAssets containsObject:self.photoIconImage]) {
            
            [weakSelf.photoAssets addObject:self.photoIconImage];
        }
        
        [weakSelf.collectionView reloadData];
    }];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(65, 65);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.photoAssets.count-1) {
        [self.view endEditing:YES];
        [self selectPhotos];
    }
}
#pragma mark--------------textViewDelegate----------------------
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [label setHidden:YES];
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        [label setHidden:NO];
    }else{
        [label setHidden:YES];
    }
}
#pragma  mark - Setter&Getter

- (NSMutableArray *)photoAssets {
    
    if (!_photoAssets) {
        
        _photoAssets = [NSMutableArray array];
        [_photoAssets addObject:self.photoIconImage];
    }
    
    return _photoAssets;
}

- (UIImage *)photoIconImage {
    
    if (!_photoIconImage) {
        
        _photoIconImage = kImageNamed(@"ic_a56_1");
    }
    
    return _photoIconImage;
}

@end

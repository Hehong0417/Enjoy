//
//  HJGroupTableVC.m
//  Bsh
//
//  Created by zhipeng-mac on 15/12/17.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "HJStaticGroupTableVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

static const CGFloat kNormalTableSectionHeaderViewHeight = 30;
static const CGFloat kNormalGroupSpacing = 10;
static const CGFloat kNormalCellHeight = 44;

@interface HJStaticGroupTableVC () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation HJStaticGroupTableVC

#pragma mark - Life cycle

- (NSMutableArray *)MessageViewArray
{
    if (!_MessageViewArray) {
        _MessageViewArray = [NSMutableArray array];
    }
    return _MessageViewArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //视图加载完毕实现相应协议方法
    [self doSomeThingInViewDidLoad];
    //tableView头部设置
    self.tableView.tableHeaderView = self.tableHeaderView;
    //tableView数据源设置
    [self setGroups];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods

- (void)setGroups{
    
    __block NSMutableArray *groups = [NSMutableArray array];
    
    [self.groupTitles enumerateObjectsUsingBlock:^(NSArray *itemTitles, NSUInteger idx, BOOL *stop) {
        
        // 创建组模型
        HJGroupItem *group = [[HJGroupItem alloc]init];
        // 创建行模型
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *itemIcons = [self.groupIcons objectAtIndex:idx];
        NSArray *itemDetails = [self.groupDetials objectAtIndex:idx];
        [itemTitles enumerateObjectsUsingBlock:^(NSString *itemTitle, NSUInteger idx, BOOL *stop) {
            
            HJSettingItem *settingItem = [HJSettingItem itemWithtitle:itemTitle image:itemIcons[idx]];
            settingItem.detailTitle = itemDetails[idx];
            [items addObject:settingItem];
        }];
        
        group.items = items;
        
        [groups addObject:group];
        
    }];
    
    self.groups = [groups mutableCopy];
}

- (HJSettingItem *)settingItemInIndexPath:(NSIndexPath *)indexPath {
    
    HJGroupItem *groupItem = [self.groups objectAtIndex:indexPath.section];
    
    return  [groupItem.items objectAtIndex:indexPath.row];
}

- (NSArray *)allSettingItems {
    
    NSMutableArray *allSetttingItems = [NSMutableArray array];
    
    [self.groups enumerateObjectsUsingBlock:^(HJGroupItem *groupItem, NSUInteger idx, BOOL *stop) {
        
        [groupItem.items enumerateObjectsUsingBlock:^(HJSettingItem *settingItem, NSUInteger idx, BOOL *stop) {
            
            [allSetttingItems addObject:settingItem];
        }];
        
    }];
    
    return allSetttingItems;
}

- (void)allSettingItemReloadDetailTiltleWithDataSource:(NSArray *)dataSource {
    
    NSArray *allSettingItems = [self allSettingItems];
    
    [allSettingItems enumerateObjectsUsingBlock:^(HJSettingItem *settingItem, NSUInteger idx, BOOL *stop) {
        
        if (idx < 4) {
            
            settingItem.detailTitle = dataSource[idx];
        }
    }];
    
    [self.tableView reloadData];
}

- (void)updateIco:(UIImage *)image {
    
    self.cellHeadImageView.image = image;
    // 图片压缩
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    
}

- (void)ValueChange:(UISwitch *)swi {
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    HJGroupItem *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /**
     静态cell不去重用队列获取
     */
      UITableViewCell  *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.selectionStyle = self.cellSelectionStyle;
    // Configure the cell...
    HJGroupItem *group = self.groups[indexPath.section];
    HJSettingItem *item = group.items[indexPath.row];
    
    cell.textLabel.textColor = self.titleLabelFontAttributes.fontColor;
    cell.textLabel.font = self.titleLabelFontAttributes.font;
    cell.textLabel.text = item.title;
    //
    if (item.image.length>0) {
        cell.imageView.image = [UIImage imageNamed:item.image];
    }
    //
    cell.detailTextLabel.text = item.detailTitle;
    cell.detailTextLabel.font = FontNormalSize;
    
    if (self.isSettingIndicator) {
        
        // detailTitle无值时设置Cell右边的小箭头
        if (item.detailTitle.length > 0) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        //detailTitle有值时可以设置箭头此时仍然存在
        if (self.indicatorIndexPaths) {
            
            [self.indicatorIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indicatorIndexPath, NSUInteger idx, BOOL *stop) {
                
                if ([indicatorIndexPath isEqual:indexPath]) {
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }];
        }
    }
    
    //右边按钮是UISwitch类型
    if (self.rightViewSwitchIndexPaths) {
        
        [self.rightViewSwitchIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indicatorIndexPath, NSUInteger idx, BOOL *stop) {
            
            if ([indicatorIndexPath isEqual:indexPath]) {
                UISwitch *swi = [UISwitch new];
                [swi addTarget:self action:@selector(ValueChange:) forControlEvents:UIControlEventValueChanged];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                swi.on = [defaults boolForKey:@"messageSwitch"];
                cell.accessoryView = swi;
            }
        }];
    }
    
    // 右边红色小点
    if (self.rightViewNewMessageIndexPaths) {
        [self.rightViewNewMessageIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indicatorIndexPath, NSUInteger idx, BOOL *stop) {
            if ([indicatorIndexPath isEqual:indexPath]) {
                CGFloat imageViewSize = 7;
                UIImageView *newMessageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - imageViewSize - 35, (44-imageViewSize)/2.0, imageViewSize, imageViewSize)];
                //                        [newMessageView setBackgroundColor:[UIColor orangeColor]];
                [self.MessageViewArray addObject:newMessageView];;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell.contentView addSubview:newMessageView];
            }
        }];
    }
    
    //头像cell
    if ([indexPath isEqual:self.headImageCellIndexPath]) {
        
        CGFloat imageViewSize = 47;
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - imageViewSize - 10, (64-imageViewSize)/2.0, imageViewSize, imageViewSize)];
//        [headImageView setBackgroundColor:[UIColor orangeColor]];
        [headImageView lh_setRoundImageViewWithBorderWidth:0 borderColor:kClearColor];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(item.detailTitle)] placeholderImage:nil];
        cell.detailTextLabel.text = @" ";//头像类型时detailTitle设置
        self.cellHeadImageView = headImageView;
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.contentView addSubview:headImageView];
    }
    
    //全部cell有箭头
    if (self.isAllCellIndicator) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma  mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (!self.tableSectionHeaderViewTitle) {
        
        if (section == 0 && self.firstGroupSpacing > 0) {
            
            
            return self.firstGroupSpacing;
        }
        
        return kNormalGroupSpacing;
    }else {
        
       NSString *tableSectionTitle = [self.tableSectionHeaderViewTitle objectAtIndex:section];
        
        if (tableSectionTitle.length >0) {
            
            return kNormalTableSectionHeaderViewHeight;
        }else {
            
            if (self.firstGroupSpacing>0 && section ==0) {
                
                return self.firstGroupSpacing;
            }
            
            return kNormalGroupSpacing;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kNormalCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([indexPath isEqual:self.headImageCellIndexPath]) {
        [self cameraClick];
    }
}

- (void)cameraClick {
  
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", @"拍照", nil];
    [actionSheet bk_setWillDismissBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            // 相册
            [self getMediaFromSource:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }else if (buttonIndex == 1) {
            // 拍照
            [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
        }
        
    }];
    [actionSheet showInView:self.view];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    // Prevent the cell from inheriting the Table View's margin settings
    if (iOS8) {
        [cell setPreservesSuperviewLayoutMargins:NO];
        // Explictly set your cell's layout margins
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - 拍照 & 相册

- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        //
        ipc.sourceType = sourceType;
        ipc.allowsEditing = YES;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    }else {
        [UIAlertView lh_showWithMessage:@"当前设备不支持拍摄功能"];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = info[UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]) {
            //获取用户编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            [self updateIco:image];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
    picker = nil;
}

#pragma mark - Setter&Getter

- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
        
    }
    return _groups;
}

- (NSArray *)groupIcons {
    
    return nil;
}

- (NSArray *)groupTitles {
    
    return nil;
}

- (NSArray *)groupDetials {
    
    return nil;
}
- (void)getdatas
{
   
}
- (NSArray *)indicatorIndexPaths {
    
    return nil;
}

- (NSArray *)rightViewSwitchIndexPaths {
    
    return nil;
}

- (NSArray *)rightViewNewMessageIndexPaths
{
    return nil;
}

- (BOOL)isSettingIndicator {
    
    return YES;
}

- (FontAttributes *)titleLabelFontAttributes {
    
    return [FontAttributes fontAttributesWithFontColor:[UIColor blackColor] fontsize:14.0];
}

- (CGFloat)firstGroupSpacing {
    
    return 0;
}

- (NSIndexPath *)headImageCellIndexPath {
    
    return nil;
}

- (UITableViewCellSelectionStyle)cellSelectionStyle {
    
    return UITableViewCellSelectionStyleNone;
}

- (NSArray *)tableSectionHeaderViewTitle {
    
    return nil;
}

- (UIView *)tableHeaderView {
    
    return nil;
}

@end

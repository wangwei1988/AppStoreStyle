//
//  MyCell.m
//  AppStoreStyle
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyCell.h"
#import "UIView+Extension.h"
@implementation MyCell
#define MColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth   ScreenBounds.size.width
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = MColor(255, 277, 220);
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        [self initSubItem];
    }
    return self;
}


-(void)initSubItem {
    self.leftview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 62, 62)];
    self.leftview.image = [UIImage imageNamed:@"IMG_0162"];
    [self.contentView addSubview:self.leftview];
    
    self.showLb = [[UILabel alloc]initWithFrame:CGRectMake(62, 10, ScreenWidth - 40 - 62 -32, 62)];
    self.showLb.font = [UIFont systemFontOfSize:38];
    self.showLb.textColor = [UIColor blackColor];
    self.showLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.showLb];
    
    self.rightview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 40 - 32  , (88 - 32) / 2, 32, 32)];
    self.rightview.image = [UIImage imageNamed:@"IMG_0087"];
    [self.contentView addSubview:self.rightview];
}

@end

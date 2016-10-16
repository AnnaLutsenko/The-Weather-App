//
//  DayCellTableViewCell.h
//  Weather
//
//  Created by Anna on 15.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* dayLabel;
@property (weak, nonatomic) IBOutlet UILabel* dayTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel* nightTimeLbl;

@end

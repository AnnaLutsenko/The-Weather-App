//
//  TemperatureCollectionViewCell.h
//  Weather
//
//  Created by Anna on 18.07.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemperatureCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *tempLbl;

@end

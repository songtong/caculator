//
//  ViewController.h
//  caculator
//
//  Created by Song on 14-3-1.
//  Copyright (c) 2014年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSString *content;
    NSMutableArray *originArray;
    long number;
    int count;
    BOOL isOpAlready;
    long result;
    NSMutableArray *nums;
    NSMutableArray *ops;

}

@end


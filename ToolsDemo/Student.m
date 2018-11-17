//
//  Student.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/15.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "Student.h"

@implementation Student



-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@ %@ %@ %@",self.name,self.age,self.sex,self.gradute];
}

@end

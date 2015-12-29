//
//  ListModel.swift
//  Music
//
//  Created by 谷建兴 on 15/12/15.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class ListModel: NSObject {
    
    var abbr_en = String()
    var name = String()
    var name_en = String()
    var channel_id = NSInteger() //数据类型必须对应
    var seq_id = NSInteger()
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    
}

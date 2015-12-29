//
//  Record.swift
//  Music
//
//  Created by 谷建兴 on 15/12/8.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class Record: UIImageView {
    //1.多个控件可以关联设置同一个类
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //设置圆角
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
        
        //边框
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7).CGColor
        
        
    }
    
    
    func transformTo() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0.0
        animation.toValue = M_PI*2.0
        animation.duration = 20
        animation.repeatCount = 10000
        self.layer.addAnimation(animation, forKey: nil)
    }
    
    
    

}

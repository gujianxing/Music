//
//  HTTPRequest.swift
//  Music
//
//  Created by 谷建兴 on 15/12/8.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class HTTPRequest: NSObject {
    //定义一个代理
    var delegate:httpProtocol?
    //设置代理方法  接收网址 传回数据
    func onSearch(url:String) {
        
//        self.delegate?.didRecieveResults(<#T##results: AnyObject##AnyObject#>)
    }
    
    
    
}


//定义http协议
protocol httpProtocol {
    func didRecieveResults(results:AnyObject)
}
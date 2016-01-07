//
//  ListVC.swift
//  Music
//
//  Created by 谷建兴 on 15/12/8.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

protocol listDelegate {
    func passThechannel_id(ID:NSInteger,or:Bool)
}

class ListVC: UIViewController {
    
    /*
    2.不用代码设置代理
    点击tableview然后点击control拉线到当前控制器 可以设置dataSource和delegate
    不需要代码遵循协议 设置代理 只需要实现方法就行,不过此时的代理方法不能自动补全
    3.数据请求
    do {
       = try
    } catch {
    
    }
    */
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var delegate:listDelegate?
    
    lazy var dataSource:NSMutableArray = {
        var sources = NSMutableArray(capacity: 0)
        return sources
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.alpha = 0.8
        self.requestData()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if self.dataSource.count > indexPath.row {
            let model:ListModel = self.dataSource[indexPath.row] as! ListModel
            cell?.textLabel?.text = model.name
        }
        return cell!
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model:ListModel = self.dataSource[indexPath.row] as! ListModel
        self.delegate?.passThechannel_id(model.channel_id,or: true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //频道数据 http://www.douban.com/j/app/radio/channels
    func requestData() {
        let url:NSURL = NSURL(string: "http://www.douban.com/j/app/radio/channels")!
        let request = NSMutableURLRequest(URL: url)
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response, data, error) -> Void in
            do {
                let dics:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
//                print(dics)
                let arr:NSArray = dics["channels"] as! NSArray
                for dic in arr {
                    let model = ListModel()
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    self.dataSource.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.mainTableView.reloadData()
                })
            }catch {
                
            }
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

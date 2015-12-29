//
//  ViewController.swift
//  Music
//
//  Created by 谷建兴 on 15/12/7.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit
let WIDTH = UIScreen.mainScreen().bounds.size.width
let HEIGHT = UIScreen.mainScreen().bounds.size.height
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,listDelegate {
    
    @IBOutlet weak var record: Record!
    @IBOutlet weak var backgorund: UIImageView!
    @IBOutlet weak var mainTableView: UITableView!
    
    lazy var dataSource:NSMutableArray = {
        var sources = NSMutableArray()
        return sources
    }()
    var channel_id = NSInteger()
    var or = Bool() //是否选择电台
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.or = false
        self.channel_id = 0
        

        
        //设置模糊效果
        let blureffect = UIBlurEffect(style: .Light)
        let blurView = UIVisualEffectView(effect: blureffect)
        blurView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        self.backgorund.addSubview(blurView)
        
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        
    
    }
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DetailCell = tableView.dequeueReusableCellWithIdentifier("cell") as! DetailCell
        if self.dataSource.count > indexPath.row {
            let model:DtailModel = self.dataSource[indexPath.row] as! DtailModel
            cell.setValuesWithModel(model)
        }
         return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //设置图片
        self.setPicture(indexPath.row)
    }
    
    func setPicture(row:Int) {
        let model:DtailModel = self.dataSource[row] as! DtailModel
        let url = NSURL(string: model.picture)
        self.backgorund.kf_setImageWithURL(url!, placeholderImage: nil)
        self.record.kf_setImageWithURL(url!, placeholderImage: nil)
        //旋转
        self.record.transformTo()
    }
    
    //频道为0的歌曲数据 http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite
    func requestData() {
        self.dataSource.removeAllObjects()
        
        
        //需要设置代理  NSURLConnectionDelegate
        let str = "http://douban.fm/j/mine/playlist?type=n&channel=\(self.channel_id)&from=mainsite";
        let url = NSURL(string: str)
        let request = NSMutableURLRequest(URL: url!)
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (respersone, data, error) -> Void in
            do {
                let dics:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let arr:NSArray = dics["song"] as! NSArray
                for dic in arr {
                    let model = DtailModel()
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    self.dataSource.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.mainTableView.reloadData()
                    self.setPicture(0)
                    
                })
            } catch {
                
            }
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.or == true {
            self.requestData()
        }
    }
    
    func passThechannel_id(ID: NSInteger,or: Bool) {
        self.channel_id = ID
        self.or = or
    }
    
    //4.设置代理，storyboard界面传值 delegate必须在此方法中设置
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let list:ListVC = segue.destinationViewController as! ListVC
        list.delegate = self
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


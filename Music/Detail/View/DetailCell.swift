//
//  DetailCell.swift
//  Music
//
//  Created by 谷建兴 on 15/12/15.
//  Copyright © 2015年 gujianxing. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var personName: UILabel!
    
    
    
    func setValuesWithModel(model:DtailModel) {
        self.songName.text = model.artist
        self.personName.text = model.albumtitle
        self.picture.kf_setImageWithURL(NSURL(string: model.picture)!, placeholderImage: nil)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

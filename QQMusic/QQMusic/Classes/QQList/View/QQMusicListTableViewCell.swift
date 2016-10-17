//
//  QQMusicListTableViewCell.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/8.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQMusicListTableViewCell: UITableViewCell {
    
    var musicM : QQMusicModel? {
        didSet {
            singerIconImageView.image = UIImage(named: (musicM?.singerIcon)!)
            songNameLabel.text = musicM?.name
            
            singerNameLabel.text = musicM?.singer
        }
    }
    @IBOutlet weak var singerIconImageView: UIImageView!

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    
    class func cellWithTableView(tableView : UITableView) ->QQMusicListTableViewCell {
        let cellID = "QQMusicList"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? QQMusicListTableViewCell
        if cell == nil {
            //print("貌似有问题")
            cell = Bundle.main.loadNibNamed("QQMusicListTableViewCell", owner: nil, options: nil)?.first as?QQMusicListTableViewCell
        }
        return cell!
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib( )
        //layout不能获取真正的控价大小 所以需要调用此方法进行绘制
        self.layoutIfNeeded()
         
        singerIconImageView.layer.cornerRadius = singerIconImageView.width * 0.5
        singerIconImageView.layer.masksToBounds = true
    
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension QQMusicListTableViewCell {
    /** 动画 */
    func cellAddAnimation() -> () {
        CellListAnimation.addLayerAnimation(layer: self.layer, type: .Translation, position: .X, repertCount: 1, duration: 0.3)
    }
}

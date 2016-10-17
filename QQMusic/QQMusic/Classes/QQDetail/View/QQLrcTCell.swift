//
//  QQLrcTCell.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/15.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQLrcTCell: UITableViewCell {

    @IBOutlet weak var lrcLabel: QQLrcLable!
    
    var lrcConent : String = "" {
        didSet {
            lrcLabel.text = lrcConent
        }
    }
    
    var progress : CGFloat = 0 {
        didSet {
            lrcLabel.radion = progress
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    class func cellWithTableView(tableView : UITableView) -> QQLrcTCell {
        let cellId = "reuseIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        //Configure the cell...
        if cell == nil {
            cell = Bundle.main.loadNibNamed("QQLrcTCell", owner: nil, options: nil)?.first as! QQLrcTCell?
        }
        return cell as! QQLrcTCell
    }
}

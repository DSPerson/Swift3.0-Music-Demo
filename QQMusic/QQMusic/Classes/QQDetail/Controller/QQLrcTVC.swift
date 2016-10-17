//
//  QQLrcTVC.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/14.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQLrcTVC: UITableViewController {

    
    /* 负责歌词进度 */
    var progressLrc : CGFloat = 0 {
        didSet {
            let indexPath = IndexPath(row: scrollRow, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as? QQLrcTCell
            cell?.progress = progressLrc
        }
    }
    /* 负责滚动 */
    var scrollRow = 0 {
        didSet {
            
            if scrollRow == oldValue {
                return
            }
            /* 先刷新在 做运动 */
            let index = tableView.indexPathsForVisibleRows
            tableView.reloadRows(at: index!, with: .fade)
            
            let indexPath = IndexPath(row: scrollRow, section: 0)
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
    var lrcMs : [QQlrcModel] = [QQlrcModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConfig()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: tableView.height / 2, left: 0, bottom: tableView.height / 2, right: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcMs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = QQLrcTCell.cellWithTableView(tableView: tableView)
        if indexPath.row == scrollRow {
            cell.progress = progressLrc
        } else {
            cell.progress = 0
        }
        let model = lrcMs[indexPath.row]
        cell.lrcConent = model.conent
        return cell
    }
}

extension QQLrcTVC {
    
    func setUpConfig() {
        tableView.separatorStyle = .none
    }
}

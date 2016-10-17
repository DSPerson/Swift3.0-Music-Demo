//
//  QQListTVC.swift
//  QQ音乐
//
//  Created by 杜帅 on 16/10/8.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQListTVC: UITableViewController {

    var musicMs : [QQMusicModel] = [QQMusicModel]() {
       
        didSet{
           tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面处理
        setUpInit()
        
        QQMusicDataTool.getMusicMs { (models : [QQMusicModel]) in
            print(models)
            
            self.musicMs = models
            /* 获取数据赋值 */
            QQMusicOperationTool.shareInstance.musicsM = models
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
}




//专门处理界面问题
extension QQListTVC {
    
    // 界面处理的总入口
    func setUpInit() -> () {
        
        setTableViewImage()
        tableView.rowHeight = 61.0
        
        tableView.separatorStyle = .none
    }
    
    //设置TableView的背景图片
    func setTableViewImage() -> () {
        tableView.backgroundView = UIImageView(image: UIImage(named: "QQLiseBack.png"))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}

//delegete 数据详细
extension QQListTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musicMs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QQMusicListTableViewCell.cellWithTableView(tableView: tableView)
         //cell 赋值
        cell.musicM = self.musicMs[indexPath.row]
       //动画
        cell.cellAddAnimation()
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let musics = musicMs[indexPath.row]
        print("播放音乐", musics.name)
        QQMusicOperationTool.shareInstance.playMusic(musics: musics)
        
    self.performSegue(withIdentifier: "listToDetail", sender: nil)
    
    }
    
    
}

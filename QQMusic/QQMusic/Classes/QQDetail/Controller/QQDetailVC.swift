//
//  QQDetailVC.swift
//  QQ音乐
//
//  Created by 杜帅 on 16/10/8.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQDetailVC: UIViewController {

    /* 
     根据刷新次数分开 
     */
    /* 背景图片 1*/
    @IBOutlet weak var backImageView: UIImageView!
    /* 歌名 1*/
    @IBOutlet weak var songNameLabel: UILabel!
    /* 歌手名字 1*/
    @IBOutlet weak var singerNameLabel: UILabel!
    /* 歌词ScrollView 1 */
    @IBOutlet weak var lrcScrollView: UIScrollView!
    /* 歌词TVC 1*/
    lazy var lrcVC : QQLrcTVC = {
       return QQLrcTVC()
    }()
    
    var updateLrcLink : CADisplayLink?
    /* 展示的图片 1*/
    @IBOutlet weak var foreImageView: UIImageView!
    /* 单行歌词 n */
    @IBOutlet weak var lrcLabel: QQLrcLable!
    /* 进度条 n*/
    @IBOutlet weak var progressSlider: UISlider!
    /* 当前播放时间 n */
    @IBOutlet weak var costTimerLabel: UILabel!
    /* 总时长 1*/
    @IBOutlet weak var totalTimerLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    /* 定时器 */
    var timer : Timer?
    /* 界面返回方法 */
    @IBAction func backButton(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    /* 开始播放 */
    @IBAction func playOrPause(_ sender: AnyObject) {
        let button : UIButton = sender as! UIButton
        button.isSelected = !sender.isSelected
        
        if button.isSelected {
            self.resumeForeImageViewAnimation()
            QQMusicOperationTool.shareInstance.playCurrnetMusic()
            updateLrcLink?.isPaused = false
        } else {
            self.pauseForeImageViewAnimation()
            QQMusicOperationTool.shareInstance.pauseCurrnentMusic()
            updateLrcLink?.isPaused = true
        }
        
    }
    /* 上一首 */
    @IBAction func preMusic() {
        updateLrcLink?.isPaused = false
        QQMusicOperationTool.shareInstance.preMusic()
        setUpKitOnceData()
    }
    /* 下一首 */
    @IBAction func nextMusic() {
        updateLrcLink?.isPaused = false
        QQMusicOperationTool.shareInstance.nextMusic()
        setUpKitOnceData()
    }
    

}

//界面
extension QQDetailVC {
    /* scrollerView设置大小 */
    func setUpScrollerView(frame : CGRect) {
        lrcScrollView.contentSize = CGSize(width: frame.width * 2, height: 0)
    }
    /* scrollerView添加View */
    func addLrcView() {
       
        lrcVC.tableView.backgroundColor = UIColor.clear
        lrcScrollView.addSubview(lrcVC.tableView)
        lrcScrollView.isPagingEnabled = true
        lrcScrollView.showsHorizontalScrollIndicator = false
        lrcScrollView.delegate = self
    }
    /* View设置 创建一次 约束可能是多次 */
    func setUpLrcView() {
        let frame = lrcScrollView.bounds
        lrcVC.tableView.frame = frame
        lrcVC.tableView.x = frame.width
        self.setUpScrollerView(frame: frame)
        self.setUpImageView()
    }
    /* 设置图片圆形 */
    func setUpImageView() -> () {
        foreImageView.layer.cornerRadius = foreImageView.width * 0.5
        foreImageView.layer.masksToBounds = true
    }
    func setUpProgressSlider() -> () {
        
        progressSlider.setThumbImage(UIImage(named:"progressSlider"), for: .normal)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func chargePlayingStatus() {
        let bool = (QQMusicOperationTool.shareInstance.tool.player?.isPlaying)! as Bool
        self.playButton.isSelected = bool
        
    }
    
    func updateLrc() {
        
       // print("次数")
        let message =  QQMusicOperationTool.shareInstance.getMusicMessage()
        let arr = lrcVC.lrcMs
        
        let lrcM = QQMusicDataTool.getCurrntLrcModel(currentTime: message.costTime, lrcModel: arr)
        
        lrcLabel.text = lrcM.model?.conent
        //获取当前行号
        let row = lrcM.row
        
        lrcVC.scrollRow = row
        
        /* 设置歌词进度 */
        if lrcM.model != nil {
            let  time1 =  (message.costTime - lrcM.model!.beginTime)
            let time2 = lrcM.model!.endTime - lrcM.model!.beginTime
            lrcLabel.radion = CGFloat(time1 / time2)
            lrcVC.progressLrc = lrcLabel.radion
        }
        let status = UIApplication.shared.applicationState
        if status == .background {
            QQMusicOperationTool.shareInstance.setUpLocakMessage()
        }
    }
}
//业务逻辑
extension QQDetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLrcView()
        self.setUpProgressSlider()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setUpLrcView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTimer()
        setUpKitOnceData()
        addDisplayLink()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
        removeDisPlayLink()
    }
}
/* 做动画 */
extension QQDetailVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let p = 1 - offsetX / scrollView.width
        //print(p)
        lrcLabel.alpha = p
        foreImageView.alpha = p
    }
    /* 前置图片添加动画 */
    func addForeImageViewAddAnimation() -> () {
        self.foreImageView.layer.removeAnimation(forKey: "foreImageViewRotationAnimation")
        let anaimation = CABasicAnimation(keyPath: "transform.rotation.z")
        anaimation.fromValue = 0
        anaimation.toValue = M_PI * 2
        anaimation.duration = 10
        anaimation.repeatCount = MAXFLOAT
        anaimation.isRemovedOnCompletion = false//退出界面要不要停止动画
        self.foreImageView.layer.add(anaimation, forKey: "foreImageViewRotationAnimation")
    }
    /* 暂停旋转动画 */
    func pauseForeImageViewAnimation() -> () {
        self.foreImageView.layer.pauseAnimation()
    }
    
    func resumeForeImageViewAnimation() -> () {
        self.foreImageView.layer.resumeAnimation()
    }
}
/* 数据赋值 */
extension QQDetailVC {
    /* 一次赋值 */
    func setUpKitOnceData() {
        
        let message =  QQMusicOperationTool.shareInstance.getMusicMessage()
        
        guard message.modelM != nil else {
            return
        }
        
        if message.modelM?.singerIcon != nil {
            backImageView.image = UIImage(named: (message.modelM?.singerIcon)!)
            /* 展示的图片 1*/
            foreImageView.image = UIImage(named: (message.modelM?.singerIcon)!)
        }
        
        /* 歌名 1*/
         songNameLabel.text = message.modelM?.name
        /* 歌手名字 1*/
         singerNameLabel.text = message.modelM?.singer
    
        /* 总时长 1*/
         totalTimerLabel.text = QQTimeTool.getFormatTime(timerInval: message.totalTime)
        
        /* 获取歌词 */
        let lrcArr = QQMusicDataTool.getLrcMS(lrcName: message.modelM?.lrcName)
        /* 将歌词数组给lrcTVC界面 数组 */
        self.lrcVC.lrcMs = lrcArr
        
        addForeImageViewAddAnimation()
        
        let bool = (QQMusicOperationTool.shareInstance.tool.player?.isPlaying)! as Bool
        if bool {
            resumeForeImageViewAnimation()
        } else {
            pauseForeImageViewAnimation()
        }
    }
    /* 多次赋值 */
    func setUpKitTimesData() -> () {
        
        let message =  QQMusicOperationTool.shareInstance.getMusicMessage()
        
        /* 进度条 n*/
         progressSlider.value = Float(message.costTime / message.totalTime)
        /* 当前播放时间 n */
        costTimerLabel.text = QQTimeTool.getFormatTime(timerInval: message.costTime)
        chargePlayingStatus()
    }
    
    /* 添加定时器 */
    func addTimer() -> () {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(setUpKitTimesData), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
    /* 移除定时器 */
    func removeTimer() ->() {
        timer?.invalidate()
        timer = nil
    }
    
    func addDisplayLink() -> () {
        updateLrcLink = CADisplayLink(target: self, selector: #selector(updateLrc))
        updateLrcLink?.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    func removeDisPlayLink() ->() {
        updateLrcLink?.invalidate()
        updateLrcLink = nil
    }
}
/*  */
extension QQDetailVC {
    override func remoteControlReceived(with event: UIEvent?) {
        let type = event?.subtype
        switch type! {
        case .remoteControlPlay:
            print("play")
            QQMusicOperationTool.shareInstance.playCurrnetMusic()
        case .remoteControlPause:
            QQMusicOperationTool.shareInstance.pauseCurrnentMusic()
            print("pause")
        case .remoteControlNextTrack:
            QQMusicOperationTool.shareInstance.nextMusic()
            print("next")
        case .remoteControlPreviousTrack:
            QQMusicOperationTool.shareInstance.preMusic()
            print("pre")
        default:
            print("play - 1")
        }
        setUpKitOnceData()
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        QQMusicOperationTool.shareInstance.nextMusic()
        setUpKitOnceData()
    }
}

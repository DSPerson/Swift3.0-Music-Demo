//
//  QQMusicTool.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/9.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit
import AVFoundation
/*
 播放工具类 ：
    下一首
    上一首
    暂停
    停止
    快进
    快退等功能
 */
class QQMusicTool: NSObject {
    
    
    override init() {
        super.init()
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
            
            try session.setActive(true)
        } catch {
            print(error)
            return
        }
    }
    var player : AVAudioPlayer?
    func playMusicWithName(musicName : String) {
        //1 获取播放路径
        guard  let path = Bundle.main.url(forResource: musicName, withExtension: nil) else {
            return
        }
        
        //如果是正在播放则 return
        if player?.url == path {
            player?.play()
            return
        }
        //2 根据路径创建播放器 因为AVAudioPlayer 需要thorw 穿透
        do {
             player = try AVAudioPlayer(contentsOf: path)
        } catch {
            print(error)
            return
        }
        //3 准备播放
        player?.prepareToPlay()
        //4 开始播放
        
        player?.play() 
    }
    /* 暂停 */
    func pauseMusic() -> () {
        player?.pause()
    }
}

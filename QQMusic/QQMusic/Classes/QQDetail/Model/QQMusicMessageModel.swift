//
//  QQMusicMessageModel.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/12.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQMusicMessageModel: NSObject {
    
    var modelM : QQMusicModel?
    /* 播放时间 */
    var costTime : TimeInterval = 0
    
    var totalTime : TimeInterval = 0
    
    var isPlaying : Bool = false
}

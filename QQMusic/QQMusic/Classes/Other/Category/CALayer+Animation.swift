//
//  CALayer+Animation.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/14.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import Foundation
import UIKit
extension CALayer {
    /* 暂停动画 */
    func pauseAnimation() {
        let pauseTime : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pauseTime
    }
    /* 继续动画 */
    func resumeAnimation() {
        let pauseTime : CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        beginTime = timeSincePause
    }
}

//
//  QQTimeTool.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/14.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQTimeTool: NSObject {
    
    class func getFormatTime(timerInval : TimeInterval) -> String {
        
        let min = Int(timerInval) / 60
        let sec = Int(timerInval) % 60
        return String(format: "%02d : %02d", min, sec)
    }
    
    class func getFormatTimeToTimeInval(format : String) -> TimeInterval {
        let data = format.components(separatedBy: ":")
        if data.count != 2 {
            return 0
        }
        let min = TimeInterval(data[0]) ?? 0.0
        let sec = TimeInterval(data[1]) ?? 0.0
        let timeInerval = min * 60.0 + sec
        return timeInerval
    }
}

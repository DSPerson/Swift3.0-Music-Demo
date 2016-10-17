//
//  QQMusicDataTool.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/8.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQMusicDataTool: NSObject {

    //使用闭包 以后可以从网络获取 直接返回的话 异步是不可以的
    class func getMusicMs(result : ([QQMusicModel]) ->()) {
        //1 获取文件路径
        guard let path = Bundle.main.path(forResource: "Musics.plist", ofType: nil) else {
            result([QQMusicModel]())
            return
        }
        
        //获取文件内容
        
        
        guard let array = NSArray(contentsOfFile: path) else {
            result([QQMusicModel]())
            return
        }
        
        //文件解析
        var models = [QQMusicModel]()
        for dic in array {
            
            let model = QQMusicModel(dic: dic as! [String : AnyObject])
            models.append(model)
        }
        result(models)
    }
    /* 获得所有歌词模型 */
    class func getLrcMS(lrcName : String?) -> ([QQlrcModel]) {
        if lrcName == nil {
            return [QQlrcModel]()
        }
        // 1 读取文件的路径
        guard let path = Bundle.main.path(forResource: lrcName, ofType: nil) else { return  [QQlrcModel]()}
        
        // 2 读取文件中的内容呢
         var lrcConent = ""
        do {
             lrcConent = try String(contentsOfFile: path)
        } catch {
            print(error)
            return [QQlrcModel]()
        }
        // 3 解析字符串
        //print(lrcConent)
        
        var resultArray = [QQlrcModel]()
        let conentArray = lrcConent.components(separatedBy: "\n")
        for  var conentString in conentArray {
            if conentString.contains("[ti:") || conentString.contains("[ar:") || conentString.contains("[t_time:"){
                continue
            }
            //删除第一个括号
             conentString = conentString.replacingOccurrences(of: "[", with: "")
            let detailArray = conentString.components(separatedBy: "]")
            if detailArray.count != 2 {
                continue
            }
            let startTime = QQTimeTool.getFormatTimeToTimeInval(format: detailArray[0])
            var content = detailArray[1]
            
            //content.removeSubrange(<#T##bounds: Range<String.Index>##Range<String.Index>#>)
            content = content.replacingOccurrences(of: "\r", with: "")
            let model = QQlrcModel()
            resultArray.append(model)
            model.beginTime = startTime
            model.conent = content
        }
        
        //遍历resultArray 第二个参数的开始时间是第一个的结束时间
        let count = resultArray.count
        for rs in 0..<count {
            
            if rs == count - 1 {
                break
            }
            let lrcM = resultArray[rs]
            let nextLrcM = resultArray[rs + 1]
            lrcM.endTime = nextLrcM.beginTime
        }
        
        return resultArray
    }
    /* 获取当前播放的歌词模型 */
    class func getCurrntLrcModel (currentTime : TimeInterval, lrcModel : [QQlrcModel]) -> ( row : Int , model : QQlrcModel?) {
        
        var index = 0
        for lrcM in lrcModel {
            
            if lrcM.endTime >= currentTime && lrcM.beginTime <= currentTime {
                
                return (index, lrcM)
            }
            index += 1
        }
        return (0,nil)
    }
}

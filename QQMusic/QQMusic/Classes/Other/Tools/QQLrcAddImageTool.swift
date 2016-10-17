//
//  QQLrcAddImageTool.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/16.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQLrcAddImageTool: NSObject {

    class func addLrcToImage(lrc : String?, sourceImage : UIImage?) -> UIImage? {
        guard let image = sourceImage else {return nil}
        guard let resultStr = lrc else {return image}
        //开启图形上下文
        
        let size = image.size
        let screenWidth = size.height - 30
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let strRect = CGRect(x: 0, y:screenWidth, width: size.width, height: 35)
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let strDic = [
            NSForegroundColorAttributeName:UIColor.red.cgColor,
            NSFontAttributeName : UIFont.systemFont(ofSize: 16),
            NSParagraphStyleAttributeName : style
        ] as [String : Any]
        (resultStr as NSString).draw(in: strRect, withAttributes: strDic)
        let imagePath = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imagePath
        
        
        
        
    }
}

//
//  QQMusicModel.swift
//  QQ音乐
//
//  Created by 杜帅 on 16/10/8.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

class QQMusicModel: NSObject {
    /*歌手的图片 */
    var singerIcon : String?
    
    /* 歌词名字 */
    var lrcName : String?
    
    /* 歌曲路径 */
    var fileName : String?
    
    /*  歌曲名字*/
    var name : String?
       /* 歌手名字  */
    var singer : String?
    
    override init() {
        super.init()
    }
    
    init(dic : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

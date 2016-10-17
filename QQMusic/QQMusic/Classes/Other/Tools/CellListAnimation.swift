//
//  CellListAnimation.swift
//  QQMusic
//
//  Created by 杜帅 on 16/10/9.
//  Copyright © 2016年 杜帅. All rights reserved.
//

import UIKit

enum CellListAnimationType {
    case Translation /* 平移 */
    case Scale /* 缩放 */
    case Rotation /* 旋转 */
}

enum AnimationPosition {
    case X
    case Y
    case Z
}
class CellListAnimation: NSObject {
    
    class func addLayerAnimation(layer : CALayer,type : CellListAnimationType, position : AnimationPosition,repertCount : Int, duration : CGFloat) {
        if type == .Translation {
            
            let animationPosition = position == .X ? ".x" : ".y"
            //先移除动画
            layer.removeAnimation(forKey: "transform.tranlation" + animationPosition)
            let anmation = CAKeyframeAnimation(keyPath: "transform.translation" + animationPosition)
            anmation.duration = CFTimeInterval(duration)
            anmation.repeatCount = Float(repertCount)
            anmation.values = [-40,0,40]
            layer.add(anmation, forKey: "translation")
        }
        if type == .Scale {
            let animationPosition = position == .X ? ".x" : ".y"
            //先移除动画
            layer.removeAnimation(forKey: "transform.scale" + animationPosition)
            let anmation = CAKeyframeAnimation(keyPath: "transform.scale" + animationPosition)
            anmation.duration = CFTimeInterval(duration)
            anmation.repeatCount = Float(repertCount)
            anmation.values = [0.5,1,0.5,1]
            layer.add(anmation, forKey: "scale")
        }
        if type == .Rotation {
            var posit : String?
            if position == .X {
                posit = ".x"
            }
            if position == .Y {
                posit = ".x"
            }
            if position == .Z {
                posit = ".y"
            }
            let animationPosition = posit
            //先移除动画
            layer.removeAnimation(forKey: "transform.rotation" + animationPosition!)
            let anmation = CAKeyframeAnimation(keyPath: "transform.rotation" + animationPosition!)
            anmation.duration = CFTimeInterval(duration)
            anmation.repeatCount = Float(repertCount)
            anmation.values = [-1/6*M_PI,0,1/6*M_PI,0]
            layer.add(anmation, forKey: "rotation")

        }
    }
}

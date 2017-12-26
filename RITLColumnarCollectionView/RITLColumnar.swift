//
//  RITLColumnar.swift
//  RITLColumnarCollectionDemo
//
//  Created by YueWen on 2017/12/26.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// 生成图片
    public var ritl_image : UIImage {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}


extension Int {
    
    /// 将数据大小变为格式字符串
    public var ritl_dataSize : String {
        
        guard self > 0 else {
            
            return ""
        }
        
        let unit = 1024.0
        
        guard Double(self) < unit * unit else {
            
            return String(format:"%.1fMB",Double(self) / unit / unit)
        }
        
        guard Double(self) < unit else {
            
            return String(format:"%.0fKB",Double(self) / unit)
        }
        
        return "\(self)B"
    }
    
    
    
    /// 16进制数值获得颜色
    public var ritl_color : UIColor {
        
        guard self > 0 else {
            
            return UIColor.white
        }
        
        let red = (CGFloat)((self & 0xFF0000) >> 16) / 255.0
        let green = (CGFloat)((self & 0xFF00) >> 8) / 255.0
        let blue = (CGFloat)((self & 0xFF)) / 255.0
        
        
        if #available(iOS 10, *)
        {
            return UIColor(displayP3Red:red , green: green, blue: blue, alpha: 1.0)
        }
        
        guard #available(iOS 10, *) else {
            
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        return UIColor.black
    }
}


//
//  CollectionViewCell.swift
//  ProjectTest
//
//  Created by YueWen on 2017/12/25.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit


protocol CollectionViewAniamted {
    
    func startAnimated()
}


protocol CollectonValueSetAble {
    
    func changedHeight(_ rate: CGFloat)
}



extension CollectionViewAniamted {
    
    func startAnimated() {
        
    }
}

extension CollectonValueSetAble{
    
    func changedHeight(_ rate: CGFloat){
        
        
    }
}



extension UICollectionViewCell: CollectionViewAniamted {}
extension UICollectionViewCell: CollectonValueSetAble {}


class CollectionViewCell: UICollectionViewCell {
    
    /// 标题距离上面的距离，默认为.constant = 20
    @IBOutlet weak var titleLabelMarginTop: NSLayoutConstraint!
    /// 动画的视图
    @IBOutlet weak var animatedView: UIView!
    /// 时间标签
    @IBOutlet weak var timeLabel: UILabel!
    /// 圆形
    @IBOutlet weak var circleView: UIView!
    /// 天使轮
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 记录重用时进行的动画
    weak var animatedGroup: CAAnimationGroup?
    
    /// 记录动画的确认高度
    var animatedTotalHeight: CGFloat {
        
        get {
            return 164
        }
    }
    
    /// 渐变layer
    var gradientLayer: CALayer? {
        
        get{
            return self.shapeLayer.sublayers?.first
        }
    }
    
    /// 渐变色
    var startColor: UIColor = .blue
    var endColor: UIColor = .green
    
    /// 当前柱形图的比例
    var scale: CGFloat = 1.0
    
    
    /// 动画的layer
    lazy private var shapeLayer: CAShapeLayer = {
        
        //创建渐变
        let colorLayer = CAGradientLayer()
        colorLayer.bounds = self.animatedView.bounds
        colorLayer.startPoint = CGPoint(x: 0.5, y: 0)
        colorLayer.endPoint = CGPoint(x: 0.5, y: 1)
        colorLayer.cornerRadius = 4
        colorLayer.colors = [self.startColor.cgColor,self.endColor.cgColor]
        colorLayer.anchorPoint = CGPoint(x: 0, y: 0)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect(x: 0, y:0, width: self.animatedView.bounds.width, height: 0)
        shapeLayer.position = CGPoint(x: 0, y: self.animatedTotalHeight)
        shapeLayer.masksToBounds = true;
        shapeLayer.insertSublayer(colorLayer, at: 0)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)

        return shapeLayer
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true;
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
//        print("height = \(self.animatedTotalHeight)")
//        animatedView.layer.cornerRadius = 4
        circleView.layer.cornerRadius = circleView.bounds.width / 2.0
    }
    
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        self.shapeLayer.removeFromSuperlayer()
    }
    
}



extension CollectionViewCell {
    
    func startAnimated() {
        
        //add
        self.animatedView.layer.insertSublayer(self.shapeLayer, at: 0)
        
        //启用动画
        let heightAnimated = CABasicAnimation(keyPath: "bounds.size.height")
        heightAnimated.fromValue = 0
        heightAnimated.toValue = animatedTotalHeight * scale
//        heightAnimated.isRemovedOnCompletion = false;
        
        
        let originYAnimated = CABasicAnimation(keyPath: "position.y")
        originYAnimated.fromValue = animatedTotalHeight
        originYAnimated.toValue = animatedTotalHeight * (1.0 - scale)
//        originYAnimated.isRemovedOnCompletion = false;
        
        //动画组
        let animatedGroup = CAAnimationGroup()
        animatedGroup.animations = [heightAnimated,originYAnimated]
        animatedGroup.duration = 0.5
        
        //开启动画
//        shapeLayer.sublayers?.first?.add(animatedGroup, forKey: "")
        shapeLayer.add(animatedGroup, forKey: "")
        
        self.animatedGroup = animatedGroup
    }
    
    

}

extension CollectionViewCell {
    
    func changedHeight(_ rate: CGFloat){

        print("scale = \(rate)")
        
        guard rate >= 0.0 && rate <= 1.0 else {

            return
        }

        scale = rate

        //修改layer高度
        self.shapeLayer.position.y = animatedTotalHeight * (1.0 - scale)
        self.shapeLayer.bounds.size.height = animatedTotalHeight * scale
        
        //修改渐变色的参考坐标
        self.gradientLayer?.position.y = -1 * animatedTotalHeight * (1.0 - scale)
        
        //默认为20
        let marginTop: CGFloat = animatedTotalHeight - animatedTotalHeight * scale;
        
        self.titleLabelMarginTop.constant = marginTop + 20;
    }
}







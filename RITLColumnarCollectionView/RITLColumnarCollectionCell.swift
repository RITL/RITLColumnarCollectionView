//
//  CollectionViewCell.swift
//  ProjectTest
//
//  Created by YueWen on 2017/12/25.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit
import SnapKit

protocol RITLCollectionAnimated {
    
    func startAnimated()
}


/// 数据更新
struct RITLCollectionDataUpdater {
    
    var title: String = "天使轮 200亿"
    var bottomTitle: String = "2016-01-01"
    
    init(title: String = "天使轮 200亿", bottomTitle:String = "2016-01-01") {
        
        self.title = title
        self.bottomTitle = bottomTitle
    }
}


/// 相关UI更新
struct RITLCollectionDisplayUpdater {
    
    var rate: CGFloat = 1
    var topColor: UIColor = .blue
    var bottomColor: UIColor = .green
    var duration: TimeInterval = 0.5
    
    init(rate: CGFloat = 1,topColor: UIColor = .blue,bottomColor: UIColor = .green,duration: TimeInterval = 0.5) {
        
        self.rate = rate
        self.topColor = topColor
        self.bottomColor = bottomColor
        self.duration = duration
    }
}



protocol RITLCollectonUpdate {
    
    func updateDisplay(_ updater: RITLCollectionDataUpdater)
    func updateData(_ updater: RITLCollectionDataUpdater)
}


extension RITLCollectionAnimated {
    
    func startAnimated() {}
}


extension RITLCollectonUpdate{
    
    func updateDisplay(_ updater: RITLCollectionDataUpdater) {}
    func updateData(_ updater: RITLCollectionDataUpdater) {}
}



extension UICollectionViewCell: RITLCollectionAnimated {}
extension UICollectionViewCell: RITLCollectonUpdate {}


class RITLColumnarCollectionCell: UICollectionViewCell {
    
    // MARK: 开放属性
    
    /// 顶部的颜色
    var topColor: UIColor = .blue {
        
        willSet{
            self.startColor = newValue
        }
        
        didSet {
            self.gradientLayer?.colors = [self.startColor.cgColor,self.endColor.cgColor]
        }
    }
    
    /// 底部的颜色
    var bottomColor: UIColor = .green {
        
        willSet {
            self.endColor = newValue
        }
        
        didSet {
            self.gradientLayer?.colors = [self.startColor.cgColor,self.endColor.cgColor]
        }
    }

    /// 当前柱形图显示的比例
    var scale: CGFloat = 1.0
    /// 动画的持续时间
    var duration: TimeInterval = 0.5
    
    // MARK: 开放UI
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
    /// 模拟的横线
    @IBOutlet weak var lineView: UIView!
    
    // MARK: Private
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
    
    
    /// 记录重用时进行的动画
    private weak var animatedGroup: CAAnimationGroup?
    
    
    /// 记录动画的确认高度
    private var animatedTotalHeight: CGFloat {
        get {
            return 164
        }
    }
    
    /// 渐变layer
    private var gradientLayer: CAGradientLayer? {
        get{
            return self.shapeLayer.sublayers?.first as? CAGradientLayer
        }
    }
    
    /// 渐变色开始，为顶部的颜色
    private var startColor: UIColor = .blue
    /// 渐变色的结束，为底部颜色
    private var endColor: UIColor = .green
    
    // MARK: Function
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        shapeLayer.cornerRadius = 4
        circleView.layer.cornerRadius = circleView.bounds.width / 2.0
    }
    
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        self.shapeLayer.removeFromSuperlayer()
    }
    
    /// 创建Layouts
    private func buildLayouts(){
        
//        contentView.addSubview(animatedView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(lineView)
//        contentView.addSubview(circleView)
//        contentView.addSubview(titleLabel)
//
//        lineView.snp.makeConstraints { (make) in
//
//            make.bottom.equalToSuperview().inset(40)
//            make.height.equalTo(1)
//            make.left.right.equalToSuperview()
//        }
//
//        titleLabel.snp.makeConstraints { (make) in
//
//            make.left.right.bottom.equalToSuperview()
//            make.top.equalTo(self.lineView.snp.bottom).inset(10)
//        }
//
        
        
    }
    
}



extension RITLColumnarCollectionCell {
    
    func startAnimated() {
        
        //add
        self.animatedView.layer.insertSublayer(self.shapeLayer, at: 0)
        
        //启用动画
        let heightAnimated = CABasicAnimation(keyPath: "bounds.size.height")
        heightAnimated.fromValue = 0
        heightAnimated.toValue = animatedTotalHeight * scale
        
        let originYAnimated = CABasicAnimation(keyPath: "position.y")
        originYAnimated.fromValue = animatedTotalHeight
        originYAnimated.toValue = animatedTotalHeight * (1.0 - scale)
        
        //动画组
        let animatedGroup = CAAnimationGroup()
        animatedGroup.animations = [heightAnimated,originYAnimated]
        animatedGroup.duration = duration
        
        //开启动画
        shapeLayer.add(animatedGroup, forKey: "")
        
        self.animatedGroup = animatedGroup
    }
    
    

}

extension RITLColumnarCollectionCell {
    
    func updateDisplay(_ updater: RITLCollectionDisplayUpdater) {
        
        guard updater.rate >= 0.0 && updater.rate <= 1.0 else {
            
            return
        }
        
        scale = updater.rate
        
        //修改layer高度
        self.shapeLayer.position.y = animatedTotalHeight * (1.0 - scale)
        self.shapeLayer.bounds.size.height = animatedTotalHeight * scale
        
        //修改渐变色
        self.gradientLayer?.colors = [updater.topColor.cgColor,updater.bottomColor.cgColor]
        
        //修改渐变色的参考坐标
//        self.gradientLayer?.position.y = -1 * animatedTotalHeight * (1.0 - scale)
        
        //默认为20
        let marginTop: CGFloat = animatedTotalHeight - animatedTotalHeight * scale;
        
        self.titleLabelMarginTop.constant = marginTop + 20;
    }
    
    
    
    func updateData(_ updater: RITLCollectionDataUpdater) {
        
        self.titleLabel.text = updater.title
        self.timeLabel.text = updater.bottomTitle
    }
    
    
    
//    func changedHeight(_ rate: CGFloat){
//
//        print("scale = \(rate)")
//        
//        guard rate >= 0.0 && rate <= 1.0 else {
//
//            return
//        }
//
//        scale = rate
//
//        //修改layer高度
//        self.shapeLayer.position.y = animatedTotalHeight * (1.0 - scale)
//        self.shapeLayer.bounds.size.height = animatedTotalHeight * scale
//        
//        //修改渐变色的参考坐标
//        self.gradientLayer?.position.y = -1 * animatedTotalHeight * (1.0 - scale)
//        
//        //默认为20
//        let marginTop: CGFloat = animatedTotalHeight - animatedTotalHeight * scale;
//        
//        self.titleLabelMarginTop.constant = marginTop + 20;
//    }
}







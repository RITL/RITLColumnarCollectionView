//
//  ViewController.swift
//  ProjectTest
//
//  Created by YueWen on 2017/12/25.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.dataSource = self
        collectionView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var scales = [0.9,0.5,0.3,0.2]
    
    private var topColors = [0xFA8568.ritl_color,
                             0xEF9D28.ritl_color,
                             0xF4D766.ritl_color,
                             0x71EF69.ritl_color]
    
    private var bottomColors = [0xF85644.ritl_color,
                                0xF7854C.ritl_color,
                                0xFFBA08.ritl_color,
                                0x2ABD00.ritl_color]
    
    private var titles = ["B轮\n1亿","A轮\n5000万","Pre-A\n1000万","种子轮\n500万"]

}


extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return scales.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: RITLColumnarCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! RITLColumnarCollectionCell
        
        let item = indexPath.item
        
        cell.updateData(RITLCollectionDataUpdater(title:titles[item]))
        
        cell.updateDisplay(RITLCollectionDisplayUpdater(rate: CGFloat(scales[item]),
                                                        topColor: topColors[item],
                                                        bottomColor: bottomColors[item]))
        cell.startAnimated()
        
        return cell
    }
    
}





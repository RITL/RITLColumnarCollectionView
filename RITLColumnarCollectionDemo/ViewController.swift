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
    
    private var scales = [0.4,0.6,0.8,0.3,1.0,0.6,0.7,0.6,0.9,0.4,0.6,0.4,0.2]

}


extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return scales.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.changedHeight(CGFloat(scales[indexPath.item]))
        cell.startAnimated()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        let cell = collectionView.cellForItem(at: indexPath)
        
//        cell?.startAnimated()
        print("\(indexPath) is finished")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        let cell = collectionView.cellForItem(at: indexPath)
        
//        cell?.startAnimated()
    }
    
}





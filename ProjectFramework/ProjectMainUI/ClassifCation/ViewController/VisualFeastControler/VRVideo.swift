//
//  VRVideo.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class VRVideo: CustomTemplateViewController {

    var width: CGFloat!
    var images: Array<UIImage>!
    var collectionView:UICollectionView!
    let reuseIdentifier = "CustomWaterCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initUI() -> Void {
        width = (view.bounds.size.width - 20)/3
        let layout = WaterCollectionViewLayout()
        images = []
        for i in 1..<9 {
            let image = UIImage(named: String.init(format: "Classif\(i).jpg"))
            images.append(image!)
        }
        print(self.view.bounds)
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 94), collectionViewLayout: layout)
        collectionView.register(CustomWaterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.white
        self.InitCongifCollection(collectionView,  nil)
        self.numberOfSections=1
        view.addSubview(collectionView)
        layout.setSize = {_ in
            return self.images
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomWaterCell
        cell.mainImageView.backgroundColor = CommonFunction.RGBA(CGFloat(arc4random() % 255), g: CGFloat(arc4random() % 255), b: CGFloat(arc4random() % 255), a: 1)
        cell.setData("360Panorama", isHiden: false, centerText: "VR")
        return cell
    }
}

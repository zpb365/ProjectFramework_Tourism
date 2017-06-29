//
//  CommentPhotoView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class CommentPhotoView: UIView {
    
    var imageViewsArray = [UIImageView]()
    var imgArray = [String]()
    
    func initCommentPhotoView(_ imageArray:[String],showCount:Int, rowCount:Int,contenViewWidth:CGFloat, xMargin:CGFloat, yMargin:CGFloat) -> UIView {
        self.backgroundColor = UIColor.white
        imgArray = imageArray
        //左右间隔总和
        let _W =  contenViewWidth - (xMargin * CGFloat(rowCount - 1))
        //视图宽度自动计算大小
        let width = _W / CGFloat (rowCount)

        
        for i in 0..<imageArray.count{
            //一行中的第几个
            let row  = i % rowCount
            //
            let low = i / rowCount
            
            
            let X = (width + xMargin) * CGFloat(row)
            let Y = (width + yMargin) * CGFloat(low)
            

            //总行数
            let imageView = UIImageView.init()
            imageView.isUserInteractionEnabled = true
            imageView.frame = CommonFunction.CGRect_fram(X, y: Y, w: width, h: width)
            imageView.image = UIImage.init(named: imageArray[i])
            imageView.tag = i
            if  (imageView.image == nil) {
                imageView.ImageLoad(PostUrl: HttpsUrlImage + imageArray[i])
            }
            self.addSubview(imageView)
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
            imageView.addGestureRecognizer(tap)
            
            imageViewsArray.append(imageView)
        }
        return self
    }
    
    func tapClick(_ tap:UITapGestureRecognizer) -> Void {
        var phtos = [Any]()
        for i in 0..<imageViewsArray.count {
            let child = imageViewsArray[i]
            let pohtoView = JLPhoto.init()
            pohtoView.sourceImageView = child
            pohtoView.bigImgUrl = HttpsUrlImage + self.imgArray[i]
            pohtoView.tag = i
            phtos.append(pohtoView)
        }
        
        let photoBrowser = JLPhotoBrowser.init()
        photoBrowser.photos = phtos
        photoBrowser.currentIndex = Int32(tap.view!.tag)
        photoBrowser.show()
    }
}

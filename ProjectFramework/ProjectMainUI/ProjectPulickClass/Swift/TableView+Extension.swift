//
//  TableView+Extension.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation



extension UITableView   {
    
    
    ///  cell获取高度
    ///
    /// - Parameters:
    ///   - lableWidth: lable宽度
    ///   - commont: 内容
    ///   - imageArray: 图片数组
    ///   - showCount: 显示个数
    ///   - rowCount: 每行显示个数
    ///   - xMargin: x间距
    ///   - yMargin: y间距
    func getHeightWithCell(lableWidth:CGFloat, commont:String,imageArray:[String],showCount:Int, rowCount:Int,contenViewWidth:CGFloat, xMargin:CGFloat, yMargin:CGFloat) -> CGFloat{
        //文字高度
        let h1 = commont.ContentSize(font: UIFont.systemFont(ofSize: 11), maxSize: CGSize(width: lableWidth, height: 0))
        //左右间隔总和
        let _W =  contenViewWidth - (xMargin * CGFloat(rowCount - 1))
        //视图宽度自动计算大小
        let width = _W / CGFloat (rowCount)
        var low = Int(0)
        if ((showCount % rowCount) == 0) {
            low = (showCount / rowCount)
        }
        else{
            low = (showCount / rowCount) + 1
        }
        //总行数
        //总高度
        let height = h1.height + (width * CGFloat(low)) + (yMargin * CGFloat(low - 1))
        
        return height + 5
    }
    func getCommentPhotoViewHeight(imageArray:[String],showCount:Int, rowCount:Int,contenViewWidth:CGFloat, xMargin:CGFloat, yMargin:CGFloat) -> CGFloat {
        //左右间隔总和
        let _W =  contenViewWidth - (xMargin * CGFloat(rowCount - 1))
        //视图宽度自动计算大小
        let width = _W / CGFloat (rowCount)
        var low = Int(0)
        if ((showCount % rowCount) == 0) {
            low = (showCount / rowCount)
        }
        else{
            low = (showCount / rowCount) + 1
        }
        //总高度
        let height = (width * CGFloat(low)) + (yMargin * CGFloat(low - 1))
        
        return height
    }
}

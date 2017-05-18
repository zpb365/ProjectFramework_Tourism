//
//  RecommendedViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RecommendedViewCell: UITableViewCell {

    @IBOutlet weak var ScrollView: UIScrollView!
    weak var delegate:UIViewController?=nil
    fileprivate  var imageW:CGFloat!
    fileprivate var imageH:CGFloat!
    fileprivate var imageY:CGFloat!
    var UIImageList = [ClassHotList]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
        
        if(ScrollView.subviews.count==1){
            
            UIImageList = cell as! [ClassHotList]
            
            imageW = self.contentView.frame.size.width/3+10;//获取ScrollView的宽作为图片的宽；
            imageH = self.contentView.frame.size.height-20;//获取ScrollView的高作为图片的高；
            
            //关闭滚动条显示
            ScrollView.showsHorizontalScrollIndicator = false
            ScrollView.showsVerticalScrollIndicator = false
            ScrollView.scrollsToTop = false
            imageY  = 0;//图片的Y坐标就在ScrollView的顶端；
            var index=0
            if(self.UIImageList.count>0){
                
                for _ in self.UIImageList {
                    AddScrollViewContrler(index: index,ClassHotList: UIImageList[index])
                    index += 1
                }
            }
            //需要非常注意的是：ScrollView控件一定要设置contentSize;包括长和宽；
            let contentW:CGFloat = imageW * CGFloat(index) + 5 ;//这里的宽度就是所有的图片宽度之和；
            self.ScrollView.contentSize = CGSize(width: contentW, height: 0);
            
            ScrollView.backgroundColor=UIColor.white
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func AddScrollViewContrler(index:Int,ClassHotList:ClassHotList){
             let imageX:CGFloat = CGFloat(index) * imageW;
        let imageView = UIImageView(frame: CGRect(x: imageX+5, y: imageY, width: imageW-5, height: imageH)) //设置图片的大小，注意Image和ScrollView的关系，其实几张图片是按顺序从左向右依次放置在ScrollView中的，但是ScrollView在界面中显示的只是一张图片的大小，效果类似与画廊
         imageView.ImageLoad(PostUrl: HttpsUrlImage+ClassHotList.Img)
        imageView.backgroundColor=UIColor.red
        imageView.contentMode=UIViewContentMode.scaleToFill
       
        let TapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
        TapGestureRecognizer.ExpTagString=ClassHotList.LinkUrl
        imageView.isUserInteractionEnabled=true
        imageView.addGestureRecognizer(TapGestureRecognizer)
        
        let title = UILabel(frame: CGRect(x: imageX+5, y: imageView.frame.maxY, width: imageW, height: 20)) //标题
        title.font=UIFont.systemFont(ofSize: 12)
        title.text=ClassHotList.Title
        title.textColor=UIColor.gray
        
        ScrollView.addSubview(imageView)
        ScrollView.addSubview(title)

    }
    
    func handleTapGesture(sender: UITapGestureRecognizer){
        print("点击了"+sender.ExpTagString)
        
        let vc = MCWebViewController.init(url: sender.ExpTagString, ProcesscColor: UIColor.clear)
        delegate?.navigationController?.show(vc, sender: self)
    }

}

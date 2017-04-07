//
//  UserCommentCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/3/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class UserCommentCell: UITableViewCell {

    //评论图片
    lazy  var photoView : CommentPhotoView = {
        let photoView = CommentPhotoView()
        return photoView
    }()
    //用户头像
    lazy var userIcon: UIImageView = {
         let userIcon = UIImageView.init(frame: CommonFunction.CGRect_fram(15, y: 5, w: 35, h: 35))
         userIcon.image = UIImage.init(named: "testimg")
         userIcon.layer.cornerRadius = userIcon.frame.width / 2
         userIcon.clipsToBounds = true
         return userIcon
    }()
    //用户昵称
    lazy var userNickName: UILabel = {
         let userNickName = UILabel.init(frame: CommonFunction.CGRect_fram(self.userIcon.frame.maxX + 5, y: 5, w: 100, h:15 ))
             userNickName.font = UIFont.systemFont(ofSize: 11)
             userNickName.text = "住朋购友"
         return userNickName
    }()
    //用户性别
    lazy var userSexy: UIImageView = {
         let userSexy = UIImageView.init(frame: CommonFunction.CGRect_fram(self.userNickName.frame.maxX, y: 5, w: 15, h: 15))
         userSexy.image = UIImage.init(named: "sexy")
         return userSexy
    }()
    //时间
    lazy var timeLable: UILabel = {
        let timeLable = UILabel.init(frame: CommonFunction.CGRect_fram(CommonFunction.kScreenWidth - 100 - 10, y: 5, w: 100, h:15 ))
        timeLable.font = UIFont.systemFont(ofSize: 11)
        timeLable.textAlignment = .right
        timeLable.textColor = UIColor.lightGray
        timeLable.text = "3天前"
        return timeLable
    }()
    //评分
    lazy var startView: UIImageView = {
        let startView = UIImageView.init(frame: CommonFunction.CGRect_fram(self.userNickName.frame.minX, y: self.userNickName.frame.maxY+5, w: 80, h: 16))
        startView.backgroundColor = UIColor.blue
        return startView
    }()
    //评论内容
    lazy var commentLable: UILabel = {
        let commentLable = UILabel.init(frame: CommonFunction.CGRect_fram(15, y: self.userIcon.frame.maxY + 5, w: CommonFunction.kScreenWidth - 30, h:0 ))
        commentLable.font = UIFont.systemFont(ofSize: 11)
        commentLable.numberOfLines = 0
        return commentLable
    }()
    
    var flag: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    //MARK: 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.addSubview(self.userIcon)
        self.contentView.addSubview(self.userNickName)
        self.contentView.addSubview(self.userSexy)
        self.contentView.addSubview(self.startView)
        self.contentView.addSubview(self.timeLable)
        self.contentView.addSubview(self.commentLable)
        self.contentView.addSubview(self.photoView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: 创建UI
    
    override func InitConfig(_ cell: Any) {
        if (!flag){
            let model = cell as! UserCommentModel
            let nickNameWidth = model.nickName.getContenSizeWidth(font: UIFont.systemFont(ofSize: 11))
            let commontHeight = model.comment.ContentSize(font: UIFont.systemFont(ofSize: 11), maxSize: CGSize(width: CommonFunction.kScreenWidth - 35, height: 0)).height
            let photoViewHeight = UITableView().getCommentPhotoViewHeight(imageArray: model.imageArray, showCount: model.imageArray.count, rowCount: 4, contenViewWidth: CommonFunction.kScreenWidth - 35, xMargin: 10, yMargin: 10)
            
            userNickName.frame = CommonFunction.CGRect_fram(userNickName.frame.origin.x, y: userNickName.frame.origin.y, w: nickNameWidth, h: userNickName.frame.height)
            userSexy.frame = CommonFunction.CGRect_fram(userNickName.frame.maxX + 5, y: 5, w: 15, h: 15)
            commentLable.frame = CommonFunction.CGRect_fram(commentLable.frame.origin.x, y: commentLable.frame.origin.y, w: CommonFunction.kScreenWidth - 35, h: commontHeight)
            photoView.frame = CommonFunction.CGRect_fram(commentLable.frame.origin.x, y: commentLable.frame.maxY + 5, w: CommonFunction.kScreenWidth - 35, h: photoViewHeight)
            commentLable.text = model.comment
            _ = photoView.initCommentPhotoView(model.imageArray, showCount: model.imageArray.count, rowCount: 4, contenViewWidth: CommonFunction.kScreenWidth - 35, xMargin: 10, yMargin: 10)
            
            flag = true
        }
    }
}

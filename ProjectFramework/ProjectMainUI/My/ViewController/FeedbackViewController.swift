//
//  FeedbackViewController.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 16/7/16.
//  Copyright © 2016年 HCY. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController,UITextFieldDelegate ,UITextViewDelegate {

    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var promptLable: UILabel!//textview文本提示文本
    @IBOutlet weak var contactLable: UITextField!//联系文本
    @IBOutlet weak var showCount: UILabel!
    
    @IBAction func submitClick(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initUI() -> Void {
        self.title="意见反馈"
        
        self.automaticallyAdjustsScrollViewInsets=false // //取消掉被
        self.view.backgroundColor = UIColor.white
        commentTextView.layer.cornerRadius = 5
        commentTextView.layer.borderWidth = 0.5
        commentTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        contactLable.layer.cornerRadius = 4
        contactLable.layer.borderWidth = 0.5
        contactLable.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        commentTextView.delegate = self
        contactLable.delegate = self
        
    }
    //MARK: UITextViewDelegate
    //检测到textView为空时，隐藏键盘
    func textViewDidChange(_ textView: UITextView) {
        if (commentTextView.text == "") {
            commentTextView.resignFirstResponder()
            promptLable.isHidden = false
        }
        else{
//            commentTextView.text.characters.count
            let num = 500 - commentTextView.text.characters.count
            showCount.text = "\(num)/500"
        }
    }
    //开始编辑，隐藏lable
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        promptLable.isHidden = true
        return true
    }
    //取消键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if (commentTextView.text.characters.count == 0) {
            promptLable.isHidden = false
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location >= 500 {
            return false
        }
        else {
            return true
        }
    }
    
  

}

//
//  PayPublicView.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/5.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation


class PayClass:UIViewController {
    
    fileprivate  var menu:HcdPopMenuView?
    fileprivate var OrderNumber=""
    fileprivate var parameters:Any?      //请求参数
    fileprivate var Url=""
    fileprivate weak var delegate:UIViewController?=nil
    
    
    init(parameters:Any,Channels:Int,delegate:UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.delegate=delegate
        self.parameters=parameters
        view.backgroundColor=UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.01)
        switch Channels {
        case 0:     //我的订单
            Url=HttpsUrl+"api/My/SetOrderPay"
            break
        case 1:     //景区
            Url=HttpsUrl+"api/Channels/ScenicSubmitOrder"
            break
        case 2:     //酒店
            Url=HttpsUrl+"api/Channels/HotelSubmitOrder"
            break
        case 3:     //餐厅
            Url=HttpsUrl+"api/Channels/RestaurantSubmitOrder"
            break
        case 4:     //旅行社
            Url=HttpsUrl+"api/Channels/TravelAgencySubmitOrder"
            break
        case 5:     //会展
            Url=HttpsUrl+"api/Channels/MeetingSubmitOrder"
            break
        case 6:     //特产
            Url=HttpsUrl+"api/Channels/SpecialitiesSubmitOrder"
            break
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        //添加通知  支付完成\未完成等的通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.PayResultStatus), name: NSNotification.Name(rawValue: ZFBPayNoticeResultStatus), object: nil)
        let items: [Any] = [[kHcdPopMenuItemAttributeTitle: "微信支付", kHcdPopMenuItemAttributeIconImageName: "WXlogo"],
                            [kHcdPopMenuItemAttributeTitle: "支付宝", kHcdPopMenuItemAttributeIconImageName: "ZFBlogo"]]
        
        menu = HcdPopMenuView(items: items)
        menu?.setSelectCompletionBlock({[weak self]  (index) in //点击按钮Item
            //index 0微信 1支付宝
            self?.OrderPay(PaymenType: index)
        })
        menu?.setSelectbgCompletionBlock({ [weak self](index) in    //点击X 或者背景
            self?.dismiss(animated: false, completion: nil)
        })
        
        menu?.setTipsLblByTipsStr("支付声明,请注意查看订单价格与支付价格是否一致,如出现不一致请联系客服。")
        menu?.setExitViewImage("center_exit")
    }
    
    //订单支付
    func OrderPay(PaymenType:Int ){
        
        var parameters = self.parameters as! Dictionary<String, Any>
        parameters["PaymenType"]=PaymenType
        
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: Url,isHUD: true,HUDMsg: "订单提交中...", isHUDMake: false, parameters: parameters as NSDictionary, Model: { (resultData) in
            
            if(resultData?.Success==true){
                if resultData?.Content != nil {
                    if(PaymenType==0){
                        print("weix")
                    }
                    if(PaymenType==1){
                        self.AliplayFunc(OrderString: resultData?.Content as! String)
                    }
                    
                    
                }
            }else{
                CommonFunction.HUD(resultData!.Result, type: .error)
                
                self.menu?.menuItemdismiss()
                self.dismiss(animated: false, completion: nil)
            }
            
        })
        
        
    }
    
    //跳转支付宝
    func AliplayFunc(OrderString:String){
        
        if(  OrderString != "" ){
            AlipaySDK.defaultService().payOrder(OrderString, fromScheme: ZFBAppScheme, callback: { (resultDic) -> Void in
                print("aaa:\(String(describing: resultDic))")
            })
        }
    }
    
    //利用KVO来改变该属性的值   ---支付宝
    @objc internal func  PayResultStatus(notification:NSNotification){
        let dic = notification.userInfo as! [String:Any]
        let resultStatus =  dic["resultStatus"] as! String
        
        if resultStatus == "9000"{
            print("OK,支付完成")
            self.delegate?.navigationController?.popToRootViewController(animated: true)
            CommonFunction.MessageNotification("您已支付成功", interval: 3, msgtype: .success)
            
        }else if resultStatus == "8000" {
            print("正在处理中")
        }else if resultStatus == "4000" {
            print("订单支付失败")
            CommonFunction.MessageNotification("支付失败，订单已生成，请到我的订单查看", interval: 3, msgtype: .error)
        }else if resultStatus == "6001" {
            print("用户中途取消")
            self.delegate?.navigationController?.popToRootViewController(animated: true)
            // self.delegate?.navigationController.pop
            CommonFunction.MessageNotification("您的订单已生成，请到我的订单查看", interval: 3, msgtype: .success)
        }else if resultStatus == "6002" {
            print("网络连接出错")
        }
        
        self.menu?.menuItemdismiss()
        self.dismiss(animated: false, completion: nil)
        
    }
    
    deinit {    //销毁当前通知 通道
        print("deinit 进入了")
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
}

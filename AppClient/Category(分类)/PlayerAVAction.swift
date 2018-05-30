//
//  PlayerAVAction.swift
//  AppClient
//
//  Created by xinz on 2018/4/12.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

import Foundation
import UIKit
import EncryptedAVPlayerView



extension UIViewController{
    
    
    typealias fucBlock = (_ backStr:String) ->();
    
    func showVideoDownloadChoice(sku:String, sign:String,memId:String,blockProperty:@escaping fucBlock) -> Void {

        let alertVC:UIAlertController = UIAlertController(title: "请先下载再进行观看", message: nil, preferredStyle:UIAlertControllerStyle.actionSheet);
        
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
            print(action);
        };
        
        let ensureAction:UIAlertAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.destructive) { (action) in
            print(action);
            print("sku =\(sku) \n sign = \(sign) \n memId = \(memId) uuidString=\((UIDevice.current.identifierForVendor?.uuidString)!)")
            EncryptedAVPlaerVerifier.getFileUrl(appId: "0102", uuid: (UIDevice.current.identifierForVendor?.uuidString)!, sign: sign, sku:sku, actcode: "zyk", orderNo: "zyk", memId: memId, devId: "01",
                                                completed: { (isSuccess, downloadUrl, data) -> Void in
//                                                    print(isSuccess)
//                                                    print(downloadUrl)
//                                                    print(data)
                                                blockProperty("http://download.peeavp.com.cn/"+downloadUrl)
                                                    
            })
            

        };
        alertVC.addAction(cancelAction);
        alertVC.addAction(ensureAction);
        
        present(alertVC, animated: true) {
            print("提示语");
            
        };
        
    }
    
    
    

    
    
    
}




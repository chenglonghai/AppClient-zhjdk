//
//  PlayerAVHandle.swift
//  AppClient
//
//  Created by longhai on 2018/4/16.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

import UIKit
import EncryptedAVPlayerView

class PlayerAVHandle: NSObject {
    
    func hanlePlayerAV(sku:String, sign:String,memId:String) -> Void {
        
        EncryptedAVPlaerVerifier.getFileUrl(appId: "123", uuid: "uuid", sign: "db9c4159713dbf8dbda0149aef4b457", sku: "abc", actcode: "act", orderNo: "order", memId: "mem", devId: "dev",
                                            completed: { (isSuccess, downloadUrl, data) -> Void in
                                                print(isSuccess)
                                                print(downloadUrl)
                                                print(data)
        })
    }

}

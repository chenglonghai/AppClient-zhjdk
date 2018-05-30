//
//  PlayVideoViewController.swift
//  AppClient
//
//  Created by longhai on 2018/4/19.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

import UIKit
import EncryptedAVPlayerView

class PlayVideoNowViewController: UIViewController, EncryptedAVPlayerViewDelegate {

    var _playerView: EncryptedAVPlayerView? = nil
    var _show: Bool = true
    var _playerViewFrame: CGRect = CGRect.zero
    var _lastTime: Int64 = 0
    public var filePath:String = "";
    public var sku:String = "abc";
    
        var b: Bool = false
    func loadVideo() -> Void {
        let mediaType = "mp4"
//        var path = Bundle.main.path(forResource: "launch_video_180", ofType: mediaType)
//        if b {
//            path = Bundle.main.path(forResource: "launch_video_180", ofType: mediaType)
//            b = false
//
//            print("******load 400")
//        } else {
//            path = Bundle.main.path(forResource: "launch_video_180", ofType: mediaType)
//            b = true
//
////            print("******load 500")
//        }
        
         var path = String(filePath);
        
        print("xxxx\(String(describing: path)) +++\(sku)")
        
     
      
        _playerViewFrame = CGRect(x: self.view.frame.origin.x,
                                  y: self.view.frame.origin.y,
                                  width: self.view.frame.size.width,
                                  height: 200)
//        if _playerView != nil {
//            _playerView!.dispose()
//        }
        _playerView = EncryptedAVPlayerView(frame: _playerViewFrame)
        _playerView?.setMediaType(mediaType)
        _playerView?.backgroundColor = UIColor.yellow;
        self.view.addSubview(_playerView!)
        _playerView?._delegate = self
        _playerView?.play(path: path!, sku: self.sku)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        loadVideo();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // event is ready
    func avIsReady(sender: EncryptedAVPlayerView) {
        // to do
        print("app gets avisready")
        sender.play()
        sender.seek(to: _lastTime)
    }
    
    func avIsEnd(sender: EncryptedAVPlayerView) {
        // to do
        print("******av is end")
    }
    
    func returnClicked(sender: EncryptedAVPlayerView) {
        // to do
        print("returned")
    }
    
    func shareClicked(sender: EncryptedAVPlayerView) {
        // to do
        print("shared")
    }
    
    func fullscreenClicked(sender: EncryptedAVPlayerView) {
        // to do
        print("full-screened")
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    func normalscreenClicked(sender: EncryptedAVPlayerView) {
        print("normal-screened")
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

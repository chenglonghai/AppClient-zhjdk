//
//  PlayVideoView.swift
//  AppClient
//
//  Created by longhai on 2018/4/19.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

import UIKit
import EncryptedAVPlayerView
let   CLscreenWidth =  UIScreen.main.bounds.size.width
/**UIScreen height*/
let  CLscreenHeight = UIScreen.main.bounds.size.height
class PlayVideoView: UIView,EncryptedAVPlayerViewDelegate {
    //方向枚举
    enum Direction
    {
      case  Letf
      case Right
    }
    typealias ReturnClicked_b = ( _ isFullScreen: Bool) ->();
    public var _playerView: EncryptedAVPlayerView? = nil
    var _show: Bool = true
    var _playerViewFrame: CGRect = CGRect.zero
    var _lastTime: Int64 = 0
    var _isFullScreen = false;
    var _customFarme:CGRect?
    var _fatherView:UIView?
    var _isLandscape = false;

    public var filePath:String = "";
    public var sku:String = "abc";
    public var returnClicked_b:ReturnClicked_b?;



    
   
    var b: Bool = false
   public  func loadVideo() -> Void {
    
    self.backgroundColor = UIColor.black;
        let mediaType = "mp4"

        var path = String(filePath);
        
        print("xxxx\(String(describing: path)) +++\(sku)")
        
        
        
        _playerViewFrame = CGRect(x: self.frame.origin.x,
                                  y: self.frame.origin.y,
                                  width: self.frame.size.width,
                                  height: self.frame.size.height)
    

    if _playerView != nil {
        _playerView!.dispose()
    }
    _playerView = EncryptedAVPlayerView(frame:_playerViewFrame)

        _playerView?.setMediaType(mediaType)
        _playerView?.backgroundColor = UIColor.groupTableViewBackground;
        self.addSubview(_playerView!)
//          addConstraints();
        _playerView?._delegate = self
        _playerView?.play(path: path!, sku: self.sku)
        
    }
    public func destroyPlayView() -> Void {
        _playerView?.stop();
        _playerView = nil;
    }

    override func layoutSubviews() {
     
        super.layoutSubviews()
        
        let ori = UIDevice.current.orientation
        var  keyWindow :UIWindow = UIApplication.shared.keyWindow!;
        if ori.isLandscape {
            if _playerView != nil {
//                self._playerView!.removeFromSuperview()
                _isFullScreen = true;
                _playerView!.setFrame(newFrame: keyWindow.bounds)
                keyWindow.addSubview(_playerView!)
                print("___________________横屏");
            }
        } else {
            if _playerView != nil {
                 _isFullScreen = false;
                self._playerView!.removeFromSuperview()
                _playerView!.setFrame(newFrame: self.bounds)
                 self.addSubview(_playerView!)
                  print("___________________竖横");
            }
        }
    }
    // event is ready
    func avIsReady(sender: EncryptedAVPlayerView) {
        // to do
        
//        self.avIsReady_v!(sender)
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
        self.returnClicked_b!(_isFullScreen);
        if(_isFullScreen == true){
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            
            print("_________________normalscreenClicked")
            self.layoutSubviews()
        }
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
          print("_________________fullscreenClicked")
        
        _playerView?.removeFromSuperview();

    
    }
    
    func normalscreenClicked(sender: EncryptedAVPlayerView) {
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
         print("_________________normalscreenClicked")
        self.layoutSubviews()
//            _playerView?.removeFromSuperview();
    }

    
    
//mark - 全屏
    func fullScreenWithDirection(direction:Direction){
        
//        let value = UIInterfaceOrientation.landscapeLeft.rawValue
//         UIDevice.current.setValue(value, forKey: "orientation")
//        //记录播放器父类
//        _fatherView = self.superview;
//    //记录原始大小
//    _customFarme = self.frame;
//    _isFullScreen = true ;
////    [self setStatusBarHidden:YES];
//    //添加到Window上
//        var  keyWindow :UIWindow = UIApplication.shared.keyWindow!;
//        keyWindow.addSubview(self);
//        UIView.animate(withDuration: 0.25, animations: {
////                self.transform = CGAffineTransformMakeRotation(M_PI / 2);
//            self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2));
//
//        })
//        self.frame = CGRect(x:0,y:0,width:CLscreenWidth, height:CLscreenHeight);
//        self.setNeedsLayout();
//        self.layoutIfNeeded();
//        _playerView?.setNeedsLayout();
//        _playerView?.layoutIfNeeded();
        
    }
//    #pragma mark - 原始大小
   func originalscreen()->Void{
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    let value = UIInterfaceOrientation.portrait.rawValue
    UIDevice.current.setValue(value, forKey: "orientation")
//    _isFullScreen = NO;
//    [self setStatusBarHidden:NO];
    _isFullScreen = false;
    
    UIView.animate(withDuration: 0.25, animations: {
        //                self.transform = CGAffineTransformMakeRotation(M_PI / 2);
        self.transform = CGAffineTransform(rotationAngle: 0);
    })
    self.frame = _customFarme!;
    _playerView?.frame = self.frame;
    //还原到原有父类上
    _fatherView?.addSubview(self);
    
 
//   self.maskView.fullButton.selected = NO;
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

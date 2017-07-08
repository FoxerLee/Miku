//
//  ViewController.swift
//  ipad
//
//  Created by 李源 on 08/07/2017.
//  Copyright © 2017 李源. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import Alamofire
import AVOSCloud
import BMPlayer

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var player: BMPlayer!
    //视频播放
    var playerLayer:AVPlayerLayer?
    //定时器
    var timer:Timer!
    
    //语音合成相关
    let synth = AVSpeechSynthesizer() //TTS对象
    let audioSession = AVAudioSession.sharedInstance() //语音引擎
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
    
        synth.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 5, target:self,selector:#selector(ViewController.tickDown), userInfo:nil, repeats:true)
        tickDown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tickDown()
    {
        let quary = AVQuery(className: "message")
        var objects = quary.findObjects()
        let cloudMessage =  objects?.popLast() as! AVObject
        
        let message = cloudMessage.object(forKey: "message") as! String
        var flag = cloudMessage.object(forKey: "flag") as! String
        
        
        if (flag == "false") {
            Alamofire.request(URL(string: api_url)!, method: .get, parameters: ["key":api_key,"info":message,"userid":userId]).responseJSON(options: JSONSerialization.ReadingOptions.mutableContainers) { response in
               
                if response.error == nil {
                    let result = response.result.value as? [String: Any]
                    
                    if let text = result?["text"] as? String{
                        print(text)
                        if self.synth.isSpeaking {
                            
                            self.stopSpeech()
                        }
                        else {
                            //根据回应播放语音
                            self.speechMessage(message: text)
                            if (text == "帮你开灯哦") {
                                cloudMessage.setObject(1, forKey: "flag2")
                                cloudMessage.saveEventually()
                                //开灯
                                let filePath = Bundle.main.path(forResource: "开关灯", ofType: "mp4")
                                let url = URL(fileURLWithPath: filePath!).absoluteString
                                
                                self.player.backBlock = { [unowned self] (isFullScreen) in
                                    if isFullScreen == true {
                                        return
                                    }
                                    let _ = self.navigationController?.popViewController(animated: true)
                                }
                                
                                let asset = BMPlayerResource(url: URL(string: url)!,
                                                             name: "",
                                                             cover: nil,
                                                             subtitle: nil)
                                self.player.setVideo(resource: asset)
                            }
                            else if (text == "帮你关灯哦") {
                                cloudMessage.setObject(2, forKey: "flag2")
                                cloudMessage.saveEventually()
                                //关灯
                                let filePath = Bundle.main.path(forResource: "开关灯", ofType: "mp4")
                                let url = URL(fileURLWithPath: filePath!).absoluteString
                                
                                self.player.backBlock = { [unowned self] (isFullScreen) in
                                    if isFullScreen == true {
                                        return
                                    }
                                    let _ = self.navigationController?.popViewController(animated: true)
                                }
                                
                                let asset = BMPlayerResource(url: URL(string: url)!,
                                                             name: "",
                                                             cover: nil,
                                                             subtitle: nil)
                                self.player.setVideo(resource: asset)
                            }
                            else if (text == "你也好呀") {
                                let filePath = Bundle.main.path(forResource: "挥手", ofType: "mp4")
                                let url = URL(fileURLWithPath: filePath!).absoluteString
                                
                                self.player.backBlock = { [unowned self] (isFullScreen) in
                                    if isFullScreen == true {
                                        return
                                    }
                                    let _ = self.navigationController?.popViewController(animated: true)
                                }
                                
                                let asset = BMPlayerResource(url: URL(string: url)!,
                                                             name: "",
                                                             cover: nil,
                                                             subtitle: nil)
                                self.player.setVideo(resource: asset)
                            }
                            else {
                                let randomResult = self.getRandomInt()
                                if randomResult == 0 || randomResult == 1 {
                                    let filePath = Bundle.main.path(forResource: "挥手", ofType: "mp4")
                                    let url = URL(fileURLWithPath: filePath!).absoluteString
                                    
                                    self.player.backBlock = { [unowned self] (isFullScreen) in
                                        if isFullScreen == true {
                                            return
                                        }
                                        let _ = self.navigationController?.popViewController(animated: true)
                                    }
                                    
                                    let asset = BMPlayerResource(url: URL(string: url)!,
                                                                 name: "",
                                                                 cover: nil,
                                                                 subtitle: nil)
                                    self.player.setVideo(resource: asset)
                                }
                                else {
                                    let filePath = Bundle.main.path(forResource: "说话", ofType: "mp4")
                                    let url = URL(fileURLWithPath: filePath!).absoluteString
                                    
                                    self.player.backBlock = { [unowned self] (isFullScreen) in
                                        if isFullScreen == true {
                                            return
                                        }
                                        let _ = self.navigationController?.popViewController(animated: true)
                                    }
                                    
                                    let asset = BMPlayerResource(url: URL(string: url)!,
                                                                 name: "",
                                                                 cover: nil,
                                                                 subtitle: nil)
                                    self.player.setVideo(resource: asset)
                                }
                                
                            }
                            
                        }
                    }
                }
            }
            
            flag = "true"
            cloudMessage.setObject(flag, forKey: "flag")
            cloudMessage.saveEventually()
            print("miaomiao")
        }
        else {
            let randomResult = getRandomInt()
            if randomResult == 0 {
                
            }
            else if randomResult == 1 {
                let filePath = Bundle.main.path(forResource: "蹦蹦跳跳", ofType: "mp4")
                let url = URL(fileURLWithPath: filePath!).absoluteString
                
                self.player.backBlock = { [unowned self] (isFullScreen) in
                    if isFullScreen == true {
                        return
                    }
                    let _ = self.navigationController?.popViewController(animated: true)
                }
                
                let asset = BMPlayerResource(url: URL(string: url)!,
                                             name: "",
                                             cover: nil,
                                             subtitle: nil)
                self.player.setVideo(resource: asset)
            }
            else {
                let filePath = Bundle.main.path(forResource: "走路", ofType: "mp4")
                let url = URL(fileURLWithPath: filePath!).absoluteString
                
                self.player.backBlock = { [unowned self] (isFullScreen) in
                    if isFullScreen == true {
                        return
                    }
                    let _ = self.navigationController?.popViewController(animated: true)
                }
                
                let asset = BMPlayerResource(url: URL(string: url)!,
                                             name: "",
                                             cover: nil,
                                             subtitle: nil)
                self.player.setVideo(resource: asset)
            }
        }
        
    }
    
    
    //TTS部分
    func speechMessage (message: String) {
        if (!message.isEmpty) {
            do {
                // 设置语音环境，保证能朗读出声音（特别是刚做过语音识别，这句话必加，不然没声音）
                try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            }
            catch let error as NSError {
                print(error.code)
            }
            
            //需要转的文本
            let utterance = AVSpeechUtterance.init(string: message)
            //设置语言，这里是中文
            utterance.voice = AVSpeechSynthesisVoice.init(language: "zh_CN")
            //设置声音大小
            utterance.volume = 1
            //设置音频
            utterance.pitchMultiplier = 0.9
            
            
            //开始朗读
            synth.speak(utterance)
        }
    }

    func stopSpeech () {
        // 立即中断语音
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
    }

    private func getRandomInt() -> Int {
        var randomInt = Int(arc4random()) % 101
        var randomResult = 0
        if randomInt < 28 {
            randomResult = 0
        }
        else if randomInt >= 28 && randomInt < 59 {
            randomResult = 1
        }
        else {
            randomInt = 2
        }
        return randomResult
    }

}


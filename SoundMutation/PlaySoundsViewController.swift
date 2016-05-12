//
//  PlaySoundsViewController.swift
//  SoundMutation
//
//  Created by Alyonka on 2/24/16.
//  Copyright © 2016 AlyonaPianykh. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    
    var player: AVAudioPlayer!
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int {
        case Slow = 0, Fast, Squirrel, Vader, Parrot, Reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func playSoundForButton(sender: UIButton) {
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate:0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Squirrel:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Parrot:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        configureUI(.Playing)
    }
    
    func playAudio(speed: Float) {
        if let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            let audioFileUrl = NSURL.fileURLWithPath(path)
            do {
                player = try AVAudioPlayer(contentsOfURL: audioFileUrl);
                player.enableRate = true
                player.rate = speed
                player.play()
            } catch {
                print("audio playing error")
            }
        } else {
            print("audio file is no found")
        }
    }
    
    @IBAction func stopPlaying(sender: AnyObject) {
        stopAudio()
    }
    
    
    
    
}

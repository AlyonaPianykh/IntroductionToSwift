//
//  ViewController.swift
//  SoundMutation
//
//  Created by Alyonka on 2/22/16.
//  Copyright © 2016 AlyonaPianykh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    var audioRecorder:AVAudioRecorder!
    
   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.stopButton.enabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recordAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        
        let recordingName = "recordedVoice.wav";
        let pathArray = [dirPath, recordingName];
        let filePath = NSURL.fileURLWithPathComponents(pathArray);
        
        print(filePath);
        
        let session = AVAudioSession.sharedInstance();
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord);
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:]);
        audioRecorder.delegate = self;
        audioRecorder.meteringEnabled = true;
        audioRecorder.prepareToRecord();
        audioRecorder.record();
    }
    
   @IBAction func recordAudio(sender: AnyObject) {
        print("recording");
    self.recordingInProgress.hidden = false;
    
    self.stopButton.enabled = true;
    self.recordAudio();
    
    }
 
    @IBAction func stopRecording(sender: AnyObject) {
        self.recordingInProgress.hidden = true;
        self.stopButton.enabled = false;
        
        audioRecorder.stop();
        let audioSession = AVAudioSession.sharedInstance();
        try! audioSession.setActive(false);
        
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("end recording");
        if (flag) {
              self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url);
        } else {
            print("Saving record failed");
        }
      
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController;
            let recordedAudioURL = sender as! NSURL;
            playSoundsVC.recordedAudioURL = recordedAudioURL;
        }
    }
}


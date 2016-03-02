//
//  ViewController.swift
//  VoiceTweak
//
//  Created by Bruce Burgess on 3/1/16.
//  Copyright © 2016 Bruce Burgess. All rights reserved.
//

import UIKit
import AVFoundation //import Audio Video Foundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var playButton: UIButton! //Connect play button
    @IBOutlet weak var loopSeitch: UISwitch! //Connect the loop switch
    @IBOutlet weak var speedLabel: UILabel! //Connect the speed label
    
    var audioRecorder : AVAudioRecorder? //Create an audio recorder
    var audioPlayer : AVAudioPlayer? //Create an audio property
    var rate : Float = 1.0 //set playback rate
    var audioURL : NSURL? //set up a audioURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpAudioRecorder()
    }
    
    //Set up an audio recorder
    func setUpAudioRecorder(){
        do{
            //Setting up where to save the file
            let basePath : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
            let pathComponents = [basePath, "theAudio.m4a"]
            self.audioURL = NSURL.fileURLWithPathComponents(pathComponents)
            
            //set up Audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)//sets up bigger speaker
            try session.setActive(true)
            
            //set up recording audio settings
            var recordSettings = [String : AnyObject]()
            recordSettings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            recordSettings[AVSampleRateKey] = 44100.0
            recordSettings[AVNumberOfChannelsKey] = 2
            
            //Get ready to record
            self.audioRecorder = try AVAudioRecorder(URL: self.audioURL!, settings: recordSettings)
            self.audioRecorder!.meteringEnabled = true
            self.audioRecorder!.prepareToRecord()
        } catch {}
    }
    
    //Record button tapped
    @IBAction func recordTapped(button: UIButton) {
        if self.audioRecorder!.recording{
            self.audioRecorder!.stop()
            button.setTitle("RECORD", forState: UIControlState.Normal)
        } else {
            do{
                try AVAudioSession.sharedInstance().setActive(true)
                self.audioRecorder!.record()
                button.setTitle("STOP", forState: UIControlState.Normal)
            }catch {}
        }
    }
    
    //When the play button is pressed
    @IBAction func playTapped(sender: UIButton) {
        
        if self.audioPlayer == nil {
           setUpAndPlay()
        } else {
            if self.audioPlayer!.play(){
                //print("is Playing")
                self.audioPlayer!.stop()
                self.playButton.setTitle("PLAY", forState: UIControlState.Normal)
                self.audioPlayer = nil
            } else {
                //print("Play again")
                setUpAndPlay()
            }
        }
        
    }
    
    //Set up audio and play it
    func setUpAndPlay()
    {
        do{
//            //Set up a path to the audio file
//            let path = NSBundle.mainBundle().pathForResource("ExampleAudio", ofType: "m4a")
//            //set up url
//            let url = NSURL(fileURLWithPath: path!)
//            //try to play the sound
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: self.audioURL!)
            //change the rate
            self.audioPlayer!.enableRate = true
            self.audioPlayer!.rate = rate
            //add loops
            if self.loopSeitch.on {
                self.audioPlayer!.numberOfLoops = -1
            }
            self.audioPlayer!.delegate = self
            self.audioPlayer!.play()
            self.playButton.setTitle("STOP", forState: UIControlState.Normal)
        } catch {
            
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        self.playButton.setTitle("PLAY", forState: UIControlState.Normal)
        self.audioPlayer = nil
    }
    
    //Connect the slider with code
    @IBAction func sliderMoved(slider: UISlider) {
        self.rate = 0.2
        self.rate += (slider.value * 3.8)
        
        let prettyRate = String(format: "%.1f", self.rate)
        self.speedLabel.text = "Speed x\(prettyRate)"
        
        if self.audioPlayer != nil {
            //Automatically update playback rate
            self.audioPlayer!.rate = self.rate
        }
        
    }
    
}


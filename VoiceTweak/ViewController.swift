//
//  ViewController.swift
//  VoiceTweak
//
//  Created by Bruce Burgess on 3/1/16.
//  Copyright © 2016 Bruce Burgess. All rights reserved.
//

import UIKit
import AVFoundation //import Audio Video Foundation

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer? //Create an audio property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //When the play button is pressed
    @IBAction func playTapped(sender: UIButton) {
        do{
            //Set up a path to the audio file
            let path = NSBundle.mainBundle().pathForResource("ExampleAudio", ofType: "m4a")
            //set up url
            let url = NSURL(fileURLWithPath: path!)
            //try to play the sound
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            
        }
    }
    
    
}


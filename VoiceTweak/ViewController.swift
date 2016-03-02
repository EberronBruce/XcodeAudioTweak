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
    
    @IBOutlet weak var speedLabel: UILabel! //Connect the speed label
    
    var audioPlayer : AVAudioPlayer? //Create an audio property
    var rate : Float = 1.0 //set playback rate
    
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
            //change the rate
            self.audioPlayer!.enableRate = true
            self.audioPlayer!.rate = rate
            self.audioPlayer!.play()
        } catch {
            
        }
    }
    
    //Connect the slider with code
    @IBAction func sliderMoved(slider: UISlider) {
        self.rate = 0.2
        self.rate += (slider.value * 3.8)
        
        //Automatically update playback rate
        self.audioPlayer!.rate = self.rate
        
        let prettyRate = String(format: "%.1f", self.rate)
        self.speedLabel.text = "Speed x\(prettyRate)"
        
    }
    
}


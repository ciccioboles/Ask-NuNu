//
//  ViewController.swift
//  AskNuNu
//
//  Created by David Boles on 12/13/18.
//  Copyright © 2018 David Boles. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, AVAudioPlayerDelegate   {
    
    var audioPlayer : AVAudioPlayer?
    
    @IBOutlet weak var nuHead: UIImageView!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var pawButton: UIButton!
    
    var answers = [
        "I don't know my friend",
        "absolutely",
        "ask again later",
        "yeah right",
        "take a hike",
        "sure",
        "I guess so",
        "why not",
        "totally",
        "no way",
        "for sure",
        "YES",
        "NO",
        "OK",
        "absolutely not",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headBounce()
        playSound()
    }
    
    @IBAction func getAnswerTapped(sender: AnyObject) {
        
        nuHead.pulsate()
        answerText.text = getAnswer()
        delaySond()
        
    }
    
    func playSound() {
        
        let soundURL = Bundle.main.url(forResource: "bark", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer?.play()
    }
    
    // picks a random answer from array
    func getAnswer() -> String {
        
        let random = Int(arc4random_uniform(UInt32(answers.count)))
        let result = answers[random]
        textFade()
        return result
    }
    
    // Shake phone to activate
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        getAnswerTapped(sender: UIEvent.self)
    }
    
    // Prevents continious sound clicking of button
    func delaySond(){
        
        if audioPlayer!.isPlaying{
            audioPlayer!.stop()
        }
        audioPlayer!.play()
    }
    
    // Transition for text fade in
    func textFade() {
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1.1
        transition.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    // Bounces the head image in upon first loading

    func headBounce() {

        nuHead.center.x = self.view.frame.width + 10
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 15.0, options: [], animations: {
            self.nuHead.center.x = self.view.frame.width / 2
        }, completion: nil)
    }
    
    
}

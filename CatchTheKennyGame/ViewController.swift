//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Alper Uyar on 20.09.2022.
//

import UIKit

class ViewController: UIViewController {

    //Variables
    var score=0
    var highScore=0
    var timer=Timer()
    var hideTimer=Timer()
    var counter=0
    var kennyArray=[UIImageView()]
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter=15
        kennyArray=[kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        timeLabel.text="Time: \(counter)"
        scoreLabel.text="Score: \(score)"
        
        
        let storedScore=UserDefaults.standard.object(forKey: "highScore")
        
        if storedScore == nil{
            highScore=0
            highscoreLabel.text="Highscore: \(highScore)"
        }
        if let newScore = storedScore as? Int{
            highScore=newScore
            highscoreLabel.text="Highscore: \(highScore)"
        }
        //Images
        kenny1.isUserInteractionEnabled=true
        kenny2.isUserInteractionEnabled=true
        kenny3.isUserInteractionEnabled=true
        kenny4.isUserInteractionEnabled=true
        kenny5.isUserInteractionEnabled=true
        kenny6.isUserInteractionEnabled=true
        kenny7.isUserInteractionEnabled=true
        kenny8.isUserInteractionEnabled=true
        kenny9.isUserInteractionEnabled=true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer=Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }

    @objc func increaseScore( ){
        score+=1
        scoreLabel.text="Score: \(score)"
    }
    @objc func countdown(){
        counter-=1
        timeLabel.text="Time: \(self.counter)"
        if counter==0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden=true
            }
            
            //Highscore Update
            if self.score>self.highScore {
                self.highScore=self.score
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
                highscoreLabel.text="Highscore: \(self.highScore)"
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Time Is Up ?", message: "", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let repeatButton = UIAlertAction(title: "Repeat", style: UIAlertAction.Style.default) { UIAlertAction in
                //repeat
                self.score=0
                self.counter=15
                self.scoreLabel.text="Score: \(self.score)"
                self.timeLabel.text="Time: \(self.counter)"
                
                self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer=Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
                
            }
            alert.addAction(okButton)
            alert.addAction(repeatButton)
            self.present(alert, animated: true)
        }
    }
    @objc func hideKenny( ){
        for kenny in kennyArray{
            kenny.isHidden=true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden=false
        
        if random == random {
            let random2=Int(arc4random_uniform(UInt32(kennyArray.count-1)))
            kennyArray[random].isHidden=true
            kennyArray[random2].isHidden=false

        }
    }
}


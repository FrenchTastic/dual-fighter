//
//  ViewController.swift
//  dual-fighter
//
//  Created by Romain Pardon on 23/07/2016.
//  Copyright © 2016 SlasherApp. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var soundPlayer: AVAudioPlayer!
    var player1Choice: String!
    var player2Choice: String!
    var player1: Character!
    var player2:  Character!
    
    @IBOutlet weak var welcomeTextLbl: UIImageView!
    @IBOutlet weak var choosePlayerLbl: UILabel!
    @IBOutlet weak var goodGuyImg: UIImageView!
    @IBOutlet weak var badGuyImg: UIImageView!
    @IBOutlet weak var selectBadBtn: UIButton!
    @IBOutlet weak var selectGoodBtn: UIButton!
    @IBOutlet weak var panel: UIImageView!
    @IBOutlet weak var player1Img: UIImageView!
    @IBOutlet weak var player2Img: UIImageView!
    @IBOutlet weak var player1SelectedImg: UIImageView!
    @IBOutlet weak var player2SelectedImg: UIImageView!
    @IBOutlet weak var player1AtkBtn: UIButton!
    @IBOutlet weak var player2AtkBtn: UIButton!
    @IBOutlet weak var player1HpLbl: UILabel!
    @IBOutlet weak var player2HpLbl: UILabel!
    @IBOutlet weak var wonLbl: UIImageView!
    @IBOutlet weak var restartBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choosePlayerLbl.text = "Player 1: Choose Your Fighter !!"
        playSound(&soundPlayer,soundName: "intro", type: "mp3", nbLoop: -1)
    }

    @IBAction func attackPlayer1(sender: AnyObject) {
        let atkPower = player2.randomizeAttackPower()
        playSound(&audioPlayer,soundName: "sword",type: "mp3", nbLoop: 0)
        player1.beAttacked(atkPower)
        if !player1.isAlive()
        {
            if player1.name == "Enemy" {
                playSound(&audioPlayer,soundName: "goblindeath",type: "wav", nbLoop: 0)
            } else {
                playSound(&audioPlayer,soundName: "death",type: "wav", nbLoop: 0)
            }
            player1AtkBtn.hidden = true
            player2AtkBtn.hidden = true
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.endGame(_:)), userInfo: "player2", repeats: false)
        } else {
            player1HpLbl.text = "\(player1.hp) HP"
        }
    }
    
    @IBAction func attackPlayer2(sender: AnyObject) {
        let atkPower = player1.randomizeAttackPower()
        playSound(&audioPlayer,soundName: "sword",type: "mp3", nbLoop: 0)
        player2.beAttacked(atkPower)
        if !player2.isAlive()
        {
            if player2.name == "Enemy" {
                playSound(&audioPlayer,soundName: "goblindeath",type: "wav", nbLoop: 0)
            } else {
                playSound(&audioPlayer,soundName: "death",type: "wav", nbLoop: 0)
            }
            player1AtkBtn.hidden = true
            player2AtkBtn.hidden = true
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.endGame(_:)), userInfo: "player1", repeats: false)
        } else {
            player2HpLbl.text = "\(player2.hp) HP"
        }
    }

    @IBAction func selectGoodGuy(sender: AnyObject) {
        selectPlayer("player")
    }
    
    @IBAction func selectBadGuy(sender: AnyObject) {
        selectPlayer("enemy")
    }
    
    func selectPlayer(player: String) {
        let image = UIImage(named: player)
        if player1Choice == nil {
            choosePlayerLbl.text = "Player 2: Choose Your Player !!"
            player1Choice = player
            if player1Choice == "player" {
                player1 = Player()
                player1Img.image? = UIImage(CGImage: image!.CGImage!, scale: image!.scale, orientation: UIImageOrientation.UpMirrored)
            } else {
                player1 = Enemy()
                player1Img.image? = UIImage(CGImage: image!.CGImage!, scale: image!.scale, orientation: UIImageOrientation.Up)
            }
            player1HpLbl.text = "\(player1.hp) HP"
            player1HpLbl.hidden = false
        } else {
            if player == "enemy" {
                player2Img.image? = UIImage(CGImage: image!.CGImage!, scale: image!.scale, orientation: UIImageOrientation.UpMirrored)
                player2 = Enemy()
            }
            else {
                player2 = Player()
                player2Img.image? = UIImage(CGImage: image!.CGImage!, scale: image!.scale, orientation: UIImageOrientation.Up)
            }
            player2HpLbl.text = "\(player2.hp) HP"
            player2HpLbl.hidden = false
            player2Choice = player
            panel.hidden = true
            welcomeTextLbl.hidden = true
            choosePlayerLbl.hidden = true
            badGuyImg.hidden = true
            goodGuyImg.hidden = true
            selectBadBtn.hidden = true
            selectGoodBtn.hidden = true
            player1SelectedImg.hidden = false
            player2SelectedImg.hidden = false
            player1AtkBtn.hidden = false
            player2AtkBtn.hidden = false
        }
    }
    
    func endGame(timer:NSTimer) {
        let playerWon = "\(timer.userInfo!)"
        wonLbl.image = UIImage(named: "\(playerWon)Won")
        wonLbl.hidden = false
        player1AtkBtn.hidden = true
        restartBtn.hidden = false
        player1SelectedImg.hidden = true
        player2SelectedImg.hidden = true
        player1HpLbl.hidden = true
        player2HpLbl.hidden = true
        player1Choice = nil
        player1 = nil
        player2 = nil
    }
    
    @IBAction func restartGame(sender: AnyObject) {
        restartBtn.hidden = true
        wonLbl.hidden = true
        panel.hidden = false
        welcomeTextLbl.hidden = false
        choosePlayerLbl.text = "Player 1: Choose Your Fighter !!"
        choosePlayerLbl.hidden = false
        badGuyImg.hidden = false
        goodGuyImg.hidden = false
        selectBadBtn.hidden = false
        selectGoodBtn.hidden = false
    }
    
    func strangeSound(){
        playSound(&audioPlayer, soundName: "goblindeath", type: "wav", nbLoop: 0)
    }
    
    func playSound(inout player :AVAudioPlayer!, soundName: String, type: String, nbLoop: Int)
    {
        let path = NSBundle.mainBundle().pathForResource(soundName, ofType: type)
        let sound = NSURL(fileURLWithPath: path!)
        do{
            player = try AVAudioPlayer(contentsOfURL:sound)
            player.prepareToPlay()
            player.numberOfLoops = nbLoop
            player.play()
        }catch {
            print("Error getting the audio file")
        }
    }
}


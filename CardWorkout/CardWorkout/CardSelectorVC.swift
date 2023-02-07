//
//  CardSelectorVC.swift
//  CardWorkout
//
//  Created by Shriram Ghadge on 30/01/23.
//

import UIKit

class CardSelectorVC: UIViewController {
    
    var timer: Timer!

    @IBOutlet var cardImageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    var cards: [UIImage] = Deck.getDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Logic Components
        setTimer()
        
        // UI Components
        for button in buttons {
            button.layer.cornerRadius = 8
        }

        
    }
    
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showRandomCard), userInfo: nil, repeats: true)
    }
    
    // invalidate timer once view gets disappeared (Screen change)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @objc func showRandomCard() {
        cardImageView.image = cards.randomElement() ?? UIImage(named: "AS")
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        timer.invalidate()
    }
    

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        setTimer()
    }
}

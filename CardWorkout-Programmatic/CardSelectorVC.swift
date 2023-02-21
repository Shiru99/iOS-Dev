//
//  CardSelectorVC.swift
//  CardWorkout-Programmatic
//
//  Created by Shriram Ghadge on 08/02/23.
//

import UIKit

class CardSelectorVC: UIViewController {
    
    let cardImageView = UIImageView()
    let stopButton = CWButton(color: .systemRed, title: "Stop!", iconName: "stop.circle")
    let resetButton = CWButton(color: .systemGreen, title: "Reset", iconName: "arrow.clockwise.circle")
    let rulesButton = CWButton(color: .systemBlue, title: "Rules", iconName: "list.bullet")
    
    var cards: [UIImage] = Deck.getDeck()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTimer()
        
        view.backgroundColor = .systemBackground
        ConfigureUI()
         
    }
    
    //    --------------------- Logic
    
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showRandomCard), userInfo: nil, repeats: true)
    }
    
    @objc func showRandomCard() {
        cardImageView.image = cards.randomElement() ?? UIImage(named: "AS")
    }
    
    
    @objc func stopTimer() {
        timer.invalidate()
    }
    
    @objc func resetTimer() {
        stopTimer()
        setTimer()
    }
    
    
    // invalidate timer once view gets disappeared (Screen change)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    
    //    --------------------- UI
    
    func ConfigureUI() {
        ConfigureCardImageView()
        ConfigureStopButton()
        ConfigureResetButton()
        ConfigureRulesButton()
        
    }
    
    func ConfigureCardImageView()   {
        view.addSubview(cardImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.image = UIImage(named: "AS")
        
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: 250),
            cardImageView.heightAnchor.constraint(equalToConstant: 350),
            cardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75)
        ])
    }
    
    func ConfigureStopButton() {
        view.addSubview(stopButton)
        
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stopButton.widthAnchor.constraint(equalToConstant: 260),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 30)
        ])
    }
    
    func ConfigureResetButton() {
        view.addSubview(resetButton)
        
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)

        NSLayoutConstraint.activate([
            resetButton.widthAnchor.constraint(equalToConstant: 115),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.leftAnchor.constraint(equalTo: stopButton.leftAnchor),
            resetButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 30)
        ])
    }

    func ConfigureRulesButton() {
        view.addSubview(rulesButton)
        
        rulesButton.addTarget(self, action: #selector(showRules), for: .touchUpInside)

        NSLayoutConstraint.activate([
            rulesButton.widthAnchor.constraint(equalToConstant: 115),
            rulesButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.rightAnchor.constraint(equalTo: stopButton.rightAnchor),
            rulesButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 30)
        ])
    }
    
    @objc func showRules(){
        present(RulesVC(), animated: true)
    }

}

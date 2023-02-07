//
//  Deck.swift
//  CardWorkout
//
//  Created by Shriram Ghadge on 07/02/23.
//

import UIKit

struct Deck {
    
    static var allValues: [UIImage] = [
        
    ]
    
    static func getDeck() -> [UIImage]{
        
        var suits: [String] = ["S","C","D","H"]
        var faceCards: [String] = ["K","Q","J","A"]
        
        for num: Int in 2...10 {
            for suit in suits{
                Deck.allValues.append(UIImage(named: "\(num)\(suit)")!)
            }
        }
        

        for faceCard: String in faceCards {
            for suit in suits{
                Deck.allValues.append(UIImage(named: "\(faceCard)\(suit)")!)
            }
        }
         
        return Deck.allValues
    }
}

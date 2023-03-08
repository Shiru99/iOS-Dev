//
//  Alert.swift
//  Tic-Tac-Toe
//
//  Created by Shriram Ghadge on 01/03/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let buttonTitle: Text
}

struct AlertContext {
    static let humanWin: AlertItem = AlertItem(title: Text("You Win!"), message: Text("You are the best!"), buttonTitle: Text("Hell Yeah!"))

    static let computerWin: AlertItem = AlertItem(title: Text("You Lose!"), message: Text("Better luck next time!"), buttonTitle: Text("Rematch"))
    
    static let draw: AlertItem = AlertItem(title: Text("Draw!"), message: Text("How about a rematch?"), buttonTitle: Text("Rematch"))
}

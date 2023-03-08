//
//  GameViewModel.swift
//  Tic-Tac-Toe
//
//  Created by Shriram Ghadge on 08/03/23.
//

import SwiftUI

final class GameViewModel: ObservableObject{
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isBoardDisabled: Bool = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for position: Int){
        if isCircleOccupied(in: moves, forIndex: position) { return }
        
        // Human Move
        moves[position] = Move(player: .human , boardIndex: position)
        
        isBoardDisabled = true
        
        
        // Verifying Win/Draw Conditions
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves){
            alertItem = AlertContext.draw
            return
        }
        
        // Computer Move
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
            
            let computerMovePosition = decideComputerMove(moves: moves)
            
            moves[computerMovePosition] = Move(player: .computer , boardIndex: computerMovePosition)
            
            isBoardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                isBoardDisabled = true
                return
            }
            
        }
    }
    
    func isCircleOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func decideComputerMove(moves: [Move?]) -> Int{
        
        /// 1. Check for win condition
        let winPatterns: Set<Set<Int>> = [
            [0,1,2], [3,4,5], [6,7,8], // Horizontal
            [0,3,6], [1,4,7], [2,5,8], // Vertical
            [0,4,8], [2,4,6]           // Diagonal
        ]
        
        let computerMoves: [Move] = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions: Set<Int> = Set(computerMoves.map { $0.boardIndex })
        
        for pattern: Set<Int> in winPatterns {
            let winPosition = pattern.subtracting(computerPositions)
            if winPosition.count == 1 {
                let isAvailable = !isCircleOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first! }
            }
        }
        
        /// 2. Check for block condition
        let humanMoves: [Move] = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPositions: Set<Int> = Set(humanMoves.map { $0.boardIndex })
        
        for pattern: Set<Int> in winPatterns {
            let blockPosition = pattern.subtracting(humanPositions)
            if blockPosition.count == 1 {
                let isAvailable = !isCircleOccupied(in: moves, forIndex: blockPosition.first!)
                if isAvailable { return blockPosition.first! }
            }
        }
        
        /// 3. Check for center position
        let centerPosition = 4
        if !isCircleOccupied(in: moves, forIndex: centerPosition) {
            return centerPosition
        }
        
        /// 4. Check for corner position
        let cornerPositions: Set<Int> = [0,2,6,8]
        let availableCornerPositions = cornerPositions.subtracting(computerPositions).subtracting(humanPositions)
        if availableCornerPositions.count > 0 {
            return availableCornerPositions.randomElement()!
        }
        
        /// 5. Check for any position
        var movePosition = Int.random(in: 0..<9)
        
        while isCircleOccupied(in: moves, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool{
        
        let winPatterns: Set<Set<Int>> = [
            [0,1,2], [3,4,5], [6,7,8], // Horizontal
            [0,3,6], [1,4,7], [2,5,8], // Vertical
            [0,4,8], [2,4,6]           // Diagonal
        ]
        
        let playerMoves: [Move] = moves.compactMap { $0 }.filter { $0.player == player }
        
        
        let playerPositions: Set<Int> = Set(playerMoves.map { $0.boardIndex })
        
        for pattern: Set<Int> in winPatterns where pattern.isSubset(of: playerPositions){
            return true
        }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool{
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame(){
        moves = Array(repeating: nil, count: 9)
        isBoardDisabled = false
    }
}

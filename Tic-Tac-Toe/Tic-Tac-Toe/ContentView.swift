//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Shriram Ghadge on 28/02/23.
//

import SwiftUI


struct ContentView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isBoardDisabled: Bool = false
    @State private var alertItem: AlertItem?
    
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
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack{
                Spacer()
                Spacer()
                
                LazyVGrid(columns: columns){
                    ForEach(0..<9){ i in
                        
                        ZStack{
                            Circle()
                                .foregroundColor(.red)
                                .opacity(0.7)
                            //  .frame(width: geometry.size.width/3, height: geometry.size.width/3)
                            
                            Image(systemName: moves[i]?.indicator ?? "")   // hare vs tortoise
                                .resizable()
                                .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                            //                                .foregroundColor( moves[i]?.player == .human ? .white : .black)
                                .foregroundColor( moves[i]?.colorIndicator ?? .white)
                        }.onTapGesture {
                            
                            if isCircleOccupied(in: moves, forIndex: i) { return }
                            
                            // Human Move
                            moves[i] = Move(player: .human , boardIndex: i)
                            
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                
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
                    }
                }.disabled(isBoardDisabled)
                
                Spacer()
                
                Button {
                    resetGame()
                } label: {
                    Text("Reset !")
                        .foregroundColor(Color.white)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(width: 180, height: 60)
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                    
                }
                
                Spacer()
            }
            .padding()
            .alert(item: $alertItem, content: { alertItem in
                
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {resetGame()}))
                
            })
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum Player{
    case human, computer
}

struct Move{
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "tortoise" : "hare"
    }
    
    var colorIndicator: Color {
        return player == .human ? Color.white: Color.black
    }
}

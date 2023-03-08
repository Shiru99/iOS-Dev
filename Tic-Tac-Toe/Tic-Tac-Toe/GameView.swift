//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Shriram Ghadge on 28/02/23.
//

import SwiftUI


struct GameView: View {
    
    @StateObject private var viewModel: GameViewModel = GameViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack{
                Spacer()
                Spacer()
                
                LazyVGrid(columns: viewModel.columns){
                    ForEach(0..<9){ i in
                        ZStack{
                            GameCircleView()
                            PlayerMoveIndicatorView(moves: viewModel.moves, i: i, geometry: geometry)
                        }.onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }.disabled(viewModel.isBoardDisabled)
                
                Spacer()
                ResetButtonView(viewModel: viewModel)
                Spacer()
            }
            .padding()
            .alert(item: $viewModel.alertItem, content: { alertItem in
                
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {viewModel.resetGame()}))
                
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
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

struct ResetButtonView: View {
    
    var viewModel: GameViewModel
    
    var body: some View {
        Button {
            viewModel.resetGame()
        } label: {
            Text("Reset !")
                .foregroundColor(Color.white)
                .font(.system(size: 24, weight: .bold, design: .default))
                .frame(width: 180, height: 60)
                .background(Color.red.opacity(0.7))
                .cornerRadius(10)
        }
    }
}

struct GameCircleView: View {
    var body: some View {
        Circle()
            .foregroundColor(.red)
            .opacity(0.7)
    }
}

struct PlayerMoveIndicatorView: View {
    
    var moves: [Move?]
    var i: Int
    let geometry: GeometryProxy
    
    var body: some View {
        Image(systemName: moves[i]?.indicator ?? "")
            .resizable()
            .frame(width: geometry.size.width/9, height: geometry.size.width/9)
            .foregroundColor( moves[i]?.colorIndicator ?? .white)
    }
}

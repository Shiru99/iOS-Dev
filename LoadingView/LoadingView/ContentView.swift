//
//  ContentView.swift
//  LoadingView
//
//  Created by Shriram Ghadge on 11/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoading = true
    
    var body: some View {
        ZStack {
            Color(.orange)
                .ignoresSafeArea()
            
            VStack{
                Image(systemName: "figure.wave.circle.fill")
                    .resizable()
                    .frame(width: 128, height: 128)
                    .foregroundColor(Color.white)
                
                
                Text("Hello, world!")
                    .bold()
                    .font(.system(size: 36))
                    .foregroundColor(Color.white)
                
            }
            
            if isLoading{
                LoadingView()
                }
        }
        .onAppear{
            fakeNetworkCall()
        }
    }
    
    func fakeNetworkCall(){
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = false
            print("Network call completed")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color(.white)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
            .scaleEffect(4)}
    }
}

//
//  ContentView.swift
//  NavigationStack-Basics
//
//  Created by Shriram Ghadge on 28/02/23.
//

import SwiftUI

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}


struct ContentView: View {
    
    var platforms : [Platform] = [
        .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
        .init(name: "Xbox", imageName: "xbox.logo", color: .green),
        .init(name: "PC", imageName: "pc", color: .pink),
        .init(name: "Mobile", imageName: "iphone", color: .mint)
        
    ]
    
    var games: [Game] = [
        .init(name: "Minecraft", rating: "99"),
        .init(name: "God of war", rating: "90"),
        .init(name: "Fortnite", rating: "92"),
        .init(name: "Madden 2023", rating: "88")
    ]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        
        
        ///       1. label
        //        Label(platforms.first!.name, systemImage: platforms.first!.imageName)
        //            .foregroundColor(platforms.first!.color)
        
        ///        2. list
        //        List(platforms, id: \.name) { platform in
        //            Label(platform.name, systemImage: platform.imageName)
        //                .foregroundColor(platform.color)
        //        }
        
        
        ///        3. List  with section & foreach
        //        List {
        //            Section("Gaming platforms:"){
        //                ForEach(platforms, id: \.name) { platform in
        //                    Label(platform.name, systemImage: platform.imageName)
        //                        .foregroundColor(platform.color)
        //                }
        //            }
        //        }
        
        
        ///         4. Navigation Stack - NavigationLink & navigationDestination
        //        NavigationStack{
        //
        //            List {
        //                Section("Gaming platforms:"){
        //                    ForEach(platforms, id: \.name) { platform in
        //                        NavigationLink(value: platform){
        //                            Label(platform.name, systemImage: platform.imageName)
        //                                .foregroundColor(platform.color)
        //                        }
        //                    }
        //                }
        //
        //                Section("Games:"){
        //                    ForEach(games, id: \.name) { game in
        //                        NavigationLink(value: game){
        //                            Text(game.name)
        //                        }
        //                    }
        //                }
        //            }
        //            .navigationTitle("Gaming")
        //            .navigationDestination(for: Platform.self){ platform in
        //                ZStack{
        //                    platform.color.ignoresSafeArea()
        //
        //                    Label(platform.name, systemImage: platform.imageName)
        //                        .font(.largeTitle).bold()
        //
        //                }
        //            }
        //            .navigationDestination(for: Game.self){ game in
        //                ZStack{
        //                    Text("\(game.name) - \(game.rating)")
        //                        .font(.largeTitle).bold()
        //
        //                }
        //            }
        //
        //        }
        
        ///         5. Navigation Path
        NavigationStack(path: $path){
            
            List {
                Section("Gaming platforms:"){
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform){
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self){ platform in
                
                ZStack {
                    platform.color.ignoresSafeArea()
                    
                    VStack{
                        Label(platform.name, systemImage: platform.imageName)
                            .font(.largeTitle).bold()
                        
                        List{
                            ForEach(games, id: \.name) { game in
                                NavigationLink(value: game){
                                    Text(game.name)
                                }
                            }
                        }
                    }
                    
                }
            }
            .navigationDestination(for: Game.self){ game in
                VStack(spacing: 20){
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle).bold()
                    
                    Button("Recommanded Game"){
                        path.append(games.randomElement()!)
                    }
                    Button("Switch Platform "){
                        path.append(platforms.randomElement()!)
                    }
                    Button("Go Home"){
                        path.removeLast(path.count)
                    }
                    
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


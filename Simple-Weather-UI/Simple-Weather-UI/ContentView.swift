//
//  ContentView.swift
//  Simple-Weather-UI
//
//  Created by Shriram Ghadge on 21/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var isDarkTheme: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundView(
                backgroundsColors:
                    isDarkTheme
                    ?   [Color.black, Color.gray]
                    :   [ Color.blue,
                        Color(red: 0.227, green: 0.592, blue: 1.0),
                        Color(red: 0.4627, green: 0.8392, blue: 1.0),
                        Color.white]
            )
            
            VStack{
                
                DailyWeather(cityName: "Delhi, IND", temp: isDarkTheme ? "22" : "34", symbol: isDarkTheme ? "moon.stars.fill" :  "cloud.sun.fill")
                
                Spacer()
                
                HStack(spacing: 20){
                    WeeklyWeather(dayOfWeek: "Mon", temp: "34", symbol: "cloud.sun.fill" )
                    WeeklyWeather(dayOfWeek: "Tue", temp: "40", symbol:  "sun.max.fill"  )
                    WeeklyWeather(dayOfWeek: "Wed", temp: "32", symbol:   "sunset.fill" )
                    WeeklyWeather(dayOfWeek: "Thur", temp: "26", symbol: "wind.snow" )
                    WeeklyWeather(dayOfWeek: "Fri", temp: "20", symbol: "snow" )
                }
                
                Spacer()
                
                customButton(darkThemeOn: $isDarkTheme)
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct BackgroundView: View {
    var backgroundsColors : [Color];
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: backgroundsColors), startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea(.all)
    }
}

struct DailyWeather: View {
    
    let cityName: String;
    let temp: String
    let symbol: String
    
    var body: some View {
        VStack(spacing: 15){
            
            Text(cityName)
                .font(.system(size: 36, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.top, 20)
            
            Image(systemName: symbol)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 160)
            
            Text("\(temp)°C")
                .font(.system(size: 56, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct WeeklyWeather: View {
    
    let dayOfWeek: String
    let temp: String
    let symbol: String
    
    var body: some View {
        VStack(spacing: 5){
            
            Text(dayOfWeek)
                .font(.system(size: 22, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            
            Image(systemName: symbol)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 56, height: 56)
            
            Text("\(temp)°")
                .font(.system(size: 24, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct customButton: View {
    @Binding var darkThemeOn: Bool
    
    var body: some View {
        Button {
            darkThemeOn.toggle()
        } label: {
            Text("Change the theme")
                .foregroundColor(darkThemeOn ? Color.white : Color.blue)
                .font(.system(size: 18, weight: .bold, design: .default))
                .frame(width: 280, height: 50)
                .background(darkThemeOn ? Color.black : Color.white)
                .cornerRadius(10)
        }
    }
}

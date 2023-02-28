//
//  ContentView.swift
//  SwiftUI-List-Starter
//
//

import SwiftUI

struct VideoListView: View {
    
    var videos: [Video] = VideoList.topTen
    var body: some View {
        
        NavigationView{     // deprecated
            
            List(videos, id: \.id){ video in
                
                NavigationLink(destination: VideoDetailsView(video: video), label: {
                    
                    HStack() {
                        Image(video.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                            .cornerRadius(5)
                        
                        VStack(alignment: .leading, spacing: 5){
                            
                            Text(video.title)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .minimumScaleFactor(0.8)
                            
                            Text(video.uploadDate)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                })
            }.navigationTitle("iOS Top 10")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}

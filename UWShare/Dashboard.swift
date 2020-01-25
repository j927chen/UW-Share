//
//  Dashboard.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    @State var rideSharePostsInfo: [RideSharePostInfo] = [.init(id: 0, poster: "j927chen@edu.uwaterloo.ca", description: "Urgent! Please help!", initialLocation: "Waterloo", destination: "Toronto"),
    .init(id: 1, poster: "andrewLiu1@edu.uwaterloo.ca", description: "Will accept payment in flex dollars", initialLocation: "Waterloo", destination: "Montreal"),
    .init(id: 2, poster: "ViktorCreed@gmail.com", description: "Please and thank you!", initialLocation: "Vancouver", destination: "Montreal")]
    var body: some View {
        TabView {
            ZStack(alignment: .topTrailing) {
                List(rideSharePostsInfo, id: \.id) {
                    rideSharePost in RideSharePost(info: rideSharePost)
                }
                Button(action: {
                    // go to create post page
                }) {Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                    .shadow(color: .gray, radius: 0.4, x: 1, y: 1)
                    }.padding()
            }.tabItem {
                Image(systemName: "mappin")
                Text("Ride Share")
                }
            Text("Subletting Posts")
                .tabItem {
                    Image(systemName: "house")
                    Text("Lodgings")
                }
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}

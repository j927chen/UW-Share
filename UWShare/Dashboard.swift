//
//  Dashboard.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        TabView {
            ZStack(alignment: .topTrailing) {
                List {
                    RideSharePost(postType: "Ride Share Request", initialLocation: "Waterloo", destination: "Toronto", poster: "j927chen@edu.uwaterloo.ca", description: "Help! Urgent!" )
                    RideSharePost(postType: "Ride Share Offer", initialLocation: "Waterloo", destination: "Montreal", poster: "wajoxi7778@etcone.net", description: "Payment in Flex dollars")
                    RideSharePost(postType: "Ride Share Request", initialLocation: "Waterloo", destination: "Vancouver", poster: "andrewliu@uwaterloo.ca", description: "Please and Thank you!")
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

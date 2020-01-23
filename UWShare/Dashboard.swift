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
            List{
                RideSharePost(postType: "Ride Share Request", initialLocation: "Waterloo", destination: "Toronto", poster: "j927chen@edu.uwaterloo.ca", description: "Help! Urgent!" )
                RideSharePost(postType: "Ride Share Offer", initialLocation: "Waterloo", destination: "Montreal", poster: "wajoxi7778@etcone.net", description: "Payment in Flex dollars")
                RideSharePost(postType: "Ride Share Request", initialLocation: "Waterloo", destination: "Vancouver", poster: "andrewliu@uwaterloo.ca", description: "Please and Thank you!")
            }
            .tabItem {
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

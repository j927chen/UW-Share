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
                Post(from: "Waterloo", to: "Toronto", poster: "j927chen@edu.uwaterloo.ca" )
                Post(from: "Waterloo", to: "Montreal", poster: "wajoxi7778@etcone.net")
                Post(from: "Waterloo", to: "Vancouver", poster: "andrewliu@uwaterloo.ca")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Ride Share")
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

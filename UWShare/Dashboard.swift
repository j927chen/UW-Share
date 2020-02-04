//
//  Dashboard.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct Dashboard: View {
    @EnvironmentObject private var navigator: Navigator
    @State var rideSharePostsInfo: [RideSharePostInfo] = []
    var body: some View {
        TabView {
            ZStack(alignment: .topLeading) {
            ZStack(alignment: .topTrailing) {
                List(rideSharePostsInfo, id: \.id) {
                    rideSharePost in RideSharePost(info: rideSharePost)
                    }
                Button(action: {
                    self.navigator.currentView = "CreatePost"
                }) {Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                }.padding()
            }
                Button(action: {
                    self.getRideSharePosts()
                }) {Text("Update")}
                    .frame(width: 70, height: 30)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10.0)
                    .shadow(color: .gray, radius: 0.4, x: 1, y: 1)
                    .padding()
            }.tabItem {
                Image(systemName: "mappin")
                Text("Ride Share")
                }
            Text("Subletting")
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
    
     func getRideSharePosts() {
        let db = Firestore.firestore()
        db.collection("posts").whereField("postType", isEqualTo: "ride share")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting ride share posts: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.rideSharePostsInfo += [RideSharePostInfo(id: document.documentID, poster: (document.get("poster") as? String) ?? "", description: (document.get("description") as? String) ?? "", initialLocation: (document.get("starting location") as? String) ?? "", destination: (document.get("destination") as? String) ?? "")]
                    }
                }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard().environmentObject(Navigator())
    }
}

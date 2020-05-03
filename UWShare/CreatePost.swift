//
//  CreatePost.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-29.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import MapKit
import Firebase

struct CreatePost: View {
    @EnvironmentObject private var navigator: Navigator
    @State private var postType = 0
    @State private var description = ""
    @State private var startingLocation = ""
    @State private var destination = ""
    private let postTypes = ["Ride Share", "Subletting", "Textbook", "Other"]
    var body: some View {
        ZStack {
            //Color(.yellow).edgesIgnoringSafeArea(.all)
            //LinearGradient(gradient: Gradient(colors: [.white, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        self.navigator.currentView = "Dashboard"
                    }) {Image(systemName: "clear")}
                        .frame(width: 40, height: 25)
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .cornerRadius(10.0)
                    Spacer()
                }
                Text("Create a Post")
                    .font(.largeTitle)
                    .bold()
                ScrollView {
                    Text("Post about")
                    Picker(selection: $postType, label: Text("")) {
                        ForEach(0 ..< postTypes.count) { index in Text(self.postTypes[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("Give a brief description")
                    MultilineTextField(text: $description)
                        .frame(height: 300)
                        .border(Color.black)
                        .padding(.horizontal)
                    Text("Starting location")
                    TextField("Starting Location", text: $startingLocation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    MapView().frame(height: 300).clipShape(Circle())
                    Text("Destination")
                    TextField("Destination", text: $destination)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    MapView().frame(height: 300).clipShape(Circle())
                }
                Button(action: {
                    self.createNewRideSharePost(poster: (Auth.auth().currentUser?.email ?? ""), startingLocation: self.startingLocation, destination: self.destination, description: self.description)
                    self.navigator.currentView = "Dashboard"
                }) {Text("Post")}
                    .frame(width: 70, height: 25)
                    .foregroundColor(.white)
                    .background(Color.yellow)
                    .cornerRadius(10.0)
                    .padding()
            }
        }
    }
    
    private func createNewRideSharePost(poster: String, startingLocation: String, destination: String, description: String) {
        let db = Firestore.firestore()
        db.collection("posts").addDocument(data : [
        "postType": "ride share",
        "poster": poster,
        "starting location": startingLocation,
        "destination": destination,
        "description": description]) { err in
            if let err = err {
                print("Error creating new post: \(err)")
            } else {
                print("Document added succesfully!")
            }
        }
    }
}


struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost().environmentObject(Navigator())
    }
}

//
//  CreatePost.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-29.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import MapKit

struct CreatePost: View {
    @EnvironmentObject private var navigator: Navigator
    @State private var postType = 0
    @State private var description = ""
    private let postTypes = ["Ride Share", "Subletting", "Textbook", "Other"]
    var body: some View {
        ZStack {
            Color(.yellow).edgesIgnoringSafeArea(.all)
            //LinearGradient(gradient: Gradient(colors: [.white, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Create a Post")
                    .font(.largeTitle)
                    .bold()
                ScrollView {
                    Text("Post about")
                    Picker(selection: $postType, label: Text("Post about")) {
                        ForEach(0 ..< postTypes.count) { index in Text(self.postTypes[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("Give a brief description")
                    MultilineTextField(text: $description)
                        .frame(height: 300)
                        .border(Color.black)
                        .padding(.horizontal)
                    Text("Starting location")
                    MapView().frame(height: 300).clipShape(Circle())
                }
            }
        }
    }
}


struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost().environmentObject(Navigator())
    }
}

//
//  CreatePost.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-29.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct CreatePost: View {
    @EnvironmentObject private var navigator: Navigator
    @State private var postType = 0
    @State private var description = ""
    private let postTypes = ["Ride Share Offer", "Ride Share Request", "Subletting Request", "Subletting Offer", "Textbook Request", "Textbook Offer", "Other"]
    var body: some View {
        VStack {
            Text("Create a Post")
                .font(.largeTitle)
                .bold()
            ScrollView {
                Picker(selection: $postType, label: Text("Post about").font(.callout)) {
                    ForEach(0 ..< postTypes.count) { index in Text(self.postTypes[index]).tag(index)
                    }
                }
                Text("Give a brief description").font(.caption)
                MultilineTextField(text: $description)
                    .frame(height: 300)
                    .border(Color.black)
                    .padding()
                MapView().frame(height: 300)
            }
        }
    }
}


struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost().environmentObject(Navigator())
    }
}

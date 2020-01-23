//
//  RideSharePost.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-21.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct RideSharePost: View {
     let postType: String
     let initialLocation: String
     let destination: String
     let poster: String
     let description: String
        var body: some View {
            VStack {
                Text(postType)
                    .fontWeight(.black)
                HStack{
                    Text("From " + self.initialLocation)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("To " + self.destination)
                        .foregroundColor(.secondary)
                }
                    HStack {
                        Image(self.initialLocation)
                            .resizable()
                            .frame(width: 160, height: 160)
                        .cornerRadius(7.0)
                        Image(self.destination)
                            .resizable()
                            .frame(width: 160, height: 160)
                        .cornerRadius(7.0)
                    }
                Text(poster)
                    .font(.subheadline)
                    .padding()
                Text(description)
                    .font(.caption)
                    .lineLimit(3)
                Button(action: {
                }) {Text("More info")}
                .frame(width: 200, height: 50)
                .background(Color.pink)
                .foregroundColor(.white)
                .cornerRadius(7.0)
                .padding()
                
            }.padding()
            .cornerRadius(28)
            .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1))
            .padding([.top, .horizontal])
    }
}



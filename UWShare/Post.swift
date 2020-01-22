//
//  Post.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-21.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct Post: View {
    var from: String
    var to: String
    var poster: String
    var body: some View {
            VStack {
                Text("Ride Share Request")
                    .font(.title)
                HStack{
                    Text("From " + from)
                    .bold()
                    Spacer()
                    Text("To " + to)
                    .bold()
                }
                    HStack {
                        Image(from)
                            .resizable()
                            .frame(width: 150, height: 150)
                        .cornerRadius(7.0)
                        Image(to)
                            .resizable()
                            .frame(width: 150, height: 150)
                        .cornerRadius(7.0)
                    }
                HStack {
                    Text(poster)
                    .font(.subheadline)
                    .padding()
                }
                Button(action: {
                }) {Text("More info")}
                .frame(width: 200, height: 50)
                .background(Color.pink)
                .foregroundColor(.white)
                .cornerRadius(7.0)
                .padding()
                
            }.padding()
            .background(Color.gray).cornerRadius(28)
        }
    }


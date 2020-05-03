//
//  SubImageView.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct SubImageView: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                HStack {
                    Image(imageName)
                        .resizable()
                        .clipped()
                        .cornerRadius(10)
            }
            Text(description)
                .font(.subheadline)
                .padding()
        }.padding()            .background(Color.yellow).cornerRadius(28)
    }
}



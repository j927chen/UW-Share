//
//  Settings.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-21.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct Settings: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Settings")
                    .font(.largeTitle)
                    .bold()
                Text("Logged in as " + (Auth.auth().currentUser!.email)!)
                    .font(.title)
                    .foregroundColor(.gray)
            }
            Image("default profile icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button(action: {
                // reset password
            }) {Text("Change profile picture")}
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            .padding()
            Button(action: {
                // reset password
            }) {Text("Change password")}
            .frame(width: 200, height: 50)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            .padding()
            Button(action: {
            }) {Text("Change email address")}
            .frame(width: 200, height: 50)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            .padding()
            Button(action: {
            }) {Text("Signout")}
            .frame(width: 200, height: 50)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            .padding()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

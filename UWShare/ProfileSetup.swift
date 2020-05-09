//
//  ProfileSetup.swift
//  UWShare
//
//  Created by Jason Chen on 2020-05-09.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct ProfileSetup: View {
    @EnvironmentObject private var navigator: Navigator
    @State var username: String = ""
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.title)
                .bold()
            Text("Set up your profile")
                .bold()
                .foregroundColor(.gray)
            Text("Create your cute username")
                .font(.headline)
            TextField("e.g. Richard", text: $username)
                .padding()
                .background(LoginView().lightGrey)
                .cornerRadius(10.0)
                .padding()
            Text("Pick your awesome profile picture")
                .font(.headline)
            Image("default profile icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button(action: {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.username
                changeRequest?.commitChanges { (error) in
                    if error != nil {
                        print("Error setting displayName: " + error!.localizedDescription)
                    }
                }
                self.navigator.currentView = "Dashboard"
            }) {Text("I'm finished")}
                .frame(width: 200, height: 40)
                .background(Color.yellow)
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .padding()
        }
    }
}

struct ProfileSetup_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetup().environmentObject(Navigator())
    }
}

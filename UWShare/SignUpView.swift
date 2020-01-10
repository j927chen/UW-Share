//
//  ContentView.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-07.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SignUpView: View {
    let minUsernameLength = 3
    let minPasswordLength = 8
    let nonMatchingPasswordErrorMessage = "✖ The passwords do not match"
    let invalidPasswordErrorMessage = "✖ Password must be at least 8 characters"
    @State private var newUsername: String = ""
    @State private var newPassword: String = ""
    @State private var confirmedPassword: String = ""
    @State private var usernameErrorMessageOpacity: Double = 0
    @State private var passwordErrorMessage : String = ""
    @State private var passwordErrorMessageOpacity: Double = 0
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button("<--"){
                        // do something
                    }
                    Spacer()
                }
                Text("Welcome to")
                Text("UW Share")
                    .bold()
                    .font(.largeTitle)
            }.foregroundColor(.yellow)
            Image("University of Waterloo Logo")
            Spacer()
            VStack(alignment: .leading) {
                Text("Create Your Username")
                    .foregroundColor(.yellow)
                    .bold()
                Text("✖ Username must be at least 3 characters")
                    .opacity(usernameErrorMessageOpacity)
                    .foregroundColor(.red)
                HStack {
                    TextField("Make it funny and cheeky", text: $newUsername)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }.padding()
            VStack (alignment: .leading) {
                Text("Create Your Password")
                    .foregroundColor(.yellow)
                    .bold()
                Text(self.passwordErrorMessage)
                    .opacity(passwordErrorMessageOpacity)
                    .foregroundColor(.red)
                HStack{
                    SecureField("Make sure your password is strong", text: $newPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }.padding()
            VStack (alignment: .leading) {
                Text("Confirm Your Password")
                    .foregroundColor(.yellow)
                    .bold()
                HStack{
                    SecureField("Making sure there are no typos", text: $confirmedPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }.padding()
            Button(action: {
                if self.checkNewUsernameValidity(username: self.newUsername) {
                    self.usernameErrorMessageOpacity = 0
                    if !self.usernameAlreadyRegistered(username: self.newUsername) {
                    if self.checkPasswordMatch(password: self.newPassword, confirmedPassword: self.confirmedPassword) {
                        self.passwordErrorMessageOpacity = 0
                        if self.checkPasswordValidity(password: self.newPassword) {
                            self.registerNewUser(username: self.newUsername, password: self.newPassword)
                            // take user to dashboard view
                        } else {
                            self.passwordErrorMessage = self.invalidPasswordErrorMessage
                            self.passwordErrorMessageOpacity = 1
                        }
                    } else {
                        self.passwordErrorMessage = self.nonMatchingPasswordErrorMessage
                        self.passwordErrorMessageOpacity = 1
                    }
                    }
                    else {
                        print("asddasd")
                    }
                }
                else {
                    self.usernameErrorMessageOpacity = 1.0
                }
            }) {Text("Sign Up!")
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .padding(10)
                .border(Color.purple, width: 5)
            }
        }
    }

    /* Returns whether the given username has the following criteria:
     - Is at least 3 characters long where the first and last character are not spaces*/
    private func checkNewUsernameValidity(username: String) -> Bool {
        return username.count >= minUsernameLength && String(Array(username)[0]) != " " && String(Array(username)[username.count - 1]) != " "
    }
    
    /* Returns whether the two password fields match*/
    private func checkPasswordMatch(password: String, confirmedPassword: String) -> Bool {
        return password == confirmedPassword
    }
    
    /* Returns whether the given password has the following criteria:
     - Is at least 8 characters long*/
    private func checkPasswordValidity(password: String) -> Bool {
        return password.count >= minPasswordLength
    }
    
    /* Assumes given credentials are all valid*/
    private func registerNewUser(username: String, password: String) {
        let db = Firestore.firestore()
        db.collection("users").document(username).setData([
            //"id": "sadf232",
            //"username": username,
            "password": password
            //"faculty": faculty
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: " + username)
            }
        }
    }
    private func usernameAlreadyRegistered(username: String) -> Bool {
        let db = Firestore.firestore()
        var preexistingUser = false
        db.collection("users").document(username).getDocument { (document, error) in
            if let document = document, document.exists {
                preexistingUser = true
            } else {
            }
        }
        return preexistingUser
    }

    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }
}

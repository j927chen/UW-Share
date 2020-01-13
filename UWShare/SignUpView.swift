//
//  SignUpView.swift
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
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    @State private var usernameErrorMessageOpacity: Double = 0
    @State private var passwordErrorMessage : String = ""
    @State private var passwordErrorMessageOpacity: Double = 0
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button("<--"){
                        // go to login view
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
                Text("Enter your Email")
                    .foregroundColor(.yellow)
                    .bold()
                HStack {
                    TextField("Enter your Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }.padding()
            VStack(alignment: .leading) {
                Text("Create Your Username")
                    .foregroundColor(.yellow)
                    .bold()
                Text("✖ Username must be at least 3 characters")
                    .opacity(usernameErrorMessageOpacity)
                    .foregroundColor(.red)
                HStack {
                    TextField("Make it funny and cheeky", text: $username)
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
                    SecureField("Make sure your password is strong", text: $password)
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
                if self.checkNewUsernameValidity(username: self.username) {
                    self.usernameErrorMessageOpacity = 0
                    if true {//!self.usernameAlreadyRegistered(username: self.newUsername) {
                        if self.checkPasswordMatch(password: self.password, confirmedPassword: self.confirmedPassword) {
                            self.passwordErrorMessageOpacity = 0
                            if self.checkPasswordValidity(password: self.password) {
                                Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                                        if error != nil {
                                            print("Error creating user")
                                        } else {
                                            self.registerNewUser(username: self.username, password: self.password)
                                        }
                                    }
                                Auth.auth().currentUser?.sendEmailVerification{ (error) in
                                    if error != nil {
                                        print("Huh?")
                                    } else {
                                        print("Sent email verification")
                                    }
                                }
                            } else {
                                self.passwordErrorMessage = self.invalidPasswordErrorMessage
                                self.passwordErrorMessageOpacity = 1
                            }
                        } else {
                            self.passwordErrorMessage = self.nonMatchingPasswordErrorMessage
                            self.passwordErrorMessageOpacity = 1
                        }
                    } else {
                        print("Email already registered")
                    }
                } else {
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
        // some code
        return true
    }

    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }
}

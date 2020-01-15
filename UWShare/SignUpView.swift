//
//  SignUpView.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-07.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    @State private var signUpErrorMessage: String = ""
    @State private var signUpErrorMessageOpacity: Double = 0
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
            Text("❌ " + self.signUpErrorMessage)
                .opacity(self.signUpErrorMessageOpacity)
                .foregroundColor(.red)
            VStack (alignment: .leading) {
                Text("Enter your Email")
                    .foregroundColor(.yellow)
                    .bold()
                TextField("Enter your Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
            VStack (alignment: .leading) {
                Text("Create Your Password")
                    .foregroundColor(.yellow)
                    .bold()
                SecureField("Make sure your password is strong", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
            VStack (alignment: .leading) {
                Text("Confirm Your Password")
                    .foregroundColor(.yellow)
                    .bold()
                SecureField("Making sure there are no typos", text: $confirmedPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
            Button(action: {
                self.signUpErrorMessageOpacity = 0
                if self.passwordsMatch(password: self.password, confirmedPassword: self.confirmedPassword) {
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                            self.signUpErrorMessage = error!.localizedDescription
                            self.signUpErrorMessageOpacity = 1
                        } else {
                            self.registerNewUser(email: self.email, password: self.password)
                            Auth.auth().currentUser?.sendEmailVerification{ (error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    self.signUpErrorMessage = error!.localizedDescription
                                    self.signUpErrorMessageOpacity = 1
                                } else {
                                    print("Sent email verification to " + self.email)
                                }
                            }
                        }
                    }
                } else {
                    self.signUpErrorMessage = "passwords do not match"
                    self.signUpErrorMessageOpacity = 1
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
    
    /* Returns whether the two password fields match */
    private func passwordsMatch(password: String, confirmedPassword: String) -> Bool {
        return password == confirmedPassword
    }
    
    /* Assumes given credentials are all valid */
    private func registerNewUser(email: String, password: String) {
        let db = Firestore.firestore()
        db.collection("users").document(email).setData([
            "password": password
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with email: " + email)
            }
        }
    }
    
   struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }
}

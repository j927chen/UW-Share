//
//  SignUpView.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-07.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @EnvironmentObject private var navigator: Navigator
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    @State private var signUpErrorMessage: String = ""
    @State private var signUpErrorMessageOpacity: Double = 0
    var body: some View {
        ZStack {
            PlayerView()
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        self.navigator.currentView = "Login"
                    }) {Image(systemName: "arrow.left")}
                        .frame(width: 70, height: 25)
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .cornerRadius(10.0)
                    Spacer()
                }
                Text("Welcome to")
                Text("UW Share")
                    .bold()
                    .font(.largeTitle)
            }.foregroundColor(.yellow)
            /*
            Image("University of Waterloo Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)*/
            Text("❌ " + self.signUpErrorMessage)
                .opacity(self.signUpErrorMessageOpacity)
                .foregroundColor(.red)
                .animation(Animation.default)
            VStack (alignment: .leading) {
                Text("Enter your Email")
                    .foregroundColor(.yellow)
                    .bold()
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(LoginView().lightGrey)
                    .cornerRadius(10.0)
            }.padding()
            VStack (alignment: .leading) {
                Text("Create Your Password")
                    .foregroundColor(.yellow)
                    .bold()
                SecureField("Make sure your password is strong", text: $password)
                    .padding()
                    .background(LoginView().lightGrey)
                    .cornerRadius(10.0)
            }.padding()
            VStack (alignment: .leading) {
                Text("Confirm Your Password")
                    .foregroundColor(.yellow)
                    .bold()
                SecureField("Make sure there are no typos", text: $confirmedPassword)
                    .padding()
                    .background(LoginView().lightGrey)
                    .cornerRadius(10.0)
            }.padding()
            Button(action: {
                self.signUpErrorMessageOpacity = 0
                if self.passwordsMatch(password: self.password, confirmedPassword: self.confirmedPassword) {
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                        if error != nil {
                            if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                switch errorCode {
                                case .missingEmail:
                                    self.signUpErrorMessage = "Please enter a valid email address."
                                case .invalidEmail:
                                    self.signUpErrorMessage = "Given email address is invalid!"
                                case .emailAlreadyInUse:
                                    self.signUpErrorMessage = "This email address is already in use."
                                case .weakPassword:
                                    self.signUpErrorMessage = "Password must be at least 6 characters."
                                default:
                                    self.signUpErrorMessage = "\(error)"
                                }
                            }
                            self.signUpErrorMessageOpacity = 1
                        } else {
                            self.registerNewUser(email: self.email, password: self.password)
                            Auth.auth().currentUser?.sendEmailVerification{ (error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    self.signUpErrorMessage = error!.localizedDescription
                                    self.signUpErrorMessageOpacity = 1
                                } else {
                                    print("Sent email verification to " + self.email) // developer purposes
                                    self.navigator.currentView = "EmailVerification"
                                }
                            }
                        }
                    }
                } else {
                    self.signUpErrorMessage = "passwords do not match"
                    self.signUpErrorMessageOpacity = 1
                }

            }) {Text("Sign Up!")
                .frame(width: 350, height: 50)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .padding()
            }
        }.offset(y: -keyboardResponder.currentHeight * 0.9) // screen moves up when keyboard is toggled
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
            "password": password, "agreedToTerms": false // "emailVerified": false
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with email: " + email + ", password: " + password) // developer purposes
            }
        }
    }
    
   struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView().environmentObject(Navigator())
        }
    }
}

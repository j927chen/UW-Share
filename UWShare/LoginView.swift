//
//  LoginView.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-12.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    let lightGrey: Color = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    @EnvironmentObject private var navigator: Navigator
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginErrorMessage: String = ""
    @State private var loginErrorMessageOpacity: Double = 0
    var body: some View {
        VStack {
            Text("UW Share")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.yellow)
            Image("Geese")
                .resizable()
            Spacer()
            Text("❌ " + self.loginErrorMessage)
                .opacity(loginErrorMessageOpacity)
                .foregroundColor(.red)
                .animation(Animation.default)
            VStack(alignment: .leading) {
            Text("Sign in with email")
                .foregroundColor(.yellow)
                .bold()
            TextField("Enter your email", text: $email)
                .padding()
                .background(lightGrey)
                .cornerRadius(10.0)
            }.padding()
            VStack (alignment: .leading) {
                Text("Enter your password")
                    .foregroundColor(.yellow)
                    .bold()
                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(lightGrey)
                    .cornerRadius(10.0)
            }.padding()
            Button(action: {
                self.loginErrorMessageOpacity = 0
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
                    if error != nil {
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .invalidEmail:
                                self.loginErrorMessage = "Email address is invalid!"
                            case .userNotFound:
                                self.loginErrorMessage = "Email address is not registered."
                            case .userDisabled:
                                self.loginErrorMessage = "User's account with this email address has been suspended"
                            case .wrongPassword:
                                self.loginErrorMessage = "Password is incorrect!"
                            default:
                                self.loginErrorMessage = "\(error)"
                            }
                        }
                        self.loginErrorMessageOpacity = 1
                    } else {
                        if Auth.auth().currentUser!.isEmailVerified {
                            print("User successfully logged in!") // developer purposes
                            self.navigator.currentView = "Onboarding"
                        }
                        else {
                            self.navigator.currentView = "EmailVerification"
                        }
                    }
                }
            }) {Text("Login")}
                .frame(width: 350, height: 50)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .padding()
            Button(action: {
                self.navigator.currentView = "Sign Up"
                }) {Text("Don't have an account? Sign up now!")}
                .padding()
            Button(action: {
                // send email reset password
                }) {Text("Forgot your password?")}
                .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(Navigator())
    }
}

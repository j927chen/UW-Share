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
            Image("Login")
                .clipShape(Circle())
            Spacer()
            Text("❌ " + self.loginErrorMessage)
                .opacity(loginErrorMessageOpacity)
                .foregroundColor(.red)
            VStack(alignment: .leading) {
            Text("Sign in with Email")
                .foregroundColor(.yellow)
                .bold()
            TextField("Enter your Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
            VStack (alignment: .leading) {
                Text("Enter your password")
                    .foregroundColor(.yellow)
                    .bold()
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
            Button(action: {
                self.loginErrorMessageOpacity = 0
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        self.loginErrorMessage = error!.localizedDescription
                        self.loginErrorMessageOpacity = 1
                    } else {
                        print("User successfully logged in!")
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
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(Navigator())
    }
}

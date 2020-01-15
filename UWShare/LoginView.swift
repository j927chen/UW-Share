//
//  LoginView.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-12.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase
import AVKit

struct LoginView: View {
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
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .padding(10)
                .border(Color.orange, width: 5)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

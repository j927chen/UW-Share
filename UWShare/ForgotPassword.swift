//
//  ForgotPassword.swift
//  UW Share
//
//  Created by Jason Chen on 2020-05-03.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct ForgotPassword: View {
    @EnvironmentObject private var navigator: Navigator
    @State private var message = "message"
    @State private var messageOpacity: Double = 0
    @State private var email = "";
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.navigator.currentView = "Login"
                }) {Image(systemName: "clear")}
                    .frame(width: 40, height: 25)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(10.0)
                Spacer()
            }
            Spacer()
            Text("Forgot your password?")
                .font(.largeTitle)
                .foregroundColor(Color.gray)
            Text("We can send a password reset email")
                .font(.headline)
                .foregroundColor(Color.gray)
            Text(message)
                .opacity(messageOpacity)
                .font(.footnote)
            TextField("Enter your email", text: $email)
                .padding()
                .background(LoginView().lightGrey)
                .cornerRadius(10.0)
            Button(action: {
                self.messageOpacity = 0
                Auth.auth().sendPasswordReset(withEmail: self.email)
                self.message = "Password reset email sent to " + self.email;
                self.messageOpacity = 1
            }) {Text("Send password reset email")}
            .frame(width: 350, height: 50)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10.0)
            .padding()
            Spacer()
        }
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword().environmentObject(Navigator())
    }
}

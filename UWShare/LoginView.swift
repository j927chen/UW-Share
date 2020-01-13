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
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack {
                   VStack {
                       Text("UW Share")
                           .bold()
                           .font(.largeTitle)
                   }.foregroundColor(.yellow)
                   Image("University of Waterloo Logo")
                   Spacer()
                   VStack(alignment: .leading) {
                       Text("Sign in with Email")
                           .foregroundColor(.yellow)
                           .bold()
                       HStack {
                           TextField("Enter your Email", text: $email)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                       }
                   }.padding()
                   VStack (alignment: .leading) {
                       Text("Enter your password")
                           .foregroundColor(.yellow)
                           .bold()
                       HStack{
                           SecureField("Enter your password", text: $password)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                       }
                   }.padding()
            Button(action: {
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
                    if error != nil {
                        print("Couldn't sign in")
                    } else {
                        print("Jason")
                    }
                }
            }) {Text("Login")}
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

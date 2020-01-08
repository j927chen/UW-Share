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

struct LoginView: View {
    @State var newUsername: String = ""
    @State var newPassword: String = ""
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to")
                Text("UW Share")
                    .bold()
                    .font(.largeTitle)
            }.foregroundColor(.yellow)
            HStack {
                Text("Sign Up Now!")
                    .font(.subheadline)
                .italic()
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Create Your Username!")
                    .foregroundColor(.yellow)
                HStack {
                    TextField("Create Your Username", text: $newUsername)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            VStack (alignment: .leading) {
                Text("Create Your Password!")
                    .foregroundColor(.yellow)
                HStack{
                    SecureField("Create Your Password", text: $newPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            Button(action: {
                if self.newPassword != "" {
                    registerNewUser()
                }
                else {
                    //let invalidInputAlert = UIAlertController(title: "Invalid Input", message: "Please enter valid information.", preferredStyle: .alert)
                    //invalidInputAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    //self.present(invalidInputAlert, animated: true)
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
}

private func registerNewUser() {
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    ref = db.collection("users").addDocument(data: [
        "id": "sadf232",
        "username": "AdaLovelace57",
        "password": "password",
        "faculty": "Math"
    ]) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            print("Document added with ID: \(ref!.documentID)")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

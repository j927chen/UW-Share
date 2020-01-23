//
//  EmailVerification.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct EmailVerification: View {
    @EnvironmentObject private var navigator: Navigator
    @State private var errorMessage: String = ""
    @State private var errorMessageOpacity:  Double = 0
    var body: some View {
        VStack{
            Text("Verification email sent to " + (Auth.auth().currentUser?.email)!)
                .font(.largeTitle)
                .foregroundColor(Color.red)
            Text("Please click on the link")
                .font(.subheadline)
                .foregroundColor(Color.orange)
            Image("Checkmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("❌ " + self.errorMessage)
                .foregroundColor(Color.red)
            Button(action: {
                self.errorMessageOpacity = 0
                Auth.auth().currentUser?.sendEmailVerification{ (error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        self.errorMessage = error!.localizedDescription
                        self.errorMessageOpacity = 1
                    } else {
                        print("Sent email verification to " + (Auth.auth().currentUser?.email)!)
                    }
                }
            }) {Text("Resend email verification link")}
            .frame(width: 350, height: 50)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(10.0)
            .padding()
            Button(action: {
                self.navigator.currentView = "Login"
            } ) {Text("Return to login")}
            .frame(width: 350, height: 50)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10.0)
            .padding()
        }
    }
}

struct EmailVerification_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerification().environmentObject(Navigator())
    }
}

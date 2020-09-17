//
//  EmailVerification.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase

struct EmailVerification: View {
    @EnvironmentObject private var navigator: Navigator
    @State private var message: String = ""
    @State private var messageOpacity: Double = 0
    var body: some View {
        VStack{
            Text("Verification email sent to")
                .font(.largeTitle)
                .foregroundColor(Color.red)
            Text((Auth.auth().currentUser?.email)!)
                .font(.title)
            Text("Please click on the link")
                .font(.subheadline)
                .foregroundColor(Color.orange)
            Image("Checkmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
            if message == "Another email sent!" {
                Text(message).foregroundColor(.green).opacity(messageOpacity)
                
            }
            else {
                Text(message).foregroundColor(.red).opacity(messageOpacity)
            }
            Button(action: {
                self.messageOpacity = 0
                Auth.auth().currentUser?.sendEmailVerification{ (error) in
                    if let error = error {
                        if let errorCode = AuthErrorCode(rawValue: error._code) {
                            switch errorCode {
                            case .tooManyRequests:
                                self.message = "❌ Too many requests!"
                            default:
                                self.message = "❌ " + error.localizedDescription;
                            }
                        }
                    } else {
                        print("Sent email verification to " + (Auth.auth().currentUser?.email)!) // developer purposes
                        self.message = "Another email sent!"
                    }
                }
                self.messageOpacity = 1
            }) {Text("Resend email verification link")}
            .frame(width: 350, height: 50)
            .background(Color.black)
            .foregroundColor(.white)
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

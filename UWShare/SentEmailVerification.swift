//
//  SentEmailVerification.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct SentEmailVerification: View {
    @EnvironmentObject private var navigator: Navigator
    //var email: String
    var body: some View {
        VStack{
            Text("Verification email sent")
                .font(.largeTitle)
                .foregroundColor(Color.red)
            Text("Please click on the link")
                .bold()
                .foregroundColor(Color.orange)
            Image("Checkmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
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

struct SentEmailVerification_Previews: PreviewProvider {
    static var previews: some View {
        SentEmailVerification().environmentObject(Navigator())
    }
}

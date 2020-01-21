//
//  Onboarding.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import UIKit

struct Onboarding: View {
    @EnvironmentObject private var navigator: Navigator
    var subImageViews = [
        UIHostingController(rootView: SubImageView(imageName: "Messaging", title: "Connect With UW", description: "UW Share allows you to help or ask for help within our large university community.")),
        UIHostingController(rootView: SubImageView(imageName: "Security", title: "Security", description: "Your data and privacy is always secure and confidential no matter the situation")),
        UIHostingController(rootView: SubImageView(imageName: "Carpooling", title: "Carpooling", description: "Never fret with transportation worries again with the number of daily ride share postings here."))]
    var body: some View {
        VStack {
            PageViewController(viewControllers: subImageViews)
                .frame(height: 450)
            Spacer()
            Button(action: {
                self.navigator.currentView = "Dashboard"
        }) {Text("Got it!")
            .frame(width: 350, height: 50)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10.0)
            .padding()
        }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding().environmentObject(Navigator())
    }
}

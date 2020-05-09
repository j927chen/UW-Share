//
//  MotherView.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-16.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject private var navigator: Navigator
    var body: some View {
        VStack {
            if navigator.currentView == "Login" {
                LoginView().transition(.slide)
            }
            else if navigator.currentView == "Sign Up" {
                SignUpView().transition(.slide)
            }
            else if navigator.currentView == "Forgot Password" {
                ForgotPassword().transition(.slide)
            }
            else if navigator.currentView == "EmailVerification" {
                EmailVerification().transition(.slide)
            }
            else if navigator.currentView == "Onboarding" {
                Onboarding().transition(.slide)
            }
            else if navigator.currentView == "Profile Setup" {
                ProfileSetup().transition(.slide)
            }
            else if navigator.currentView == "Dashboard" {
                Dashboard().transition(.opacity)
            }
            else if navigator.currentView == "Create Post" {
                CreatePost().transition(.offset())
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(Navigator())
    }
}

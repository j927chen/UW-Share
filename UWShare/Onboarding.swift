//
//  Onboarding.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-20.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import UIKit

struct Onboarding: View {
    @EnvironmentObject private var navigator: Navigator
    private var subImageViews = [
        UIHostingController(rootView: SubImageView(imageName: "Messaging", title: "Connect With UW", description: "UW Share allows you to help or ask for help within our large university community.")),
        UIHostingController(rootView: SubImageView(imageName: "Security", title: "Security", description: "Your data and privacy are always secure and confidential no matter the circumstances.")),
        UIHostingController(rootView: SubImageView(imageName: "Carpooling", title: "Carpooling", description: "Never fret with transportation worries again with the number of daily ride share offers posted."))]
    @State private var currentPageIndex = 0;
    var body: some View {
        VStack {
                HStack {
                    Text("Swipe")
                    Image(systemName: "arrow.right")
                }.foregroundColor(.gray)
                PageViewController(viewControllers: subImageViews, currentPageIndex: $currentPageIndex)
                    .frame(height: 450)
                Button(action: {
                    self.navigator.currentView = "Dashboard"
            })  {Text("Got it!")
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(getButtonColor())
                .cornerRadius(10.0)
                .padding()
                }.disabled(self.currentPageIndex != self.subImageViews.count - 1)
            PageControl(numberOfPages: subImageViews.count, currentPageIndex: $currentPageIndex)
        }
    }
    
    private func getButtonColor() -> Color {
        if self.currentPageIndex != self.subImageViews.count - 1 {
            return Color.gray
        }
        return Color.red
    }
}

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = UIColor.yellow
        control.pageIndicatorTintColor = UIColor.black
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding().environmentObject(Navigator())
    }
}

//
//  Navigator.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-16.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class Navigator: ObservableObject {
    let objectWillChange = PassthroughSubject<Navigator, Never>()
    var currentView: String = "Login" {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
}

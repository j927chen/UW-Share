//
//  PostInfo.swift
//  UWShare
//
//  Created by Jason Chen on 2020-01-24.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import Foundation

class PostInfo {
    let id: Int
    private let postType: String
    private let poster: String
    private var description: String
    
    init(id: Int, postType: String, poster: String, description: String) {
        self.id = id
        self.postType = postType
        self.poster = poster
        self.description = description
    }
    
    func getPostType() -> String {
        return self.postType
    }
    
    func getPoster() -> String {
        return self.poster
    }
    
    func getDescription() -> String {
        return self.description
    }
}

class RideSharePostInfo: PostInfo {
    private var initialLocation: String
    private var destination: String
    
    init(id: Int, poster: String, description: String, initialLocation: String, destination: String) {
        self.initialLocation = initialLocation
        self.destination = destination
        super.init(id: id, postType: "Ride Share", poster: poster, description: description)
    }
    
    func getInitialLocation() -> String {
        return self.initialLocation
    }
    
    func getDestination() -> String {
        return self.destination
    }
}

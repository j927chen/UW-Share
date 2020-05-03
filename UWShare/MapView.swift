//
//  MapView.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-29.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    static let WaterlooOntarioLatitude = 43.466667
    static let WaterlooOntarioLongitude = -80.516670
    static let WaterlooOntarioCoordinate = CLLocationCoordinate2D(latitude: WaterlooOntarioLatitude, longitude: WaterlooOntarioLongitude)
    
    //@Binding var location: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: MapView.WaterlooOntarioLatitude, longitude: MapView.WaterlooOntarioLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
       // parent.location = mapView.centerCoordinate
        //print(parent.location)
    }
}

final class Location: NSObject, MKAnnotation {
    let location: String
    let coordinate: CLLocationCoordinate2D
    
    init(location: String, coordinate: CLLocationCoordinate2D) {
        self.location = location
        self.coordinate = coordinate
    }
}


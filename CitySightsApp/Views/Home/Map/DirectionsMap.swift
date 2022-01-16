//
//  DirectionsMap.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/12/22.
//

import Foundation
import MapKit
import SwiftUI

struct DirectionsMap: UIViewRepresentable{
    
   @EnvironmentObject var model:ContentModel
    var business: Buisness
    
    var start: CLLocationCoordinate2D{
        
        model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
        
    }
    
    var end: CLLocationCoordinate2D{
        
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude{
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        else{
            return CLLocationCoordinate2D()
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        
        //create mapp
        let map = MKMapView()
        map.delegate = context.coordinator
        
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        

        //create directions request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        let directions = MKDirections(request: request)
        
        //calculate route
        
        directions.calculate { (response, error) in
            
            if error == nil && response != nil{
                
                for route in response!.routes{
                    
                    map.addOverlay(route.polyline)
                    map.setVisibleMapRect(route.polyline.boundingMapRect,edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)

                }
                
            }
        }
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = end
        endAnnotation.title = business.name ?? ""
        
        map.addAnnotation(endAnnotation)
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.lineWidth = 4
            renderer.strokeColor = .red
            
            return renderer
        }
        
    }
    
    
    
}



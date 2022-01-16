//
//   BusinessMap.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/12/22.
//

import Foundation
import MapKit
import SwiftUI

struct BusinessMap: UIViewRepresentable{
    
   @EnvironmentObject var model:ContentModel
    @Binding var selectedBusiness:Buisness?
    var locations: [MKPointAnnotation]{
        
        var annotations = [MKPointAnnotation]()
        
        for business in model.restaraunts + model.arts{
            
            if(business.coordinates?.latitude != nil && business.coordinates?.longitude != nil){
                
                var mk = MKPointAnnotation()
                mk.coordinate = CLLocationCoordinate2D(latitude: business.coordinates!.latitude!, longitude: business.coordinates!.longitude!)
                mk.title = business.name ?? ""
                
                annotations.append(mk)

            }
            
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView{
        
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        //Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        //Add relevant ones
        uiView.showAnnotations(self.locations, animated: true)
        
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
    }
    
    //MARK- Coordinator class
    
    func makeCoordinator() -> Coordinator{
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var map: BusinessMap
        
        init(map: BusinessMap){
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            //dont do anything w the blue dot for the user
            
            if(annotation is MKUserLocation){
                return nil
            }
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier:"business")
            
            // if we did not get a reusable pin
            if(annotationView == nil){
                
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "business")
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            }
            else{
                annotationView!.annotation = annotation
            }
           
            
            return annotationView
            
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            
            //if function called we know user tapped on an annotation element
            
                
            //get business that user selected
            
            for business in map.model.restaraunts + map.model.arts{
                if business.name == view.annotation!.title {
                    //set business property taht user selected
                    
                    map.selectedBusiness  = business
                }
            }
            
        }
        
    }
}

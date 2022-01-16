//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/3/22.
//

import Foundation
import CoreLocation


class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    @Published var restaraunts = [Buisness]()
    @Published var arts = [Buisness]()
    @Published var authorizationState = CLAuthorizationStatus.notDetermined

    override init(){
        
        
        
        super.init()
        
        locationManager.delegate = self
       
        
  
    }
    
    func requestGeoLocationPermission(){
        //get permission from user and then geolocate them
        locationManager.requestWhenInUseAuthorization()
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            
            // Update the authorizationState property
            authorizationState = locationManager.authorizationStatus
            
            if locationManager.authorizationStatus == .authorizedAlways ||
                locationManager.authorizationStatus == .authorizedWhenInUse {
                
                // We have permission
                // Start geolocating the user, after we get permission
                locationManager.startUpdatingLocation()
            }
            else if locationManager.authorizationStatus == .denied {
                // We don't have permission
            }
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //gives us the location of the user

        let userLocation = locations.first
        
        if(userLocation != nil){
            
            //stop updating
            locationManager.stopUpdatingLocation()
            
            getBuisnesses(category: Keys.artskey, location: userLocation!)
            getBuisnesses(category: Keys.restaurantsKey, location: userLocation!)
            print("hey")
            }
        
        
        }

    
    func getBuisnesses(category:String, location:CLLocation){
        
        //create URL
       
        
        var urlComponents = URLComponents(string: Keys.apiURL)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String( location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String( location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: String(7))

        ]
        
        let url = urlComponents?.url
        
        if let url = url {
        
        //create URL request
        
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue(
                "Bearer \(Keys.apiKey)", forHTTPHeaderField: "Authorization")
        //get URL session
        
            let session = URLSession.shared
            
        //Create Data Task
        
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                if(error==nil){
                    
                    do{
                    
                    let decoder  = JSONDecoder()
                     
                    let result =  try decoder.decode(BusinessSearch.self, from: data!)
                    
                        //sort businesses
                        
                        var businesses = result.businesses
                        businesses.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        
                        for b in businesses{
                            
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            if(category == "restaurants"){
                                self.restaraunts = businesses
                            }
                            else if(category == "arts"){
                                self.arts = businesses
                                print("hey")
                            }
                        }
                    //Assign results to properties
                        
                       
                    }
                    catch{
                        //print the error from the DO CATCH block
                        print(error)
                    }
                }

            }
        //start Data Task
            dataTask.resume()
        }
    }
    
    
    }


//
//  Buisness.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/4/22.
//

import Foundation

class Buisness: Decodable, Identifiable, ObservableObject{
    
    @Published var imageData: Data?
    
    //vars to match the response given by Yelp
    //
        var id: String?
       var alias: String?
       var name: String?
       var imageUrl: String?
       var isClosed: Bool?
       var url: String?
       var reviewCount: Int?
       var categories: [Category]?
       var rating: Double?
       var coordinates: Coordinate?
       var transactions: [String]?
       var price: String?
       var location: Location?
       var phone: String?
       var displayPhone: String?
       var distance: Double?
    
    enum CodingKeys: String, CodingKey {
          
          case imageUrl = "image_url"
          case isClosed = "is_closed"
          case reviewCount = "review_count"
          case displayPhone = "display_phone"
          
          case id
          case alias
          case name
          case url
          case categories
          case rating
          case coordinates
          case transactions
          case price
          case location
          case phone
          case distance
      }
    
    func getImageData(){
        
        guard imageUrl != nil else{
            
            return
        }
        
        if let url = URL(string: imageUrl!){
            
            let session  = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    
                    DispatchQueue.main.async {
                    
                        self.imageData = data!

                    }
                    
                    
                }
            }
            
            dataTask.resume()
        }
    }

    
    
}



struct Category:Decodable{
    
    var alias:String?
    var title:String?
    
}

struct Coordinate:Decodable{
    
    var latitude: Double?
    var longitude: Double?
}

struct Location:Decodable{
    
    var address1: String?
    var adress2: String?
    var adress3: String?
    var city:String?
    var zip_code: String?
    var country: String?
    var state: String?
    var display_address: [String]?

}

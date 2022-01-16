//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Wafi Choudhury on 1/8/22.
//

import SwiftUI

struct BusinessDetail: View {
    var business: Buisness
    @State private var showDirections = false
    
    var body: some View {
        VStack (alignment: .leading){
            
            VStack (spacing:0){
            
            GeometryReader(content: { geometry in
                
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .scaledToFill()
    
                
            })
            .ignoresSafeArea(.all, edges: .top)

                ZStack{
                    
                    Rectangle()
                        .frame(height:36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white).bold()
                    
                }
            }
            
            Group{
                
                //Name
                BusinessTitle(business: business)
                    .padding()
                Divider()

                //phone
                
                HStack{
                    
                    Text("Phone").bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel\(business.phone ?? "")")!)
                    
                }.padding()
                
                Divider()

                //reviews
                
                HStack{
                    
                    Text("Reviews").bold()
                    Text("\(business.reviewCount ?? 0)" )
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                    
                }.padding()
                
                Divider()
                
                
                //website
                HStack{
                    
                    Text("Website").bold()
                    Text("\(business.url ?? "")" )
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                    
                }.padding()
                Divider()

                //
            }
            Button{
                showDirections = true
            }
            label: {
                ZStack{
                    
                    Rectangle()
                        .frame(height:48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }.padding()
            .sheet(isPresented: $showDirections, content: {
                DirectionsView(business: business)
            })
            
        }
    }
}


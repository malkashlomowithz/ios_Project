//
//  ProductsView.swift
//  FiinalProject
//
//  Created by Malky on 28/06/2022.
//

import SwiftUI

struct ProductsView: View {
    
    @StateObject var productMnager :ProductsManager
    
    var category: String
    
    var body: some View {
        
        ScrollView {
            
            Text((category))
                .font(.title)
                .fontWeight(.heavy)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]){
                
                
                ForEach(productMnager.products.filter({ $0.type.contains(category)})) { item in
                    
                    VStack {
                        Text(String(item.title))
                            .multilineTextAlignment(.center)
                            .truncationMode(.tail)
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                        
                        Text(String(item.type))
                            .font(.footnote)
                        
                        HStack{
                            AsyncImage(url: URL(string: item.imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                            Spacer()
                            
                            Text(item.description)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                .truncationMode(.tail)
                                .minimumScaleFactor(0.8)
                                .padding() 
                            Spacer()
                        }
                        
                        Text(String("price: $\(item.price)"))
                        Button(action: {
                            productMnager.saveProduct(title: item.title)
                        }) {
                            
                            HStack(alignment: .center, spacing: 5.0) {
                                
                                Image(systemName: productMnager.savedProduct.contains(item.title) ?  "heart.fill" : "heart")
                                    .padding(.leading, 10.0)
                                    .foregroundColor(.pink)
                            }
                        }
                    }
                    .padding()
                    
                }
            }
        }
    }
}
struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        
        ProductsView(productMnager: .init(), category: "")
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

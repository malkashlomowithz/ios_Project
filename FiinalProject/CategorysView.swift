//
//  CategorysView.swift
//  FiinalProject
//
//  Created by Malky on 28/06/2022.
//

import SwiftUI

struct CategorysView: View {
    
    @StateObject var productMnager: ProductsManager
    
    var body: some View {
        
        VStack {
            NavigationLink(destination: SavedProdeuctsView()){
                HStack {
                    Text("See all saved products")
                    Image(systemName: "heart.fill")
                }.foregroundColor(.pink)
               
            }
            
            List(Array(productMnager.categoryArray) , id: \.self  ) { item  in
                NavigationLink(destination:
                                ProductsView(productMnager: productMnager, category: item))
                {
                    Text(item)
                }
            }
            .navigationTitle("Categorys:")
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct CategorysView_Previews: PreviewProvider {
    static var previews: some View {
        CategorysView(productMnager: ProductsManager())
    }
}


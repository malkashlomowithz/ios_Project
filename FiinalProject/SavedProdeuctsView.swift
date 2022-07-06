//
//  SavedProdeuctsView.swift
//  FiinalProject
//
//  Created by Malky on 30/06/2022.
//

import SwiftUI

struct SavedProdeuctsView: View {
    
    @StateObject var prodectMnnager = ProductsManager()
    
    var body: some View {
        VStack {
            HStack {
                Text("My saved products")
                Image(systemName: "heart.fill")
            }.foregroundColor(.pink)
            List(prodectMnnager.savedProduct , id: \.self ) { item  in
                
                HStack{
                    Text(item)
                    Spacer()
                    Button("🗑"){
                        prodectMnnager.deleteProducts(product: item)
                    }
                }
            }
            
        }
    }
}

struct SavedProdeuctsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedProdeuctsView()
    }
}

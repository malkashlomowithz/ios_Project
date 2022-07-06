//
//  ProductModel.swift
//  FiinalProject
//
//  Created by Malky on 28/06/2022.
//

import Foundation



struct Product: Codable , Identifiable {
    
    let id: String
    let title: String
    let type: String
    let description: String
    let price: Int
    let imageUrl: String
}



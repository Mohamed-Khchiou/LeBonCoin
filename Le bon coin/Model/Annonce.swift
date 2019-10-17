//
//  Annonce.swift
//  Le bon coin
//
//  Created by mbdse on 17/10/2019.
//  Copyright © 2019 Tokidev S.A.S. All rights reserved.
//

import Foundation


struct Annonce {
    var title: String
    var offer: String
    var city: String
    var category: String
    var price: String
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.offer = dictionary["offer"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
    }
}

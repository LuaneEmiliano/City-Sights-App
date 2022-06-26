//
//  BusinessList.swift
//  City Sights App
//
//  Created by luane Niejelski on 6/26/22.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject  var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(model.restaurants) { business in
                    Text(business.name ?? " ")
                    Divider()
                }
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}


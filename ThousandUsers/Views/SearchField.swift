//
//  SearchField.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/24/25.
//

import Foundation
import SwiftUI

struct SearchField: View {
    
    @Binding
    var searchText: String
    var hint: String
    var clear: () -> ()
    var onQueryChange: (String) -> ()
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(hint, text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .onChange(of: searchText) {
                    onQueryChange($0)
                }
            
            if !searchText.isEmpty {
                Button(action: clear) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
}

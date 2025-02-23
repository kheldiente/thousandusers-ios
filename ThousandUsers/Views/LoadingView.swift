//
//  LoadingView.swift
//  ThousandUsers
//
//  Created by Mike Diente on 2/23/25.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(CGSize(width: 2, height: 2))
            Spacer()
        }
        .padding()
    }
    
}

#Preview {
    LoadingView()
}

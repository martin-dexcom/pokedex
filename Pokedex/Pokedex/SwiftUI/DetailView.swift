//
//  DetailView.swift
//  Pokedex
//
//  Created by Martin García on 8/1/21.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct DetailView: View {
    let viewModel: DetailViewModelProtocol
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text(viewModel.name)
                            .font(.system(size: 32, weight: .bold))
                        Text(viewModel.order)
                            .font(.system(size: 13))
                        Spacer()
                    }
                    Text(viewModel.type)
                        .font(.system(size: 17))
                }.padding()
                WebImage(url: viewModel.image)
                
                VStack(spacing: 5) {
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "plus")
                        }
                    }.padding()
                    ForEach(viewModel.stats, id:\.name) { (name, power) in
                        HStack {
                            Text(name)
                                .font(.system(size: 35, weight: .heavy))
                            Spacer()
                            Text(power)
                                .font(.system(size: 35, weight: .heavy))
                        }
                        .padding(5)
                        .background(Color.lightGray)
                    }
                    .padding()
                }
                .background(Color.orange)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        
    }
}

extension Color {
    static var lightGray: Color {
        return Color(UIColor.lightGray)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: MockDataSource.pokemon)
    }
}

//
//  ArticleRowView.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//


import SwiftUI

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            AsyncImage(url: article.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text(article.abstract)
                    .font(.subheadline)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
                
                HStack {
                    Text(article.formattedByline)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(article.formattedDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(article.title). \(article.abstract). By \(article.formattedByline). Published \(article.formattedDate)")
        .accessibilityHint("Double tap to view article details")
    }
}

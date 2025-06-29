//
//  ArticleRowView.swift
//  ArticlesApp
//
//  Created by Kareem on 26/06/2025.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .overlay(
                        Image(systemName: "doc.text")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    )
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(article.byline)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                
                HStack {
                    Spacer()
                    Image(systemName: "calendar")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Text(formattedDate)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
    
    private var imageURL: URL? {
        guard let media = article.media.first,
              let metadata = media.mediaMetadata.first else { return nil }
        return URL(string: metadata.url)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: article.publishedDate) {
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
        
        return article.publishedDate
    }
}

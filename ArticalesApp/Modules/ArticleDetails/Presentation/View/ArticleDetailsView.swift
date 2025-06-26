//
//  ArticleDetailsView.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import SwiftUI

struct ArticleDetailsView: View {
    @ObservedObject var viewModel: ArticleDetailsViewModel
    let article: Article
    @Environment(\.dismiss) private var dismiss
    @State private var showingWebView = false
    @State private var showingShareSheet = false
    
    // MARK: - Init
    init(viewModel: ArticleDetailsViewModel, article: Article) {
        self.viewModel = viewModel
        self.article = article
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                heroImageView
                articleContentView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.viewDidAppear(with: article)
        }
    }
    
    // MARK: - Subviews
    private var heroImageView: some View {
        AsyncImage(url: article.imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                )
        }
        .frame(height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
    
    private var articleContentView: some View {
        VStack(alignment: .leading, spacing: 12) {
            titleSection
            metadataSection
            Divider()
            abstractSection
        }
        .padding(.horizontal)
    }
    
    private var titleSection: some View {
        Text(article.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .lineLimit(nil)
    }
    
    private var metadataSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(article.formattedByline)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(article.formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(article.section.capitalized)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .clipShape(Capsule())
                
                if let subsection = article.subsection, !subsection.isEmpty {
                    Text(subsection.capitalized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var abstractSection: some View {
        Text(article.abstract)
            .font(.body)
            .lineSpacing(4)
            .foregroundColor(.primary)
    }
    
}

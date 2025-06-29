//
//  ArticlesView.swift
//  ArticlesApp
//
//  Created by Kareem on 26/06/2025.
//

import SwiftUI

struct ArticlesView: View {
    @StateObject private var viewModel: ArticlesViewModel
    private let router: ArticlesRouterProtocol
    
    init(viewModel: ArticlesViewModel, router: ArticlesRouterProtocol) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.router = router
    }
    
    var body: some View {
        NavigationView {
            CustomNavigationView(
                title: "NY Times Most Popular",
                showBackButton: false,
                showSearchButton: true,
                showMenuButton: true,
                onSearchTapped: {
                    // Handle search action
                    print("Search tapped")
                },
                onMenuTapped: {
                    // Handle menu action
                    print("Menu tapped")
                }
            ) {
                if viewModel.isLoading && viewModel.articles.isEmpty {
                    LoadingView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                } else {
                    articlesList
                        .refreshable {
                            viewModel.refreshArticles()
                        }
                }
            }
        }
        .onAppear {
            if viewModel.articles.isEmpty {
                viewModel.loadArticles()
            }
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }
    
    private var articlesList: some View {
        List(viewModel.articles) { article in
            NavigationLink(destination: router.navigateToArticleDetail(article)) {
                ArticleRowView(article: article)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
        .background(Color.white)
    }
}

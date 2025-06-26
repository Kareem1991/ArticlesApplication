//
//  ArticalesView.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//

import SwiftUI

struct ArticlesView: View {
    @ObservedObject var viewModel: ArticlesViewModel
    @State private var selectedArticle: Article?
    @State private var showingArticleDetail = false

    // MARK: - Constants
    private enum Constants {
        static let navigationTitle = "NY Times Most Popular"
        static let listRowTopPadding: CGFloat = 8
        static let listRowBottomPadding: CGFloat = 8
        static let listRowLeadingPadding: CGFloat = 16
        static let listRowTrailingPadding: CGFloat = 16
    }
    
    // MARK: - Init
    init(viewModel: ArticlesViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle(Constants.navigationTitle)
                .navigationBarTitleDisplayMode(.large)
                .toolbar { toolbarContent }
                .navigationDestination(isPresented: $showingArticleDetail) { destinationView }
        }
        .onAppear { handleViewAppear() }
        .onChange(of: viewModel.navigationCase) { _, navigationCase in
            handleNavigation(navigationCase)
        }
    }
}

// MARK: - Content Views
private extension ArticlesView {
    @ViewBuilder
    var contentView: some View {
        if viewModel.isLoading && viewModel.articles.isEmpty {
            LoadingView()
        } else if viewModel.articles.isEmpty && viewModel.showError {
            ErrorView(message: viewModel.errorMessage ?? "Unknown error") {
                viewModel.retryLastAction()
            }
        } else {
            articlesList
        }
    }
    
    var articlesList: some View {
        List(viewModel.articles) { article in
            ArticleRowView(article: article)
                .onTapGesture {
                    viewModel.selectArticle(article)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(listRowInsets)
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.refreshArticles()
        }
    }
    
    var listRowInsets: EdgeInsets {
        EdgeInsets(
            top: Constants.listRowTopPadding,
            leading: Constants.listRowLeadingPadding,
            bottom: Constants.listRowBottomPadding,
            trailing: Constants.listRowTrailingPadding
        )
    }
}

// MARK: - Toolbar
private extension ArticlesView {
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            toolbarMenu
        }
    }
    
    var toolbarMenu: some View {
        Menu {
            refreshButton
            clearCacheButton
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
    
    var refreshButton: some View {
        Button("Refresh", systemImage: "arrow.clockwise") {
            viewModel.refreshArticles()
        }
    }
    
    var clearCacheButton: some View {
        Button("Clear Cache", systemImage: "trash") {
            viewModel.clearCache()
        }
    }
}



private extension ArticlesView {
    @ViewBuilder
    var destinationView: some View {
        if let article = selectedArticle {
            ArticleDetailsConfigurator.configureModule(with: article)
        }
    }
}

private extension ArticlesView {
    func handleViewAppear() {
        if viewModel.articles.isEmpty {
            viewModel.loadArticles()
        }
    }
    
    func handleNavigation(_ navigationCase: ArticlesNavigationCases?) {
        switch navigationCase {
        case .showArticleDetail(let article):
            selectedArticle = article
            showingArticleDetail = true
            print("📱 Navigating to article: \(article.title)")
        case .none:
            break
        }
    }
}

// MARK: - Preview
struct Articles_Previews: PreviewProvider {
    static var previews: some View {
        ArticalesConfigurator.configureModule()
    }
}

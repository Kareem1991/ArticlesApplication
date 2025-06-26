//
//  ArticalesAppTests.swift
//  ArticalesAppTests
//
//  Created by Kareem on 26/06/2025.
//

import Testing
import Combine
@testable import ArticalesApp

struct ArticlesAppTests {
    
    @Test func loadArticlesWithMockResponse() async throws {

        let mockArticle = Article(
            uri: "nyt://article/1",
            url: "https://test.com",
            id: 1,
            assetId: 100,
            source: "New York Times",
            publishedDate: "2025-06-26",
            updated: "2025-06-26",
            section: "Technology",
            subsection: "Tech",
            nytdsection: "technology",
            adxKeywords: "test",
            column: nil,
            byline: "By Test Author",
            type: "Article",
            title: "Test Article",
            abstract: "Test abstract",
            desFacet: ["Tech"],
            orgFacet: ["Apple"],
            perFacet: ["Tim Cook"],
            geoFacet: ["USA"],
            media: [],
            etaId: 1
        )
        
        let mockResponse = ArticalesResponseModel(
            status: "OK",
            copyright: "Test Copyright",
            numResults: 1,
            results: [mockArticle]
        )
        
        let mockUseCase = MockUseCase()
        mockUseCase.mockResponse = mockResponse
        
        let viewModel = ArticlesViewModel(articalesUseCase: mockUseCase)
        
        viewModel.loadArticles()
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(viewModel.articles.count == 1)
        #expect(viewModel.articles.first?.title == "Test Article")
        #expect(viewModel.isLoading == false)
        #expect(mockUseCase.wasCalled == true)
    }
    
    @Test func loadArticlesWithError() async throws {

        let mockUseCase = MockUseCase()
        mockUseCase.shouldFail = true
        mockUseCase.error = NetworkError.notValidURL
        
        let viewModel = ArticlesViewModel(articalesUseCase: mockUseCase)
        
        viewModel.loadArticles()
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(viewModel.showError == true)
        #expect(viewModel.articles.isEmpty)
        #expect(viewModel.isLoading == false)
    }
    
    @Test func selectArticle() {

        let mockArticle = Article(
            uri: "nyt://article/1",
            url: "https://test.com",
            id: 123,
            assetId: 100,
            source: "New York Times",
            publishedDate: "2025-06-26",
            updated: "2025-06-26",
            section: "Technology",
            subsection: "Tech",
            nytdsection: "technology",
            adxKeywords: "test",
            column: nil,
            byline: "By Test Author",
            type: "Article",
            title: "Selected Article",
            abstract: "Test abstract",
            desFacet: ["Tech"],
            orgFacet: ["Apple"],
            perFacet: ["Tim Cook"],
            geoFacet: ["USA"],
            media: [],
            etaId: 1
        )
        
        let mockUseCase = MockUseCase()
        let viewModel = ArticlesViewModel(articalesUseCase: mockUseCase)
        
        viewModel.selectArticle(mockArticle)
        
        #expect(viewModel.selectedArticle?.id == 123)
        #expect(viewModel.selectedArticle?.title == "Selected Article")
        
        if case .showArticleDetail(let article) = viewModel.navigationCase {
            #expect(article.id == 123)
        }
    }
}
class MockUseCase: ArticalesUseCaseProtocol {
    var mockResponse: ArticalesResponseModel?
    var shouldFail = false
    var error: NetworkError = .unknown( "Mock Error")
    var wasCalled = false
    
    func getMostPopularArticales() -> AnyPublisher<ArticalesResponseModel, NetworkError> {
        wasCalled = true
        
        if shouldFail {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        guard let response = mockResponse else {
            return Fail(error: NetworkError.unknown("No mock response"))
                .eraseToAnyPublisher()
        }
        
        return Just(response)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}

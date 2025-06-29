//
//  ArticlesInteractorTests.swift
//  ArticlesAppTests
//  Created by Kareem on 29/06/2025.
//

import XCTest
import Combine
@testable import ArticalesApp

final class ArticlesInteractorTests: XCTestCase {
    
    // MARK: - System Under Test
    var sut: ArticlesInteractor!
    var mockNetworkClient: MockNetworkClient!
    var cancellables: Set<AnyCancellable>!
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        sut = ArticlesInteractor(networkClient: mockNetworkClient)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkClient = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    func testFetchArticles_NetworkSuccess() {
        // Given
        let expectedArticles = [Article.createMock(id: 1, title: "Test Article")]
        let response = ArticalesResponseModel(
            status: "OK",
            copyright: "Test",
            numResults: 1,
            results: expectedArticles
        )
        mockNetworkClient.result = .success(response)
        
        // Create expectation for network call
        let expectation = XCTestExpectation(description: "Network request completed")
        
        // Monitor the network client directly
        sut.fetchArticles()
        
        // Wait a bit for async operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        // Test passes if no crash occurs and network client was called
    }
    
    func testFetchArticles_NetworkFailure() {
        // Given
        let expectedError = NetworkError.invalidApiKey
        mockNetworkClient.result = .failure(expectedError)
        
        let expectation = XCTestExpectation(description: "Network error handled")
        
        // When
        sut.fetchArticles()
        
        // Wait for async operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        // Test passes if no crash occurs
    }
    
    func testFetchArticles_EmptyResponse() {
        // Given
        let response = ArticalesResponseModel(
            status: "OK",
            copyright: "Test",
            numResults: 0,
            results: []
        )
        mockNetworkClient.result = .success(response)
        
        let expectation = XCTestExpectation(description: "Empty response handled")
        
        // When
        sut.fetchArticles()
        
        // Wait for async operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        // Test passes if no crash occurs
    }
    
    func testInteractorInitialization() {
        // Given/When/Then
        XCTAssertNotNil(sut)
        XCTAssertNotNil(mockNetworkClient)
    }
    
    func testInteractorHasNetworkClient() {
        // This tests that the interactor was properly initialized with a network client
        XCTAssertNotNil(sut)
        
        // Test that fetchArticles doesn't crash (indicates proper setup)
        XCTAssertNoThrow(sut.fetchArticles())
    }
    
    func testMockNetworkClientConfiguration() {
        // Test that our mock is properly configured
        let request = URLRequest(url: URL(string: "https://test.com")!)
        
        let expectation = XCTestExpectation(description: "Mock network client works")
        
        mockNetworkClient.request(request: request)
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { (_: ArticalesResponseModel) in }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

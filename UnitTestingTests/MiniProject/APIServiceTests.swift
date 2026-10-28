//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        // TODO: Implement test
    }

    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        
        // TODO: Implement test
    }

    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        // TODO: Implement test
    }

    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        // TODO: Implement test
    }

    // MARK: Fetch Users Async

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        // TODO: Implement test
    }

    // TODO: Implement test
    // add other tests for fetchUsersAsync

    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}

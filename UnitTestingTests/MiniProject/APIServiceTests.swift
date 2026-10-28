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
        let sut = makeSut()
        let expectation = expectation(description: "Invalid URL error")
        
        sut.fetchUsers(urlString: "http://[invalid-url") { result in
            guard case .failure(let error) = result else {
                XCTFail("Expected invalidUrl error")
                expectation.fulfill()
                return
            }
            XCTAssertEqual(error, .invalidUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
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
        
        let expectation = expectation(description: "Users fetched successfullty")
        
        sut.fetchUsers(urlString: "http://example.com/users") { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users[0].id, 1)
                XCTAssertEqual(users[0].name, "John Doe")
                XCTAssertEqual(users[1].id, 2)
                XCTAssertEqual(users[1].name, "Jane Doe")
                
            case .failure(let error):
                XCTFail("Expected success, got \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        mockURLSession.mockData = Data("invalid JSON".utf8)
        
        let sut = makeSut()
        
        let expectation = expectation(description: "Parsing error")
        
        sut.fetchUsers(urlString: "https://exapmle.com/users") { result in
            guard case .failure(let error) = result else {
                XCTFail("Expected parsingErorr")
                expectation.fulfill()
                return
            }
            
            XCTAssertEqual(error, .parsingError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        let sut = makeSut()
        let expectation = expectation(description: "Unexpected network error")
        
        sut.fetchUsers(urlString: "htpps://example.com/users") {
            result in guard case .failure(let error) = result else {
                XCTFail("Expected unexpected error")
                expectation.fulfill()
                return
            }
            
            XCTAssertEqual(error, .unexpected)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    // MARK: Fetch Users Async

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(
            urlString: "http://[invalid-url"
        )
        
        guard case .failure(let error) = result else {
            XCTFail("Expected invalidURL error")
            return
        }
        
        XCTAssertEqual(error, .invalidUrl)
    }

    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}

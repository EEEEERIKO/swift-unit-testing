//
//  UsersViewModelTests.swift
//  UnitTesting
//

@testable import UnitTesting
import XCTest

class UsersViewModelTests: XCTestCase {
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    // assert that sut.fetchUsers(completion: {}) calls appropriate method of api service
    // use XCAssertEqual, fetchUsersCallsCount
    func test_viewModel_whenFetchUsers_callsApiService() {
        let sut = makeSut()
        
        XCTAssertEqual(mockService.fetchUsersCallsCount, 0)
        
        sut.fetchUsers(completion: {})
        
        XCTAssertEqual(mockService.fetchUsersCallsCount, 1)
    }

    // assert that the passed url to api service is correct
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        let sut = makeSut()
        
        sut.fetchUsers(completion: {})
        
        XCTAssertEqual(
            mockService.receivedUrlString,
            "https://jsonplaceholder.typicode.com/users"
        )
    }

    // assert that view model users are updated and error message is nil
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        let sut = makeSut()
        
        let expectation = expectation(description: "Users fetched")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(sut.users.count, 1)
        XCTAssertEqual(sut.users.first?.id, 1)
        XCTAssertEqual(sut.users.first?.name, "name")
        XCTAssertNil(sut.errorMessage)
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        let sut = makeSut()
        let expectation = expectation(description: "Fetchusers completed")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
    }
    

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.unexpected)
        
        let sut = makeSut()
        let expectation = expectation(description: "Fetchusers completed")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
    }

    // assert that view model error message is "Error parsing JSON"
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.parsingError)
        
        let sut = makeSut()
        let expectation = expectation(description: "Fetch users completed")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(sut.errorMessage, "Error parsing JSON")
    }

    // fetch users with successful result and after calling clear() assert users are empty
    func test_viewModel_clearUsers() {
        mockService.fetchUsersResult = .success([
            User(id: 1, name: "name", username: "surname", email: "user@email.com")
        ])
        
        let sut = makeSut()
        let expectation = expectation(description: "Users fetched")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(sut.users.count, 1)
        
        sut.clearUsers()
        
        XCTAssertTrue(sut.users.isEmpty)
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}

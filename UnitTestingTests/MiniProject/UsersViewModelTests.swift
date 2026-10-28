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
        // TODO: Implement test
    }

    // assert that the passed url to api service is correct
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        // TODO: Implement test
    }

    // assert that view model users are updated and error message is nil
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        let sut = makeSut()
        
        // TODO: Implement test
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        // TODO: Implement test
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        // TODO: Implement test
    }

    // assert that view model error message is "Error parsing JSON"
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        // TODO: Implement test
    }

    // fetch users with successful result and after calling clear() assert users are empty
    func test_viewModel_clearUsers() {
        // TODO: Implement test
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}

# Swift Unit Testing

A practical Swift project focused on unit testing fundamentals using XCTest, dependency injection, and mock services.

## Overview

This project explores how to write reliable and maintainable unit tests for Swift applications. It covers testing business logic, isolating dependencies, validating asynchronous behavior, and verifying error handling.

## Topics Covered

- **XCTest:** Writing unit tests with assertions and test expectations.
- **Dependency Injection:** Injecting dependencies to isolate components under test.
- **Mock Objects:** Simulating API responses without making real network requests.
- **Success and Error Scenarios:** Testing successful operations and different failure conditions.
- **Asynchronous Testing:** Synchronizing tests with asynchronous callbacks.
- **ViewModel Testing:** Verifying state updates, error messages, and state-reset operations.

## Project Structure

The project includes the following components:

- `Calculator`: Basic calculation logic and error handling.
- `CalculatorTests`: Unit tests for calculator behavior.
- `APIService`: Service responsible for fetching user data.
- `MockAPIService`: Mock implementation used to isolate API service dependencies.
- `MockURLSession`: Mock URL session for controlling network responses.
- `UsersViewModel`: Manages user data and error state.
- `UsersViewModelTests`: Tests ViewModel behavior using a mock API service.

## Testing

Run the tests in Xcode:

1. Open the `UnitTesting.xcodeproj` project.
2. Select the appropriate test scheme.
3. Press `⌘ + U` to execute the test suite.
4. Review the results in the Test Navigator.

Tests use mocked dependencies to avoid relying on external network services.

## Goals

- Improve confidence in code through automated testing.
- Understand the role of mocks and dependency injection.
- Test asynchronous callbacks reliably.
- Verify both successful outcomes and error-handling behavior.
- Build a foundation for testing larger Swift and iOS applications.

## Technologies

- Swift
- XCTest
- Foundation
- Xcode

## License

This project is intended for educational and practice purposes.

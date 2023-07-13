import XCTest

func XCTAssertEqualCast<T, U>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> U,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) rethrows where U : Equatable {
    let value1 = try expression1()
    let value2 = try expression2()
    
    guard let value1 = value1 as? U else {
        XCTFail("Expression is not equal, expected \(value2), but got \(value1)")
        return
    }
    
    XCTAssertEqual(value1, value2)
}

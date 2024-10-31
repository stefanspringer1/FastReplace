import XCTest
import FastReplace

final class FastReplaceTests: XCTestCase {
    
    func testReplaceScalarWithScalar() throws {
        
        // new String:
        XCTAssertEqual("a∑b".replacing(UnicodeScalar("∑"), with: UnicodeScalar("∫")), "a∫b")
                       
        // mutating:
        var text = "a∑b"
        text.replace(UnicodeScalar("∑"), with: UnicodeScalar("∫"))
        XCTAssertEqual(text, "a∫b")
        
    }
    
    func testReplaceScalarWithString() throws {
        
        // new String:
        XCTAssertEqual("a∑b".replacing(UnicodeScalar("∑"), with: "X∫"), "aX∫b")
                       
        // mutating:
        var text = "a∑b"
        text.replace(UnicodeScalar("∑"), with: "X∫")
        XCTAssertEqual(text, "aX∫b")
        
    }

    
    func testReplaceScalarsWithScalar() throws {
        
        let map: [UnicodeScalar:UnicodeScalar] = ["α": "β", "∑": "∫"]
        
        // new String:
        XCTAssertEqual("aα∑b".replacing(map), "aβ∫b")
        
        // mutating:
        var text = "aα∑b"
        text.replace(map)
        XCTAssertEqual(text, "aβ∫b")
        
    }
    
    func testReplaceScalarsWithString() throws {
        
        let map: [UnicodeScalar:String] = ["α": "Xβ", "∑": "Y∫"]
        
        // new String:
        XCTAssertEqual("aα∑b".replacing(map), "aXβY∫b")
        
        // mutating:
        var text = "aα∑b"
        text.replace(map)
        XCTAssertEqual(text, "aXβY∫b")
        
    }
    
    func testReplaceCodepointWithCodepoint() throws {
        
        // new String:
        XCTAssertEqual("a∑b".replacing(
            0x2211, // "∑"
            with: 0x222B // "∫"
        ), "a∫b")
        
        // mutating:
        var text = "a∑b"
        text.replace(
            0x2211, // "∑"
            with: 0x222B // "∫"
        )
        XCTAssertEqual(text, "a∫b")
        
    }
    
    func testReplaceCodepointWithString() throws {
        
        // new String:
        XCTAssertEqual(
            "a∑b".replacing(
                0x2211, // "∑"
                with: "X∫"
            ),
            "aX∫b"
        )
        
        // mutating:
        var text = "a∑b"
        text.replace(
            0x2211, // "∑"
            with: "X∫"
        )
        XCTAssertEqual(text, "aX∫b")
        
    }
    
    func testReplaceCodepointsWithCodepoint() throws {
        
        let map: [UInt32:UInt32] = [
            0x03B1: // "α"
                 0x03B2, // "β"
            0x2211: // "∑"
                0x222B // "∫"
        ]
        
        // new String:
        XCTAssertEqual("aα∑b".replacing(map), "aβ∫b")
        
        // mutating:
        var text = "aα∑b"
        text.replace(map)
        XCTAssertEqual(text, "aβ∫b")
        
    }
    
    func testReplaceCodepointsWithString() throws {
        
        let map: [UInt32:String] = [
            0x03B1: // "α"
                "Xβ",
            0x2211: // "∑"
                "Y∫"
        ]
        
        // new String:
        XCTAssertEqual("aα∑b".replacing(map), "aXβY∫b")
        
        // mutating:
        var text = "aα∑b"
        text.replace(map)
        XCTAssertEqual(text, "aXβY∫b")
        
    }
    
}

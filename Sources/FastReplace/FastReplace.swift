import Foundation

extension String {
    
    /// Create a string from a collection of `UnicodeScalar`.
    init<S: Sequence>(unicodeScalars ucs: S) where S.Iterator.Element == UnicodeScalar {
        var s = ""
        s.unicodeScalars.append(contentsOf: ucs)
        self = s
    }
    
}

public extension String {
    
    // ============ UnicodeScalar: ============
    
    // ------------ single: ------------
    
    /// Replace a UnicodeScalar with another UnicodeScalar.
    func replacing(_ source: UnicodeScalar, with value: UnicodeScalar) -> String {
        return String(unicodeScalars: self.unicodeScalars.map{ if $0 == source { value } else { $0 } })
    }
    
    /// Replace a UnicodeScalar with another UnicodeScalar.
    mutating func replace(_ source: UnicodeScalar, with value: UnicodeScalar) {
        self = self.replacing(source, with: value)
    }
    
    /// Replace a UnicodeScalar with a String.
    func replacing(_ source: UnicodeScalar, with value: String) -> String {
        let valueScalars = value.unicodeScalars
        var result = [UnicodeScalar]()
        for scalar in self.unicodeScalars {
            if scalar == source { result.append(contentsOf: valueScalars) } else { result.append(scalar) }
        }
        return String(unicodeScalars: result)
    }
    
    /// Replace a UnicodeScalar with a String.
    mutating func replace(_ source: UnicodeScalar, with value: String) {
        self = self.replacing(source, with: value)
    }
    
    // ------------ map: ------------
    
    /// Use a UnicodeScalar map to replace Unicode code points.
    func replacing(_ map: [UnicodeScalar:UnicodeScalar]) -> String {
        String(unicodeScalars: self.unicodeScalars.map{ map[$0] ?? $0 })
    }
    
    /// Use a UnicodeScalar map to replace Unicode code points.
    mutating func replace(_ map: [UnicodeScalar:UnicodeScalar]) {
        self = self.replacing(map)
    }
    
    /// Use a map to replace UnicodeScalars with Strings.
    func replacing(_ map: [UnicodeScalar:String]) -> String {
        var result = [UnicodeScalar]()
        for scalar in self.unicodeScalars {
            if let replacement = map[scalar] { result.append(contentsOf: replacement.unicodeScalars) } else { result.append(scalar) }
        }
        return String(unicodeScalars: result)
    }
    
    /// Use a map to replace UnicodeScalars with Strings.
    mutating func replace(_ map: [UnicodeScalar:String]) {
        self = self.replacing(map)
    }
    
    // ============ UInt32: ============
    
    // ------------ single: ------------
    
    /// Replace the Unicode code point represented by a UInt32 value with another Unicode code point represented by a UInt32 value.
    func replacing(_ source: UInt32, with value: UInt32) -> String {
        let uInt32Array = self.unicodeScalars.map{ if $0.value == source { value } else { $0.value } }
        let data = Data(bytes: uInt32Array, count: uInt32Array.count * MemoryLayout<UInt32>.stride)
#if _endian(little)
        return String(data: data, encoding: .utf32LittleEndian)!
#elseif _endian(big)
        return String(data: data, encoding: .utf32BigEndian)!
#endif
    }
    
    /// Replace the Unicode code point represented by a UInt32 value with another Unicode code point represented by a UInt32 value.
    mutating func replace(_ source: UInt32, with value: UInt32) {
        self = self.replacing(source, with: value)
    }
    
    /// Replace the Unicode code point represented by a UInt32 value with a String.
    func replacing(_ source: UInt32, with value: String) -> String {
        let sourceScalar = UnicodeScalar(source)!
        let valueScalars = value.unicodeScalars
        var result = [UnicodeScalar]()
        for scalar in self.unicodeScalars {
            if scalar == sourceScalar { result.append(contentsOf: valueScalars) } else { result.append(scalar) }
        }
        return String(unicodeScalars: result)
    }
    
    /// Replace the Unicode code point represented by a UInt32 value with a String.
    mutating func replace(_ source: UInt32, with value: String) {
        self = self.replacing(source, with: value)
    }
    
    // ------------ map: ------------
    
    /// Use a UInt32 map to replace Unicode code points.
    func replacing(_ map: [UInt32:UInt32]) -> String {
        let uInt32Array = self.unicodeScalars.map{ map[$0.value] ?? $0.value }
        let data = Data(bytes: uInt32Array, count: uInt32Array.count * MemoryLayout<UInt32>.stride)
#if _endian(little)
        return String(data: data, encoding: .utf32LittleEndian)!
#elseif _endian(big)
        return String(data: data, encoding: .utf32BigEndian)!
#endif
    }
    
    /// Use a UInt32 map to replace Unicode code points.
    mutating func replace(_ map: [UInt32:UInt32]) {
        self = self.replacing(map)
    }
    
    /// Use a map to replace UInt32 values with Strings.
    func replacing(_ map: [UInt32:String]) -> String {
        var result = [UnicodeScalar]()
        for scalar in self.unicodeScalars {
            if let replacement = map[scalar.value] { result.append(contentsOf: replacement.unicodeScalars) } else { result.append(scalar) }
        }
        return String(unicodeScalars: result)
    }
    
    /// Use a map to replace UInt32 values with Strings.
    mutating func replace(_ map: [UInt32:String]) {
        self = self.replacing(map)
    }
    
}

//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
import Foundation

/// Alphabet types
public enum Alphabet: String, Codable {
    case arabic
    case greek
    case greekExtended
    case latin
    case latinSupplementary
    case myanmar
    case russian
    case russianSupplementary

    /// A valid CountableClosedRange<UInt32> based on Self
    public var range: CountableClosedRange<UInt32> {
        switch self {
        case .arabic: return 0x600...0x6FF
        case .greek: return 0x370...0x3FF
        case .greekExtended: return 0x1F00...0x1FFF
        case .latin: return 0x20...0x7F
        case .latinSupplementary: return 0xA0...0xFF
        case .myanmar: return 0x1000...0x109F
        case .russian: return 0x400...0x4FF
        case .russianSupplementary: return 0x500...0x52F
        }
    }
}

//Special chars
public enum SpecialChar: UInt32 {
    case whiteSpace = 32
}

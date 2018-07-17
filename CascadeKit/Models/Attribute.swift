//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
import Foundation

/// Attribute struct to decorate an attribute string
public struct Attribute {
    public var key: NSAttributedStringKey
    public var value: Any
    public var range: CountableClosedRange<Int>

    public init(key: NSAttributedStringKey, value: Any, range: CountableClosedRange<Int>) {
        self.key = key
        self.value = value
        self.range = range
    }
}

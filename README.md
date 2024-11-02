# FastReplace

This package offers an efficient way to replace certain Unicode code points (either represented by `UnicodeScalar` or `UInt32`) with other values. Those methods might be more efficient than the replacement methods of the Swift standard library where grapheme clusters are considered (cf. the [FastReplaceBenchmarks](https://github.com/stefanspringer1/FastReplaceBenchmarks)).

Examples:

```swift
print("a∑b".replacing(UnicodeScalar("∑"), with: UnicodeScalar("∫")))
// prints "a∫b"
```

```swift
print("a∑b".replacing(
    0x2211, // "∑"
    with: "X∫"
))
// prints "aX∫b"
```

With the help of the [CodepointMacro](https://github.com/stefanspringer1/CodepointMacro), you could write the second example as:

```swift
print("a∑b".replacing(
    #codepoint("∑"),
    with: "X∫"
))
// prints "aX∫b"
```

There also is the [CodepointForEntityMacro](https://github.com/stefanspringer1/CodepointForEntityMacro)) which replaces the usual named character references by the code point.

Very fast should be the replacements that use a dictionary:

```swift
 text.replacing([
    #codepointForEntity("&frac12;"): " 1 / 2 ",
    #codepointForEntity("&frac13;"): " 1 / 3 ",
    #codepointForEntity("&frac14;"): " 1 / 4 ",
    #codepointForEntity("&frac34;"): " 3 / 4 ",
    #codepointForEntity("&frac18;"): " 1 / 8 ",
    #codepointForEntity("&frac38;"): " 3 / 8 ",
    #codepointForEntity("&frac58;"): " 5 / 8 ",
    #codepointForEntity("&frac78;"): " 7 / 8 ",
])
```

You can find benchmarks with comparisons to the usual replacement operations in [CodepointMacroBenchmarks](https://github.com/stefanspringer1/CodepointMacroBenchmarks).

Note that when you need to use a regular expression, you already can switch to a scalar mode, example:

```swift
/[\x{0301}\x{0307}]/.matchingSemantics(.unicodeScalar)
```

## Duplicate keys produced by a macro

Be careful not to produce duplicate keys by using e.g. the `#codepoint` or `#codepointForEntity` macro: The following code compiles without a warning (at least with Swift version 6.0.0, cf. the [bug report](https://github.com/swiftlang/swift/issues/77318)):

```swift
 text.replacing([
    #codepointForEntity("&half;"): " 1 / 2 ",
    #codepointForEntity("&frac12;"): " 1 / 2 ",
    #codepointForEntity("&frac13;"): " 1 / 3 ",
])
```

But `#codepointForEntity("&half;")` and `#codepointForEntity("&frac12;")` are both expanded to `0xBD`, so we have defined a dictionary with duplicate keys. If you used this value directly as keys, this would produce the warning “Dictionary literal of type '[UInt32 : String]' has duplicate entries for integer literal key '0xBD'”. The lack of warning in the case of the macro usage is fatal, because during the run the program then crashes with a `Trace/BPT trap ...` error.

# FastReplace

This package offers an efficient way to replace certain Unicode code points (either represented by `UnicodeScalar` or `UInt32`) with other values. It is more efficient than the replacement methods of the Swift standard library because there grapheme clusters are considered.

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

You can find benchmarks with comparisons to the usual replacement operations in [CodepointMacroBenchmarks](https://github.com/stefanspringer1/CodepointMacroBenchmarks).

Note that when you need to use a regular expression, you already can switch to a scalar mode (example: `/[\x{0301}\x{0307}]/.matchingSemantics(.unicodeScalar)`.)

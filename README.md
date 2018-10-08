# CascadeKit
**CascadeKit** is a library to apply styles to UIKit text controls based on the content language (to be precise, to the *content script*).

You can read more about this library on our [Company Medium Blog](https://medium.com/ynap-tech/our-approach-to-empowering-nsattributedstring-f6ecab72b9a9).

## Build Status

| Branch | Status |
| ------------- | ------------- |
| Master | [![BuddyBuild](https://travis-ci.com/YTech/CascadeKit.svg?token=KFPPSquwqxaQf8SA7t7K&branch=master)](https://travis-ci.com/YTech/CascadeKit) |

# Table of Contents
1. [How to use CascadeKit](#how-to-use-cascadekit)
2. [How to install CascadeKit](#how-to-install-cascadekit)
3. [How to contribute](#how-to-contribute)
4. [License and Credits](#license-and-credits)

# How to use CascadeKit

CascadeKit let you to easily apply UI customizations based on text content. Let's say you want to apply a blue color to Latin characters and a red color to Russian ones:

```swift
let mutAttrString = NSMutableAttributedString(string: text, attributes: originalAttributes)

let newAttr = mutAttrString.addAttributes(for: [.latin, .russian, .russianSupplementary], including: [.whiteSpace]) { (fallback) -> [Attribute] in

    switch fallback.type {
        case .latin:
            return [
                Attribute(key: .foregroundColor, value: UIColor.blue, range: fallback.range)]
        case .russian, .russianSupplementary:
            return [Attribute(key: .foregroundColor, value: red, range: fallback.range)]
        default:
            return []
    }
}

textView.attributedText = newAttr

```
Easy, right?


We can enhance the example, applying more and more customisations to the Attributed String like

1. Greek :
    - foreground color = blue
    - font = Helvetica Neue, 15
2. Russian:
    - background color = red
    - foreground color = white
    - font = Courier, 18

```swift
let mutAttrString = NSMutableAttributedString(string: text, attributes: originalAttributes)

let newAttr = mutAttrString.addAttributes(for: [.greek, .greekExtended, .russian, .russianSupplementary], including: [.whiteSpace]) { (fallback) -> [Attribute] in

    switch fallback.type {
        case .greek, .greekExtended:
            return [
                Attribute(key: .foregroundColor, value: UIColor.blue, range: fallback.range),
                Attribute(key: .font, value: UIFont(name: "Helvetica Neue", size: 15), range: fallback.range)]
        case .russian, .russianSupplementary:
            return [
                Attribute(key: .backgroundColor, value: UIColor.red, range: fallback.range),
                Attribute(key: .foregroundColor, value: UIColor.white, range: fallback.range),
                Attribute(key: .font, value: UIFont(name: "Courier", size: 18), range: fallback.range)]
        default:
            return []
    }
}

textView.attributedText = newAttr

```

So the steps to setup your custom rules are:
- define the list of alphabets your UI needs to focus on, i.e.
```swift
let myAlphabets = [.greek, .greekExtended, .russian, .russianSupplementary]
```
- implement your custom rules into the `addAttributes` callback

Your beautifully crafted content is ready to be diplayed in each language of the world! ☺️

# How to install CascadeKit
## CocoaPods
Add CascadeKit to your Podfile

```ruby
use_frameworks!
target 'MyTarget' do
pod 'CascadeKit', '~> 1.2.1'
end
```

```bash
$ pod install
```

## Add CascadeKit source code to your project
Add [CascadeKit folder](https://github.com/YTech/CascadeKit/tree/master/CascadeKit)  to your project.

# How to contribute
Contributions are greatly welcome 🙌  If you'd like to improve this projects, just open an issue or raise a PR from the current develop branch.

For any information or request feel free open an [ISSUE](https://github.com/YTech/CascadeKit/issues).

# License and Credits
## License:
CascadeKit is available under the MIT license. See the [LICENSE](https://github.com/YTech/CascadeKit/blob/master/LICENSE) file for more info.

## CascadeKit on the Web:
- [YNAP Tech - Medium Blog](https://medium.com/ynap-tech/our-approach-to-empowering-nsattributedstring-f6ecab72b9a9)

import Foundation

extension String {
  private static let emojiPattern =
    "[\u{fe0f}\u{00A9}\u{00AE}\u{203C}\u{200d}\u{2049}\u{2122}\u{2139}\u{2194}-\u{2199}\u{21A9}-\u{21AA}\u{231A}-\u{231B}\u{2328}\u{23CF}\u{23E9}-\u{23F3}\u{23F8}-\u{23FA}\u{24C2}\u{25AA}-\u{25AB}\u{25B6}\u{25C0}\u{25FB}-\u{25FE}\u{2600}-\u{2604}\u{260E}\u{2611}\u{2614}-\u{2615}\u{2618}\u{261D}\u{2620}\u{2622}-\u{2623}\u{2626}\u{262A}\u{262E}-\u{262F}\u{2638}-\u{263A}\u{2642}-\u{2653}\u{2660}\u{2663}\u{2665}-\u{2666}\u{2668}\u{267B}\u{267F}\u{2692}-\u{2694}\u{2696}-\u{2697}\u{2699}\u{269B}-\u{269C}\u{26A0}-\u{26A1}\u{26AA}-\u{26AB}\u{26B0}-\u{26B1}\u{26BD}-\u{26BE}\u{26C4}-\u{26C5}\u{26C8}\u{26CE}-\u{26CF}\u{26D1}\u{26D3}-\u{26D4}\u{26E9}-\u{26EA}\u{26F0}-\u{26F5}\u{26F7}-\u{26FA}\u{26FD}\u{2702}\u{2705}\u{2708}-\u{270D}\u{270F}\u{2712}\u{2714}\u{2716}\u{271D}\u{2721}\u{2728}\u{2733}-\u{2734}\u{2742}\u{2744}\u{2747}\u{274C}\u{274E}\u{2753}-\u{2755}\u{2757}\u{2763}-\u{2764}\u{2795}-\u{2797}\u{27A1}\u{27B0}\u{27BF}\u{2934}-\u{2935}\u{2B05}-\u{2B07}\u{2B1B}-\u{2B1C}\u{2B50}\u{2B55}\u{3030}\u{303D}\u{3297}\u{3299}\u{1F004}\u{1F0CF}\u{1F170}-\u{1F171}\u{1F17E}-\u{1F17F}\u{1F18E}\u{1F191}-\u{1F19A}\u{1F201}-\u{1F202}\u{1F21A}\u{1F22F}\u{1F232}-\u{1F23A}\u{1F250}-\u{1F251}\u{1F300}-\u{1F321}\u{1F324}-\u{1F393}\u{1F396}-\u{1F397}\u{1F399}-\u{1F39B}\u{1F39E}-\u{1F3F0}\u{1F3F3}-\u{1F3F5}\u{1F3F7}-\u{1F4FD}\u{1F4FF}-\u{1F53D}\u{1F549}-\u{1F54E}\u{1F550}-\u{1F567}\u{1F56F}-\u{1F570}\u{1F573}-\u{1F579}\u{1F587}\u{1F58A}-\u{1F58D}\u{1F590}\u{1F595}-\u{1F596}\u{1F5A5}\u{1F5A8}\u{1F5B1}-\u{1F5B2}\u{1F5BC}\u{1F5C2}-\u{1F5C4}\u{1F5D1}-\u{1F5D3}\u{1F5DC}-\u{1F5DE}\u{1F5E1}\u{1F5E3}\u{1F5EF}\u{1F5F3}\u{1F5FA}-\u{1F64F}\u{1F680}-\u{1F6C5}\u{1F6CB}-\u{1F6D0}\u{1F6E0}-\u{1F6E5}\u{1F6E9}\u{1F6EB}-\u{1F6EC}\u{1F6F0}\u{1F6F3}\u{1F910}-\u{1F918}\u{1f937}\u{1F980}-\u{1F984}\u{1F9C0}]+"

  private static let overqualifiedEmoji = [
    "\u{1F91D}\u{1F3FB}", "\u{1F91D}\u{1F3FC}", "\u{1F91D}\u{1F3FD}", "\u{1F91D}\u{1F3FE}",
    "\u{1F91D}\u{1F3FF}",
    "\u{1F93C}\u{1F3FB}", "\u{1F93C}\u{1F3FC}", "\u{1F93C}\u{1F3FD}", "\u{1F93C}\u{1F3FE}",
    "\u{1F93C}\u{1F3FF}",
    "\u{231A}\u{FE0F}", "\u{231B}\u{FE0F}", "\u{25FE}\u{FE0F}", "\u{2614}\u{FE0F}",
    "\u{2615}\u{FE0F}",
    "\u{2648}\u{FE0F}", "\u{2649}\u{FE0F}", "\u{264A}\u{FE0F}", "\u{264B}\u{FE0F}",
    "\u{264C}\u{FE0F}",
    "\u{264D}\u{FE0F}", "\u{264E}\u{FE0F}", "\u{264F}\u{FE0F}", "\u{2650}\u{FE0F}",
    "\u{2651}\u{FE0F}",
    "\u{2652}\u{FE0F}", "\u{2653}\u{FE0F}", "\u{267F}\u{FE0F}", "\u{26AA}\u{FE0F}",
    "\u{26BD}\u{FE0F}",
    "\u{26BE}\u{FE0F}", "\u{26C4}\u{FE0F}", "\u{26F2}\u{FE0F}", "\u{26F3}\u{FE0F}",
    "\u{26F5}\u{FE0F}",
    "\u{26FA}\u{FE0F}", "\u{2757}\u{FE0F}", "\u{2B1B}\u{FE0F}", "\u{2B1C}\u{FE0F}",
    "\u{2B55}\u{FE0F}",
    "\u{1F004}\u{FE0F}",
  ]

  func stripEmoji() -> String {
    let str = self

    let combinedPattern =
      String.emojiPattern + "|" + String.overqualifiedEmoji.joined(separator: "|")
    do {
      let regex = try NSRegularExpression(pattern: combinedPattern, options: [])
      let range = NSRange(location: 0, length: str.utf16.count)
      return regex.stringByReplacingMatches(in: str, options: [], range: range, withTemplate: "")
    } catch {
      return self
    }
  }
}

//// Examples:
//
// func printExampleStrings() {
//   let examples = [
//     "👩‍👩‍👧‍👦 fun🤝🏽",
//     "👩‍👩‍👧‍👦⛲️🀄️",
//     "Hello, world! 🌍",
//     "No emojis here!",
//     "Mixed 🎉 text 📝 with emojis 🚀",
//   ]

//   for example in examples {
//     print("Original: \(example)")
//     print("Stripped: \(example.stripEmoji())")
//     print("---")
//   }
// }

// printExampleStrings()

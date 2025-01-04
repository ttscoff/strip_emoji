#!/usr/bin/env ruby
# Remove all emoji from a string, including Apple's new overqualified emoji.
#
# Hat tip to mathiasbynens
# <https://github.com/mathiasbynens/emoji-test-regex-pattern/blob/main/script/get-sequences.js>

# String extension for emoji stripping
class ::String
  EMOJI_RX = /[\u{fe0f}\u{00A9}\u{00AE}\u{203C}\u{200d}\u{2049}\u{2122}\u{2139}\u{2194}-\u{2199}\u{21A9}-\u{21AA}\u{231A}-\u{231B}\u{2328}\u{23CF}\u{23E9}-\u{23F3}\u{23F8}-\u{23FA}\u{24C2}\u{25AA}-\u{25AB}\u{25B6}\u{25C0}\u{25FB}-\u{25FE}\u{2600}-\u{2604}\u{260E}\u{2611}\u{2614}-\u{2615}\u{2618}\u{261D}\u{2620}\u{2622}-\u{2623}\u{2626}\u{262A}\u{262E}-\u{262F}\u{2638}-\u{263A}\u{2642}-\u{2653}\u{2660}\u{2663}\u{2665}-\u{2666}\u{2668}\u{267B}\u{267F}\u{2692}-\u{2694}\u{2696}-\u{2697}\u{2699}\u{269B}-\u{269C}\u{26A0}-\u{26A1}\u{26AA}-\u{26AB}\u{26B0}-\u{26B1}\u{26BD}-\u{26BE}\u{26C4}-\u{26C5}\u{26C8}\u{26CE}-\u{26CF}\u{26D1}\u{26D3}-\u{26D4}\u{26E9}-\u{26EA}\u{26F0}-\u{26F5}\u{26F7}-\u{26FA}\u{26FD}\u{2702}\u{2705}\u{2708}-\u{270D}\u{270F}\u{2712}\u{2714}\u{2716}\u{271D}\u{2721}\u{2728}\u{2733}-\u{2734}\u{2742}\u{2744}\u{2747}\u{274C}\u{274E}\u{2753}-\u{2755}\u{2757}\u{2763}-\u{2764}\u{2795}-\u{2797}\u{27A1}\u{27B0}\u{27BF}\u{2934}-\u{2935}\u{2B05}-\u{2B07}\u{2B1B}-\u{2B1C}\u{2B50}\u{2B55}\u{3030}\u{303D}\u{3297}\u{3299}\u{1F004}\u{1F0CF}\u{1F170}-\u{1F171}\u{1F17E}-\u{1F17F}\u{1F18E}\u{1F191}-\u{1F19A}\u{1F201}-\u{1F202}\u{1F21A}\u{1F22F}\u{1F232}-\u{1F23A}\u{1F250}-\u{1F251}\u{1F300}-\u{1F321}\u{1F324}-\u{1F393}\u{1F396}-\u{1F397}\u{1F399}-\u{1F39B}\u{1F39E}-\u{1F3F0}\u{1F3F3}-\u{1F3F5}\u{1F3F7}-\u{1F4FD}\u{1F4FF}-\u{1F53D}\u{1F549}-\u{1F54E}\u{1F550}-\u{1F567}\u{1F56F}-\u{1F570}\u{1F573}-\u{1F579}\u{1F587}\u{1F58A}-\u{1F58D}\u{1F590}\u{1F595}-\u{1F596}\u{1F5A5}\u{1F5A8}\u{1F5B1}-\u{1F5B2}\u{1F5BC}\u{1F5C2}-\u{1F5C4}\u{1F5D1}-\u{1F5D3}\u{1F5DC}-\u{1F5DE}\u{1F5E1}\u{1F5E3}\u{1F5EF}\u{1F5F3}\u{1F5FA}-\u{1F64F}\u{1F680}-\u{1F6C5}\u{1F6CB}-\u{1F6D0}\u{1F6E0}-\u{1F6E5}\u{1F6E9}\u{1F6EB}-\u{1F6EC}\u{1F6F0}\u{1F6F3}\u{1F910}-\u{1F918}\u{1f937}\u{1F980}-\u{1F984}\u{1F9C0}]+/.freeze
  OVERQUALIFIED = [
    "\u{1F91D}\u{1F3FB}", # handshake: light skin
    "\u{1F91D}\u{1F3FC}", # handshake: medium-light skin
    "\u{1F91D}\u{1F3FD}", # handshake: medium skin
    "\u{1F91D}\u{1F3FE}", # handshake: medium-dark skin
    "\u{1F91D}\u{1F3FF}", # handshake: dark skin

    "\u{1F93C}\u{1F3FB}", # wrestlers: light skin
    "\u{1F93C}\u{1F3FC}", # wrestlers: medium-light skin
    "\u{1F93C}\u{1F3FD}", # wrestlers: medium skin
    "\u{1F93C}\u{1F3FE}", # wrestlers: medium-dark skin
    "\u{1F93C}\u{1F3FF}", # wrestlers: dark skin

    # Overqualified emoji sequences as entered via the iOS emoji picker.
    "\u231A\uFE0F", # watch
    "\u231B\uFE0F", # hourglass
    "\u25FE\uFE0F", # black medium small square
    "\u2614\uFE0F", # umbrella with rain drops
    "\u2615\uFE0F", # hot beverage
    "\u2648\uFE0F", # Aries
    "\u2649\uFE0F", # Taurus
    "\u264A\uFE0F", # Gemini
    "\u264B\uFE0F", # Cancer
    "\u264C\uFE0F", # Leo
    "\u264D\uFE0F", # Virgo
    "\u264E\uFE0F", # Libra
    "\u264F\uFE0F", # Scorpius
    "\u2650\uFE0F", # Sagittarius
    "\u2651\uFE0F", # Capricorn
    "\u2652\uFE0F", # Aquarius
    "\u2653\uFE0F", # Pisces
    "\u267F\uFE0F", # wheelchair symbol
    "\u26AA\uFE0F", # medium white circle
    "\u26BD\uFE0F", # soccer ball
    "\u26BE\uFE0F", # baseball
    "\u26C4\uFE0F", # snowman without snow
    "\u26F2\uFE0F", # fountain
    "\u26F3\uFE0F", # flag in hole
    "\u26F5\uFE0F", # sailboat
    "\u26FA\uFE0F", # tent
    "\u2757\uFE0F", # heavy exclamation mark symbol
    "\u2B1B\uFE0F", # black large square
    "\u2B1C\uFE0F", # white large square
    "\u2B55\uFE0F", # heavy large circle
    "\u{1F004}\uFE0F", # mahjong tile red dragon
  ].freeze

  def strip_emoji
    str = strip.force_encoding("UTF-8")
    OVERQUALIFIED.each do |emoji|
      str = str.gsub(/#{emoji}/, "")
    end
    str.gsub(EMOJI_RX, "")
  end
end

# Example usage:
#   "👩‍👩‍👧‍👦 fun🤝🏽".strip_emoji.strip
#   # => "fun"
#   "👩‍👩‍👧‍👦⛲️🀄️".strip_emoji.length
#   # => 0

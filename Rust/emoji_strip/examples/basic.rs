use emoji_strip::EmojiStrip;

fn main() {
    let text = "Hello 👋 World 🌍!";
    println!("Original: {}", text);
    println!("Stripped: {}", text.strip_emoji());
}
import Foundation

struct MenuQuotes {
    let menuQuotes = [
        "“All you need is the plan, the road map, and the courage to press on to your destination.” —Earl Nightingale",
        "“You can have it all. Just not all at once.” —Oprah Winfrey",
        "“Stay positive. Better days are on their way.“ —Unknown",
        "“Keep your face always toward the sunshine—and shadows will fall behind you.” —Walt Whitman",
        "“Extraordinary things are always hiding in places people never think to look.” —Jodi Picoul",
        "“Setting goals is the first step in turning the invisible into the visible.” —Tony Robbins",
        "“Say something positive, and you’ll see something positive.” —Jim Thompson",
        "“Train your mind to see the good in every situation.“ —Unknown",
        "“If you can stay positive in a negative situation, you win.“ —Unknown",
        "“Only in the darkness can you see the stars.“ —Martin Luther King, Jr.",
        "“A goal is not always meant to be reached, it often serves simply as something to aim at.” – Bruce Lee",
        "“Be yourself and people will like you.“ - Jeff Kinney"
    ]
    
    func getRandomQuote() -> String {
        return menuQuotes.randomElement() ?? "There seems to be a problem..."
    }
}

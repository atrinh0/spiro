<p align="center"><img src="images/icon.png" width="200"></p>

<p align="center">
    <img src="https://img.shields.io/badge/iOS-15.2+-blue.svg" />
    <img src="https://img.shields.io/badge/Swift%20Playgrounds-4.0-red.svg" />
    <img src="https://img.shields.io/badge/Xcode-13.2.1+-brightgreen.svg" />
    <img src="https://img.shields.io/badge/Swift-5.5-orange.svg" />
</p>

# Spiro

Swift Playgrounds 4 app created on the iPad^.

> ^ Xcode also used as explained below.

<p><a href="https://apps.apple.com/us/app/id1602980337"><img src="web/images/download.svg"></a></p>

<img src="images/demo.gif" width="320">

### 🏙 Screenshots

<img src="web/images/hero1.png" width="320">&nbsp;&nbsp;&nbsp;<img src="web/images/hero2.png" width="320">

### 🤔 What is Spiro?

An interactive animating spirograph generator.

I wanted to create an app to explore the development and deployment experience of Swift Playgrounds 4 on the iPad.

### 🧐 Why open source?

To share learnings. 

To show how powerful/easy SwiftUI can be to create an app, especially now with Swift Playgrounds 4.

Most of the code was obtained from [Creating a spirograph with SwiftUI](https://www.hackingwithswift.com/books/ios-swiftui/creating-a-spirograph-with-swiftui), so it makes sense to keep things transparent/open and hope it can help someone else out there.

## 🙇🏻 Credits

Huge sincere thanks goes to [Paul Hudson](https://twitter.com/twostraws) and his [100 days of SwiftUI](https://www.hackingwithswift.com/100/swiftui) series where I have learnt most of my SwiftUI knowledge. 

The code to draw these lovely hypotrochoids was obtained from
https://www.hackingwithswift.com/books/ios-swiftui/creating-a-spirograph-with-swiftui

## 🧑🏻‍💻 Getting Started

### Swift Playgrounds 4 on iPad 

There are many different methods to get `Spiro.swiftpm` to run on Swift Playgrounds 4 on the iPad.

Method | Steps
-- | --
Share from macOS via AirDrop | Clone this repo, share the `Spiro.swiftpm` via AirDrop to your iPad, it will open on Swift Playgrounds 4 on the iPad.
Share using iCloud Drive | Clone this repo, copy `Spiro.swiftpm` into your iCloud Drive, on the iPad open Swift Playgrounds 4, tap on `Locations` and locate it within iCloud Drive.
Working copy app (using just the iPad) | Download https://apps.apple.com/us/app/working-copy/id896694807, Clone this repo within the working copy app, Open Swift Playgrounds 4 and working copy side by side using multitasking, Drag `Spiro.swiftpm` from working copy into "My Playgrounds".

### 💻 Xcode on macOS

Open `Spiro.swiftpm` via Xcode. Playgrounds 4 app running on macOS cannot open the project.

## 🧑🏻‍🏫 Learnings

Here are some things I've learnt along the way.

### ☁️ iCloud vs git



### 🙊 Swift Playgrounds 4 limitations



### 🥺 Submission issues



### 🤔 Development on Xcode



### 🤓 Minimum deployment target



### ☁️ Xcode Cloud?



## 🚀 What is next?

Just some ideas to further improve this project.

Thing | Description
-- | --
Canvas | https://developer.apple.com/documentation/swiftui/canvas to optimise drawing performance.
Smoother animations | The primary animation is performed by linearly incrementing or decrementing the distance. This will be smoother and provide an ease in ease out effect by using the values of a sine wave (improving that jarring sudden shift in direction).
Infinite animation | Super imposing 2 spirographs offset by half of the animation (so they both fade in, grow, and fade out) will make the animations appear like an infinite zoom effect.
Amount scroller | Using the `amount` field on the spirograph, we can show the gradual drawing effect to create the spirograph, this could be a nice addition to restore but directly conflicts with the primary animation.


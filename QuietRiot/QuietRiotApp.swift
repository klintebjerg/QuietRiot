import SwiftUI

@main
struct QuietRiotApp: App {
    var body: some Scene {
        MenuBarExtra("QuietRiot", systemImage: "speaker.wave.2.fill") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
    }
}

import SwiftUI

@main
struct MainApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
          TabBarView()
        }
    }
}

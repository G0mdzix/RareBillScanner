import FunctionalitySwiftEnhancement
import AestheticKit
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  @Injected(\.themeConfiguratorProvider)
  private var themeConfigurator: ThemeConfigurating

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = UIHostingController(rootView: TabBarView())
    window?.makeKeyAndVisible()

    Task { configureAppTheme() }
  }

  func sceneDidDisconnect(_ scene: UIScene) {}

  func sceneDidBecomeActive(_ scene: UIScene) {}

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate {
  private func configureAppTheme() {
    themeConfigurator.configureTheme(for: window)
    themeConfigurator.onColorSchemeChanged = { [weak self] in
      guard let self else { return }
      themeConfigurator.configureTheme(for: window)
    }
  }
}

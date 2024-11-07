import SwiftUI
import AestheticKit
import FunctionalitySwiftEnhancement

final class ThemeViewModel: ObservableObject {
  
  @Injected(\.themeConfigurationUserDefaultsProvider)
  private var themeUserDefaults: ThemeConfigurationUserDefaultsProtocol

  @Published var selectedTheme: Theme = .current {
    didSet {
      themeSchemeChanged()
      changeTheme(selected: ThemeViewModel.configureSelector(currentTheme: selectedTheme))
      themeUserDefaults.setAppTheme(selectedTheme)
    }
  }

  var theme: Theme {
    get {
      .current
    }
    set {
      Theme.current = newValue
      themeSchemeChanged()
    }
  }

  private func themeSchemeChanged() {
    NotificationCenter.default.post(
      name: .appThemeChanged,
      object: nil,
      userInfo: ["colorScheme": colorScheme(from: Theme.current) as Any]
    )
  }

  private func changeTheme(selected: Int) {
    switch selected {
    case 0:
      theme = Theme.light
    case 1:
      theme = Theme.dark
    default:
      theme = Theme.auto
    }
  }

  private func colorScheme(from theme: Theme) -> Any? {
    var result: ColorScheme?
    switch theme {
    case .light:
      result = .light
    case .dark:
      result = .dark
    case .auto:
      result = nil
    }
    return result
  }

  private static func configureSelector(currentTheme: Theme) -> Int {
      var theme: Int
      switch currentTheme {
      case .light:
        theme = 0
      case .dark:
        theme = 1
      case .auto:
        theme = 2
      }
      return theme
  }
}

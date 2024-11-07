import SwiftUI
import AestheticKit

final class SettingsViewModel: ObservableObject {
  
  @Published var shouldShowThemeBottomSheet = false
  
  var preferencesSection: [SettingsMenuModel] {
    [
      SettingsMenuModel(title: "Language", icon: SFSymbols.globe.rawValue, action: {}),
      SettingsMenuModel(title: "Change Theme", icon: SFSymbols.sun.rawValue, action: { [weak self] in
        guard let self else { return }
        shouldShowThemeBottomSheet = true
      })
    ]
  }
  
  var informationSection: [SettingsMenuModel] {
    [
      SettingsMenuModel(title: "About the app", icon: "info.circle", action: {}),
      SettingsMenuModel(title: "Contact us", icon: "phone.bubble", action: {}),
      SettingsMenuModel(title: "Rate the app", icon: "star", action: {}),
      SettingsMenuModel(title: "Terms of Service", icon: "doc.text", action: {})
    ]
  }
  
  var permissionsSection: [SettingsMenuModel] {
    [
      SettingsMenuModel(title: "Favorites", icon: SFSymbols.moon.rawValue, action: {}),
      SettingsMenuModel(title: "App permissions", icon: SFSymbols.moon.rawValue, action: {})
    ]
  }
}

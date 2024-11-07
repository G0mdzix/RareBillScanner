import AestheticKit
import SwiftUI

enum TabBarTab: String, CaseIterable {
  case dashboard
  case scanner
  case settings

  var index: Int {
    TabBarTab.allCases.firstIndex(of: self) ?? 0
  }

  var image: Image {
    switch self {
    case .dashboard:
      Image(systemName: SFSymbols.dashboard.rawValue)
    case .settings:
      Image(systemName: SFSymbols.gear.rawValue)
    case .scanner:
      Image(systemName: SFSymbols.camera.rawValue)
    }
  }

  var title: String {
    switch self {
    case .dashboard:
      "Dashboard"
    case .settings:
      "Settings"
    case .scanner:
      "Scanner"
    }
  }

  var view: AnyView {
    switch self {
    case .dashboard:
      AnyView(DashboardView())
    case .settings:
      AnyView(SettingsView())
    case .scanner:
      AnyView(ScannerView())
    }
  }
}

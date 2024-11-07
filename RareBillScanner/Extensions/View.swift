import SwiftUI

extension View {
  func shouldHideTabBar(_ hide: Bool) -> some View {
    self
      .task {
        NotificationCenter.default.post(name: .tabBarVisibilityChanged, object: hide)
      }
  }
  
  func shouldChangeTab(_ tab: TabBarTab, shouldChangeTab: Bool) -> some View {
    self
      .onChange(of: shouldChangeTab) { _ in
        NotificationCenter.default.post(name: .tabBarCurrentTabChanged, object: tab)
      }
  }
}

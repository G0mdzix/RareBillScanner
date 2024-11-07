import SwiftUI
import AestheticKit

struct TabBarView: View {

  @State private var isTabBarHidden = true
  @State private var currentTab: TabBarTab = .dashboard {
    didSet {
      isTabBarHidden = isTabBarHidden ? true : true
    }
  }
  
  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $currentTab) {
        currentTab.view
          .tag(currentTab.rawValue)
      }
      
      RBSTabBar(currentTab: $currentTab)
        .display(if: isTabBarHidden)
    }
    .onReceive(NotificationCenter.default.publisher(for: .tabBarCurrentTabChanged)) { notification in
      if let choosenTab = notification.object as? TabBarTab {
        currentTab = choosenTab
      }
    }
    .onReceive(NotificationCenter.default.publisher(for: .tabBarVisibilityChanged)) { notification in
      if let hide = notification.object as? Bool {
        isTabBarHidden = !hide
      }
    }
    .onAppear {
      UITabBar.appearance().isHidden = true
    }
  }
}

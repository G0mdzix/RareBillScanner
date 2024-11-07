import AestheticKit
import SwiftUI

struct RBSTabBar: View {

  @Binding private var currentTab: TabBarTab

  @State private var yOffset: CGFloat = 0
  @State private var firstIconPosition: CGFloat = 0
  @State private var isAnimating = false

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: Constants.tabBarCornerRadius)
        .fill(LinearGradient(
          gradient: Gradient(colors: [Color.main, Color.secondaryApp]),
          startPoint: .top,
          endPoint: .bottom
        ))
        .stroke(Color.textSecondary, lineWidth: Constants.strokeLineWidth)
        .frame(width: UIScreen.main.bounds.size.width - DefaultSpacings.medium, height: Constants.tabBarHeight)

      tabBarButtonsStack
    }
  }
  
  private var indicatorOffset: CGFloat {
    CGFloat(currentTab.index) * (
      (UIScreen.main.bounds.size.width -
        ((firstIconPosition + Constants.circleSize / 2) * 2)) /
      (Constants.allTabsCount - 1)
    )
  }
    
  private var tabBarButtonsStack: some View {
    HStack(spacing: 0) {
      ForEach(TabBarTab.allCases, id: \.self) { tab in
        tabBarButton(for: tab)
      }
    }
    .frame(maxWidth: .infinity)
    .frame(height: Constants.tabBarButtonsHeight)
    .padding(.bottom, DefaultSpacings.small)
    .padding([.horizontal, .top])
    .background(alignment: .leading) {
      circleIconBackground
    }
  }
    
  private var circleIconBackground: some View {
    Circle()
      .fill(Color.mainBackground)
      .frame(width: Constants.circleSize, height: Constants.circleSize)
      .offset(x: firstIconPosition, y: yOffset + 3)
      .offset(x: indicatorOffset)
      .shadow(color: Color.textPrimary, radius: DefaultSpacings.small)
  }

  init(currentTab: Binding<TabBarTab>) {
    self._currentTab = currentTab
  }

  private func tabBarButton(for tab: TabBarTab) -> some View {
    Button {
      withAnimation(.smooth(duration: 0.2)) {
        currentTab = tab
        yOffset = Constants.yOffset
        isAnimating.toggle()
      }
      withAnimation(.smooth(duration: 0.1).delay(0.07)) {
        yOffset = 0
      }
    } label: {
      VStack(spacing: .zero) {
        tab.image
          .renderingMode(.template)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: Constants.circleSize / 2, height: Constants.circleSize / 2)
          .frame(maxWidth: .infinity)
          .bold()
          .foregroundColor(Color.textPrimary)
          .scaleEffect(currentTab == tab ? Constants.scaleBiggerEffect : Constants.scaleSmallerEffect)
          .geometryReader {
              firstIconPosition = ($0.midX - Constants.circleSize / 2)
          }

        if currentTab != tab {
          Text(tab.title)
            .transition(.opacity.animation(.smooth(duration: Constants.transitionDuration)))
            .font(.caption)
            .fontWeight(.bold)
            .tint(Color.textPrimary)
            .padding(.top, DefaultSpacings.small / 2)
        }
      }
    }
  }
}

private enum Constants {
  static let circleSize: CGFloat = 50
  static let allTabsCount: CGFloat = CGFloat(TabBarTab.allCases.count)
  static let tabBarHeight: CGFloat = 75
  static let tabBarButtonsHeight: CGFloat = 30
  static let scaleBiggerEffect: CGFloat = 1.5
  static let scaleSmallerEffect: CGFloat = 1.25
  static let transitionDuration: Double = 0.3
  static let tabBarCornerRadius: CGFloat = 25
  static let strokeLineWidth: CGFloat = 2
  static let yOffset: CGFloat = -60
}

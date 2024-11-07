import SwiftUI
import AestheticKit

struct ThemeView: View {

  @StateObject private var viewModel = ThemeViewModel()

  @State private var animationsRunning = false

  var body: some View {
    VStack(spacing: .zero) {
      Text("Theme mode")
        .font(.title)
        .fontWeight(.bold)
        .padding(.top, DefaultSpacings.medium)
        .fixedSize(horizontal: true, vertical: true)

      Text("Wybierz tryb aplikacji")
        .font(.title3)
        .fontWeight(.semibold)
        .padding(.top, DefaultSpacings.medium)
        .padding(.bottom, DefaultSpacings.medium)

      themeSegmentPicker
        .padding(.bottom, DefaultSpacings.large)
    }
    .padding(.horizontal, 16)
  }

  private var themeSegmentPicker: some View {
    ThemePickerView(mainColor: .main)
  }

  private func createIcon(_ theme: Theme) -> Image {
    viewModel.selectedTheme == theme ? theme.primaryImage : theme.secondaryImage
  }
}

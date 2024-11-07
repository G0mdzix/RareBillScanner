import SwiftUI
import AestheticKit

struct SettingsView: View {
  
  @StateObject private var viewModel = SettingsViewModel()

  var body: some View {
    ZStack {
      Color.mainBackground.ignoresSafeArea()
      
      NavigationView {
        Form {
          userProfileSection
          
          genericSettingsSection(title: "Preferences", content: viewModel.preferencesSection)
          
          genericSettingsSection(title: "PERMISSIONS", content: viewModel.permissionsSection)

          genericSettingsSection(title: "INFO", content: viewModel.informationSection)
        }
        .navigationBarTitle("Settings")
        .bottomSheet(
          isPresented: $viewModel.shouldShowThemeBottomSheet,
          backgroundColor: .mainBackground,
          content: { themeBottomSheet }
        )
      }
    }
  }
  
  private func genericSectionHeader(title: String) -> some View {
    Text(title)
      .fontWeight(.heavy)
      .font(.title2)
      .foregroundColor(.textPrimary)
  }
  
  private func genericSettingsSection(title: String, content: [SettingsMenuModel]) -> some View {
    Section(header: genericSectionHeader(title: title), content: {
      ForEach(content, id: \.self) { item in
        Button(action: {
          item.action()
        }, label: {
          HStack {
            Image(systemName: item.icon)
              .font(.title)
              .bold()
              .padding(.trailing, DefaultSpacings.small)
              .foregroundColor(.textPrimary)

            Text(item.title)
              .font(.title3)
              .foregroundColor(.textSecondary)
            
            Spacer()
            
            Image(systemName: SFSymbols.chevronRight.rawValue)
              .bold()
              .font(.title2)
              .foregroundColor(.textPrimary)
          }
          .padding(8)
        })
      }
    })
  }

  // MARK: - Add functionality
  private var userProfileSection: some View {
    Group {
      HStack {
        Spacer()
        VStack {
          Image(systemName: "person.circle")
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
          Text("Wolf Knight")
            .font(.title)
          Text("WolfKnight@kingdom.tv")
            .font(.subheadline)
            .foregroundColor(.gray)
          Spacer()
          Button(action: {
            print("Edit Profile tapped")
          }) {
            Text("Edit Profile")
              .frame(minWidth: 0, maxWidth: .infinity)
              .font(.system(size: 18))
              .padding()
              .foregroundColor(.white)
              .overlay(
                RoundedRectangle(cornerRadius: 25)
                  .stroke(Color.white, lineWidth: 2)
              )
          }
          .background(Color.main)
          .cornerRadius(25)
        }
        Spacer()
      }
    }
  }

  private var themeBottomSheet: some View {
    ThemeView()
  }
}


#Preview {
    SettingsView()
}

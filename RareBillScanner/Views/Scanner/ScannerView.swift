import SwiftUI
import AestheticKit

struct ScannerView: View {
  
  // Mark: - Naprawic na malych telfonach
  
  @StateObject private var viewModel = ScannerViewModel()
  
  @State private var countryPickerYPossition: CGFloat = 0
  @State private var shouldShowDashboard = false

  var body: some View {
    ZStack {
      dataScannerView
      
      backButton
      
      moreButton
      
      VStack(spacing: .zero) {
        Spacer()
        
        countryPickerView
          .padding(.bottom, DefaultSpacings.medium)
        
        billView
      }
    }
    .shouldHideTabBar(true)
    .shouldChangeTab(.dashboard, shouldChangeTab: shouldShowDashboard)
  }
  
  private var moreButton: some View {
    MoreButton(
      items: viewModel.moreButtonItem,
      backgroundColor: .main,
      iconTintColor: .textPrimary,
      strokeColor: .textPrimary,
      lineWidth: 2
    )
    .position(
      x: DefaultSpacings.extraLarge * 1.5,
      y: DataScannerViewConstants.y / 2
    )
  }
  
  private var countryPickerView: some View {
    RoundedRectangle(cornerRadius: 10)
      .fill(Color.mainBackground)
      .padding(.horizontal, DefaultSpacings.medium)
      .frame(maxHeight: 60)
      .geometryReader { countryPickerYPossition = $0.minY }
  }
  
  private var billView: some View {
    ZStack {
      Rectangle()
        .fill(.green, strokeBorder: .success, lineWidth: 20)
        .cornerRadius(10)
      
      Image(systemName: SFSymbols.dolar.rawValue)
        .resizable()
        .foregroundColor(.textPrimary)
        .frame(width: 80, height: 80)
        .aspectRatio(contentMode: .fit)
        .bold()
      
      VStack(spacing: .zero) {
        Spacer()
        
        Text("***********")
          .bold()
          .font(.title)
          .padding(.top, DefaultSpacings.medium)
          .padding(.bottom, DefaultSpacings.medium)
      }
      
      VStack(spacing: .zero) {
        billCornersView
        
        Spacer()
        
        billCornersView
      }
    }
    .frame(maxHeight: 200)
    .padding(.horizontal, DefaultSpacings.medium)
  }
  
  private var billCornersView: some View {
    HStack(spacing: .zero) {
      Circle()
        .fill(.success)
        .frame(width: 50, height: 50)
      
      Spacer()
      
      Circle()
        .fill(.success)
        .frame(width: 50, height: 50)
    }
  }
  
  private var regionOfInterest: CGRect {
    CGRect(
      x: DataScannerViewConstants.x,
      y: DataScannerViewConstants.y,
      width: DataScannerViewConstants.width,
      height: countryPickerYPossition - DataScannerViewConstants.height
    )
  }
  
  private var dataScannerView: some View {
    DataScannerView(
      backgroundColor: .inverseMainBackground,
      recognizedItems: $viewModel.recognizedItems,
      error: $viewModel.error,
      recognizedDataTypes: viewModel.recognizedDataTypes,
      regionOfInterest: regionOfInterest
    )
    .ignoresSafeArea()
    .id(viewModel.dataScannerViewId)
  }
  
  private var backButton: some View {
    VStack(spacing: .zero) {
      HStack(spacing: .zero) {
        Button(
          action: {
            shouldShowDashboard.toggle()
          }, label: {
            Image(systemName: SFSymbols.xmark.rawValue)
              .foregroundColor(.textPrimary)
              .frame(width: 30, height: 30)
              .aspectRatio(contentMode: .fit)
              .bold()
              .makeStrokeCircleBackground(color: .main, size: 50, strokeColor: .textPrimary, lineWidth: 2)
          }
        )
        
        Spacer()
      }
      .padding(.leading, DefaultSpacings.extraLarge)
      
      Spacer()
    }
  }
  
  private func dashboardView() -> some View {
    DashboardView()
  }
}

private enum DataScannerViewConstants {
  static let x = DefaultSpacings.medium
  static let y = DeviceSizes.navigationBarHeight + spacing * 2
  static let width = ScreenSize.screenWidth - DefaultSpacings.extraLarge
  static let height = DeviceSizes.navigationBarHeight + spacing * 2.5
  static let spacing: CGFloat = ScreenSize.isSmall ? DefaultSpacings.medium : DefaultSpacings.extraLarge
}

#Preview {
    ScannerView()
}

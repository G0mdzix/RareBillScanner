import Foundation

struct SettingsMenuModel: Hashable {
  let id = UUID()
  let title: String
  let icon: String
  let action: () -> Void

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func ==(lhs: SettingsMenuModel, rhs: SettingsMenuModel) -> Bool {
    lhs.id == rhs.id
  }
}

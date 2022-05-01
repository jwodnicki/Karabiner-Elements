import SwiftUI

struct FunctionKeysView: View {
  @ObservedObject private var settings = Settings.shared
  @ObservedObject private var contentViewStates = ContentViewStates.shared

  var body: some View {
    VStack(alignment: .leading, spacing: 12.0) {
      HStack(alignment: .top, spacing: 12.0) {
        DeviceSelectorView(selectedDevice: $contentViewStates.functionKeysViewSelectedDevice)

        VStack {
          FnFunctionKeysView(selectedDevice: contentViewStates.functionKeysViewSelectedDevice)

          Spacer()
        }
      }
    }
    .padding()
  }

  struct FnFunctionKeysView: View {
    private let selectedDevice: ConnectedDevice?
    private let fnFunctionKeys: [SimpleModification]

    init(selectedDevice: ConnectedDevice?) {
      self.selectedDevice = selectedDevice
      self.fnFunctionKeys =
        selectedDevice == nil
        ? Settings.shared.fnFunctionKeys
        : Settings.shared.findConnectedDeviceSetting(selectedDevice!)?.fnFunctionKeys ?? []
    }

    var body: some View {
      VStack(alignment: .leading, spacing: 6.0) {
        ForEach(fnFunctionKeys) { fnFunctionKey in
          HStack {
            Text(fnFunctionKey.fromEntry.label)
              .frame(width: 40)

            SimpleModificationPickerView(
              categories: selectedDevice == nil
                ? SimpleModificationDefinitions.shared.toCategories
                : SimpleModificationDefinitions.shared.toCategoriesWithInheritBase,
              label: fnFunctionKey.toEntry.label,
              action: { json in
                Settings.shared.updateFnFunctionKey(
                  fromJsonString: fnFunctionKey.fromEntry.json,
                  toJsonString: json,
                  device: selectedDevice)
              }
            )
          }

          Divider()
        }
        Spacer()
      }
      .padding(10)
      .background(Color(NSColor.textBackgroundColor))
    }
  }
}

struct FunctionKeysView_Previews: PreviewProvider {
  static var previews: some View {
    FunctionKeysView()
  }
}

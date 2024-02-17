import AppKit

@NSApplicationMain
public class AppDelegate: NSObject, NSApplicationDelegate {
  public func applicationDidFinishLaunching(_: Notification) {
    ProcessInfo.processInfo.enableSuddenTermination()

    libkrbn_initialize()

    KarabinerAppHelper.shared.observeVersionChange()

    NotificationWindowManager.shared.updateWindowsVisibility()
  }

  public func applicationWillTerminate(_: Notification) {
    libkrbn_terminate()
  }
}

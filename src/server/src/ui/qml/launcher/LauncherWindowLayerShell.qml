pragma ComponentBehavior: Bound
import QtQuick.Window
import org.kde.layershell as LayerShell
import Vicinae

LauncherWindow {
    id: shell
    shadowPadding: WindowMaterial.supportsRegionalBlur ? Config.shadowSize : 0
    appearance: LauncherAppearance {
        searchBarHeight: 52
    }
    readonly property int shellHeight: Launcher.compacted ? appearance.searchBarHeight + 2 * appearance.contentInset + 2 * shadowPadding : expandedHeight
    height: shellHeight
    minimumHeight: shellHeight
    maximumHeight: shellHeight

    LayerShell.Window.anchors: LayerShell.Window.AnchorTop
    LayerShell.Window.margins.top: Math.max(0, Math.round(Screen.height * 0.2) - shadowPadding)
    LayerShell.Window.exclusionZone: 0
    LayerShell.Window.scope: "vicinae"
    LayerShell.Window.wantsToBeOnActiveScreen: true
    LayerShell.Window.layer: LayerShell.Window.LayerOverlay
    LayerShell.Window.keyboardInteractivity: Launcher.lsKeyboardInteractivity

    Window {
        visible: shell.visible
        screen: shell.screen
        width: screen.width
        height: screen.height
        color: "transparent"
        flags: Qt.FramelessWindowHint
        LayerShell.Window.anchors: LayerShell.Window.AnchorTop | LayerShell.Window.AnchorBottom | LayerShell.Window.AnchorLeft | LayerShell.Window.AnchorRight
        LayerShell.Window.scope: "vicinae-dismiss"
        LayerShell.Window.layer: LayerShell.Window.LayerTop
        LayerShell.Window.keyboardInteractivity: LayerShell.Window.KeyboardInteractivityNone
        LayerShell.Window.exclusionZone: -1

        MouseArea {
            anchors.fill: parent
            onClicked: Launcher.nav.closeWindow()
        }
    }
}

import os
import sys
import signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtCore import QUrl
from PySide6.QtQml import QQmlApplicationEngine
import globalValues
from ApiCalls import ApiCalls


##For initilising the app
def main():
    """Initializes and manages the application execution"""
    app = QGuiApplication(sys.argv)
    globalValues.engine = QQmlApplicationEngine()

    """Needed to close the app with Ctrl+C"""
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    """Needed to get proper KDE style outside of Plasma"""
    if not os.environ.get("QT_QUICK_CONTROLS_STYLE"):
        os.environ["QT_QUICK_CONTROLS_STYLE"] = "org.kde.desktop"

    base_path = os.path.abspath(os.path.dirname(__file__))
    url = QUrl(f"file://{base_path}/qml/main.qml")
    globalValues.engine.load(url)

    if len(globalValues.engine.rootObjects()) == 0:
        quit()

    app.exec()


if __name__ == "__main__":
    main()


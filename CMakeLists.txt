cmake_minimum_required(VERSION 3.19...3.24)

project(FieldReport VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Qml Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

set(MATERIAL_ROUND ON)

add_subdirectory(icons)
add_subdirectory(Native)

qt6_add_resources(${PROJECT_NAME} "resources"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
        fonts/Roboto/Roboto-Black.ttf
        fonts/Roboto/Roboto-Bold.ttf
        fonts/Roboto/Roboto-Light.ttf
        fonts/Roboto/Roboto-Medium.ttf
        fonts/Roboto/Roboto-Regular.ttf
        fonts/Roboto/Roboto-Thin.ttf
)

qt_add_qml_module(${PROJECT_NAME}
    URI App
    VERSION 1.0
    QML_FILES
        Main.qml
        controls/Calendar.qml
        controls/Card.qml
        controls/HeaderBar.qml
        controls/InfoMessage.qml
        controls/IntervalTimeRectangle.qml
        controls/FieldServiceTimer.qml
        controls/MonthCalendar.qml
        controls/MonthView.qml
        controls/NavigationBar.qml
        controls/NavigationButton.qml
        controls/ReportComponent.qml
        controls/UserButton.qml
        controls/UserContentList.qml
        controls/UserMenu.qml
        controls/Page.qml
        controls/ScrollablePage.qml
        controls/WeekCalendar.qml
        pages/MainPage.qml
        pages/ReportPage.qml
        pages/InterestedPage.qml
        pages/SettingsPage.qml
    SOURCES
        Style.h Style.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt${QT_VERSION_MAJOR}::Core
        Qt${QT_VERSION_MAJOR}::Gui
        Qt${QT_VERSION_MAJOR}::Qml
        Qt${QT_VERSION_MAJOR}::Quick
        Qt${QT_VERSION_MAJOR}::QuickControls2
)

install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

cmake_minimum_required(VERSION 3.21)
project(ChatTSI LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2)

qt_standard_project_setup()

qt_add_executable(ChatTSI
    src/main.cpp
)

target_link_libraries(ChatTSI
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
)

qt_add_qml_module(ChatTSI
    URI ChatTSI
    VERSION 1.0
    QML_FILES
        qml/Main.qml
    RESOURCES
        shaders/glass.frag
)

set_target_properties(ChatTSI PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

cmake_minimum_required(VERSION 3.19...3.24)

project(FieldReport VERSION 0.1 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

set(MATERIAL_ROUND ON)

add_subdirectory(App)
add_subdirectory(icons)

qt6_add_resources(${PROJECT_NAME} "controls_conf"
    PREFIX
        "/"
    FILES
        "qtquickcontrols2.conf"
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE Qt6::Quick
)

install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

cmake_minimum_required(VERSION 3.19...3.24)

option(MATERIAL "Material Icons" false)
option(MATERIAL_TWOTONE "Material TwoTone Icons" false)
option(MATERIAL_SHARP "Material Sharp Icons" false)
option(MATERIAL_ROUND "Material Round Icons" true)
option(MATERIAL_OUTLINE "Material Outline Icons" false)
option(MATERIAL_BASELINE "Material Baseline Icons" false)

set (ICONS_SRC "")

if (MATERIAL)
    include(material.cmake)
elseif (MATERIAL_TWOTONE)
    include(material-twotone.cmake)
elseif (MATERIAL_SHARP)
    include(material-sharp.cmake)
elseif (MATERIAL_ROUND)
    include(material-round.cmake)
elseif (MATERIAL_OUTLINE)
    include(material-outline.cmake)
elseif (MATERIAL_BASELINE)
    include(material-baseline.cmake)
endif()

qt6_add_resources(${PROJECT_NAME} "icons"
    PREFIX "/icons"
    FILES
        ${ICONS_SRC}
)

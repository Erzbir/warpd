cmake_minimum_required(VERSION 3.20)

project(warpd
        VERSION 1.3.6
        LANGUAGES C OBJC
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(WARPD_SOURCES
        src/warpd.c
        src/scroll.c
        src/screen.c
        src/normal.c
        src/mouse.c
        src/mode-loop.c
        src/input.c
        src/history.c
        src/histfile.c
        src/grid_drw.c
        src/hint.c
        src/grid.c
        src/daemon.c
        src/config.c
        src/warpd.h
        src/platform.h
)

add_executable(warpd ${WARPD_SOURCES})

add_subdirectory(src/platform)

add_definitions(-DVERSION="${PROJECT_VERSION}")

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C Compiler: ${CMAKE_C_COMPILER_ID}")
message(STATUS "Project version: ${PROJECT_VERSION}")
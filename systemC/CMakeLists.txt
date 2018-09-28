cmake_minimum_required(VERSION 3.5)

project(final_spw C CXX)
set(PROJECT_VERSION 0.1 )

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTKMM REQUIRED gtkmm-3.0)
pkg_check_modules(GLIBMM REQUIRED glibmm-2.4)

  if(GLIBMM_FOUND)
    include_directories(include ${GLIBMM_INCLUDE_DIRS}) 
    add_definitions(${GLIBMM_CFLAGS} ${GLIBMM_CFLAGS_OTHER})
  endif()

  if (GTKMM_FOUND)   
    include_directories(include ${GTKMM_INCLUDE_DIRS}) 
    add_definitions(${GTKMM_CFLAGS} ${GTKMM_CFLAGS_OTHER})
  endif()

set(CMAKE_CXX_FLAGS "-I/opt/systemc/include/ -L/opt/systemc/lib-debug/ -Wall -Wreorder -Wextra -std=c++11 -fPIC -fpermissive -lsystemc -lboost_thread -lboost_system -g -O3")

add_library(
    final_spw.so
    SHARED
    rx_spw.h
    rx_spw_clock_recovery.h
    send_module_sc.h
    spw_fsm.h
    top_spw.h
    tx_clock.h
    tx_spw.h
    main.cc
)

target_link_libraries(final_spw.so ${GTKMM_LDFLAGS} ${GLIBMM_LDFLAGS})



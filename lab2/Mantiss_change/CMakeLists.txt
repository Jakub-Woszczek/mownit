cmake_minimum_required(VERSION 3.29)
project(Mantiss_change C)

set(CMAKE_C_COMPILER "C:/msys64/mingw64/bin/gcc.exe")

find_package(GSL REQUIRED)

add_executable(Mantiss_change main.c)
target_link_libraries(Mantiss_change GSL::gsl GSL::gslcblas m)

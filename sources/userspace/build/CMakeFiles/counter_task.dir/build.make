# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.30

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/Cellar/cmake/3.30.5/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/Cellar/cmake/3.30.5/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build

# Include any dependencies generated for this target.
include CMakeFiles/counter_task.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/counter_task.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/counter_task.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/counter_task.dir/flags.make

CMakeFiles/counter_task.dir/crt0.s.obj: CMakeFiles/counter_task.dir/flags.make
CMakeFiles/counter_task.dir/crt0.s.obj: /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.s
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building ASM object CMakeFiles/counter_task.dir/crt0.s.obj"
	/opt/homebrew/bin/arm-none-eabi-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/counter_task.dir/crt0.s.obj -c /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.s

CMakeFiles/counter_task.dir/crt0.s.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing ASM source to CMakeFiles/counter_task.dir/crt0.s.i"
	/opt/homebrew/bin/arm-none-eabi-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -E /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.s > CMakeFiles/counter_task.dir/crt0.s.i

CMakeFiles/counter_task.dir/crt0.s.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling ASM source to assembly CMakeFiles/counter_task.dir/crt0.s.s"
	/opt/homebrew/bin/arm-none-eabi-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -S /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.s -o CMakeFiles/counter_task.dir/crt0.s.s

CMakeFiles/counter_task.dir/crt0.c.obj: CMakeFiles/counter_task.dir/flags.make
CMakeFiles/counter_task.dir/crt0.c.obj: /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c
CMakeFiles/counter_task.dir/crt0.c.obj: CMakeFiles/counter_task.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/counter_task.dir/crt0.c.obj"
	/opt/homebrew/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/counter_task.dir/crt0.c.obj -MF CMakeFiles/counter_task.dir/crt0.c.obj.d -o CMakeFiles/counter_task.dir/crt0.c.obj -c /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c

CMakeFiles/counter_task.dir/crt0.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/counter_task.dir/crt0.c.i"
	/opt/homebrew/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c > CMakeFiles/counter_task.dir/crt0.c.i

CMakeFiles/counter_task.dir/crt0.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/counter_task.dir/crt0.c.s"
	/opt/homebrew/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c -o CMakeFiles/counter_task.dir/crt0.c.s

CMakeFiles/counter_task.dir/cxxabi.cpp.obj: CMakeFiles/counter_task.dir/flags.make
CMakeFiles/counter_task.dir/cxxabi.cpp.obj: /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp
CMakeFiles/counter_task.dir/cxxabi.cpp.obj: CMakeFiles/counter_task.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/counter_task.dir/cxxabi.cpp.obj"
	/opt/homebrew/bin/arm-none-eabi-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/counter_task.dir/cxxabi.cpp.obj -MF CMakeFiles/counter_task.dir/cxxabi.cpp.obj.d -o CMakeFiles/counter_task.dir/cxxabi.cpp.obj -c /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp

CMakeFiles/counter_task.dir/cxxabi.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/counter_task.dir/cxxabi.cpp.i"
	/opt/homebrew/bin/arm-none-eabi-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp > CMakeFiles/counter_task.dir/cxxabi.cpp.i

CMakeFiles/counter_task.dir/cxxabi.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/counter_task.dir/cxxabi.cpp.s"
	/opt/homebrew/bin/arm-none-eabi-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp -o CMakeFiles/counter_task.dir/cxxabi.cpp.s

CMakeFiles/counter_task.dir/counter_task/main.cpp.obj: CMakeFiles/counter_task.dir/flags.make
CMakeFiles/counter_task.dir/counter_task/main.cpp.obj: /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp
CMakeFiles/counter_task.dir/counter_task/main.cpp.obj: CMakeFiles/counter_task.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/counter_task.dir/counter_task/main.cpp.obj"
	/opt/homebrew/bin/arm-none-eabi-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/counter_task.dir/counter_task/main.cpp.obj -MF CMakeFiles/counter_task.dir/counter_task/main.cpp.obj.d -o CMakeFiles/counter_task.dir/counter_task/main.cpp.obj -c /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp

CMakeFiles/counter_task.dir/counter_task/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/counter_task.dir/counter_task/main.cpp.i"
	/opt/homebrew/bin/arm-none-eabi-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp > CMakeFiles/counter_task.dir/counter_task/main.cpp.i

CMakeFiles/counter_task.dir/counter_task/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/counter_task.dir/counter_task/main.cpp.s"
	/opt/homebrew/bin/arm-none-eabi-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp -o CMakeFiles/counter_task.dir/counter_task/main.cpp.s

# Object files for target counter_task
counter_task_OBJECTS = \
"CMakeFiles/counter_task.dir/crt0.s.obj" \
"CMakeFiles/counter_task.dir/crt0.c.obj" \
"CMakeFiles/counter_task.dir/cxxabi.cpp.obj" \
"CMakeFiles/counter_task.dir/counter_task/main.cpp.obj"

# External object files for target counter_task
counter_task_EXTERNAL_OBJECTS =

counter_task: CMakeFiles/counter_task.dir/crt0.s.obj
counter_task: CMakeFiles/counter_task.dir/crt0.c.obj
counter_task: CMakeFiles/counter_task.dir/cxxabi.cpp.obj
counter_task: CMakeFiles/counter_task.dir/counter_task/main.cpp.obj
counter_task: CMakeFiles/counter_task.dir/build.make
counter_task: /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/../build/libkivrtos_stdlib.a
counter_task: CMakeFiles/counter_task.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable counter_task"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/counter_task.dir/link.txt --verbose=$(VERBOSE)
	arm-none-eabi-objcopy ./counter_task -O binary ./counter_task.bin
	arm-none-eabi-objdump -l -S -D ./counter_task > ./counter_task.asm
	xxd -i ./counter_task > ./src_counter_task.h

# Rule to build all files generated by this target.
CMakeFiles/counter_task.dir/build: counter_task
.PHONY : CMakeFiles/counter_task.dir/build

CMakeFiles/counter_task.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/counter_task.dir/cmake_clean.cmake
.PHONY : CMakeFiles/counter_task.dir/clean

CMakeFiles/counter_task.dir/depend:
	cd /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build /Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/build/CMakeFiles/counter_task.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/counter_task.dir/depend

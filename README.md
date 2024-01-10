# hwinfo
[![CMake](https://github.com/Jacob-C-Smith/hwinfo/actions/workflows/cmake.yml/badge.svg)](https://github.com/Jacob-C-Smith/log/actions/workflows/cmake.yml)

 Get hardware info from the x86_64 host
  
 > 0 [Try it](#try-it)
 >
 > 1 [Download](#download)
 >
 > 2 [Build](#build)
 >
 > 3 [Example](#example)
 >
 >> 3.1 [Example output](#example-output)
 >
 > 4 [Definitions](#definitions)
 >
 >> 4.1 [Function definitions](#function-definitions)

## Try it
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Jacob-C-Smith/hwinfo?quickstart=1)

Wait for a few moments, then click the play button on the bottom of the window. This will run the example program.

 ## Download
 To download hwinfo, execute the following command
 ```bash
 $ git clone https://github.com/Jacob-C-Smith/hwinfo
 ```
 ## Build
 To build on UNIX like machines, execute the following commands in the same directory
 ```bash
 $ cd hwinfo
 $ cmake .
 $ make
 ```
  This will build the example program, the tester program, and dynamic / shared libraries

  To build hwinfo for Windows machines, open the base directory in Visual Studio, and build your desired target(s)
 ## Example
 To run the example program, execute this command
 ```
 $ ./hwinfo_example
 ```
 ### Example output
 ```
CPU manufacturer string: GenuineIntel
CPU brand string: Intel(R) Core(TM) i5-1038NG7 CPU @ 2.00GHz
CPU core count: 16
 ```
 
 [Source](main.c)
 ## Definitions
 ### Function definitions
 ```c 
 // Info
 int hwinfo_cpu_manufacturer_get       ( char               (*p_cpu_manufacturer_string)[12] );
 int hwinfo_cpu_brand_get              ( char               (*p_cpu_brand_string)[48] );
 int hwinfo_cpu_logical_core_count_get ( unsigned long long  *p_core_count );
 ```

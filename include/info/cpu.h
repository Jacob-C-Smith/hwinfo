/** !
 * @file hwinfo/cpu.h 
 * 
 * @author Jacob Smith
 * 
 * Include header for CPU hardware info
 */

// Include guard
#pragma once

// Standard library
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdbool.h>
#include <string.h>

// Platform dependent macros
#ifdef _WIN64
#define DLLEXPORT extern __declspec(dllexport)
#else
#define DLLEXPORT
#endif

/** !
 * Get the 12 byte CPU manufacturer string
 * 
 * @param p_cpu_manufacturer_string return
 * 
 * @return 1 on success, 0 on error
 */
DLLEXPORT int hwinfo_cpu_manufacturer_get ( char (*p_cpu_manufacturer_string)[12] );

/** !
 * Get the 48 byte CPU brand string
 * 
 * @param p_cpu_brand_string return
 * 
 * @return 1 on success, 0 on error
 */
DLLEXPORT int hwinfo_cpu_brand_get ( char (*p_cpu_brand_string)[48] );

/** !
 * Get the quantity of logical cores
 * 
 * @param p_core_count return
 * 
 * @return 1 on success, 0 on error
*/
DLLEXPORT int hwinfo_cpu_logical_core_count_get ( unsigned long long *p_core_count );

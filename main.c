/** !
 * Hardware info example program
 * 
 * @author Jacob Smith
 * @file main.c
 */

// Standard library
#include <stdio.h>
#include <stdlib.h>

// hardware info
#include <info/cpu.h>

// Entry point
int main ( int argc, const char* argv[] )
{

    // Initialized data
    char cpu_manufacturer[12] = { 0 };
    char cpu_brand[48] = { 0 };
    unsigned long long cpu_core_count = 0;

    // Get the CPU manufacturer
    if ( hwinfo_cpu_manufacturer_get(&cpu_manufacturer) == 0 ) goto failed_to_get_cpu_manufacturer;

    // Print the CPU manufacturer string
    printf("CPU manufacturer string: %s\n", cpu_manufacturer);

    // Get the CPU brand
    if ( hwinfo_cpu_brand_get(&cpu_brand) == 0 ) goto failed_to_get_cpu_brand;

    // Print the CPU brand string
    printf("CPU brand string: %s\n", cpu_brand);
   
    // Get the quantity of CPU cores
    if ( hwinfo_cpu_logical_core_count_get(&cpu_core_count) == 0 ) goto failed_to_get_cpu_quantity;

    // Print the CPU brand string
    printf("CPU core count: %lld\n", cpu_core_count);

    // Success
    return EXIT_SUCCESS;

    // Error handling
    {
        failed_to_get_cpu_brand:

            // Print an error message to standard out
            printf("Error: Failed to get CPU brand string!\n");

            // Error
            return EXIT_FAILURE;

        failed_to_get_cpu_manufacturer:
            
            // Print an error message to standard out
            printf("Error: Failed to get CPU manufacturer string!\n");

            // Error
            return EXIT_FAILURE;

        failed_to_get_cpu_quantity:
            
            // Print an error message to standard out
            printf("Error: Failed to get CPU core quantity!\n");

            // Error
            return EXIT_FAILURE;

    }
}

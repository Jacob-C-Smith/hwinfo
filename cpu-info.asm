[BITS 64]

section .text

global hwinfo_cpu_manufacturer_get
hwinfo_cpu_manufacturer_get:

    ; Argument check
    or rdi, rdi
    jz .no_manufacturer_string_pointer

    ; Get the manufacturer string
	mov	rax, 0
    cpuid

    ; Store the manufacturer string
    mov [rdi], rbx
    mov [rdi+4], rdx
    mov [rdi+8], rcx

    ; Success
    mov rax, 1
    ret
    
    .no_manufacturer_string_pointer:

        ; Error
        xor rax, rax
        ret

global hwinfo_cpu_brand_get
hwinfo_cpu_brand_get:

    ; Argument check
    or rdi, rdi
    jz .no_brand_string_pointer

    ; First 16 bytes of brand string
	mov	rax, 0x80000002
    cpuid

    ; Store the brand string
    mov [rdi+0], rax
    mov [rdi+4], rbx
    mov [rdi+8], rcx
    mov [rdi+12], rdx

    ; Middle 16 bytes of brand string
    mov	rax, 0x80000003
    cpuid

    ; Store the brand string
    mov [rdi+16], rax
    mov [rdi+20], rbx
    mov [rdi+24], rcx
    mov [rdi+28], rdx

    ; Last 16 bytes of brand string
    mov	rax, 0x80000004
    cpuid

    ; Store the brand string
    mov [rdi+32], rax
    mov [rdi+36], rbx
    mov [rdi+40], rcx
    mov [rdi+44], rdx

    ; Success
    mov rax, 1
    ret
    
    .no_brand_string_pointer:

        ; Error
        xor rax, rax
        ret

global hwinfo_cpu_logical_core_count_get
hwinfo_cpu_logical_core_count_get:

    ; Argument check
    or rdi, rdi
    jz .no_core_count_pointer

    mov rax, 1
    cpuid

    shr rbx, 16
    and rbx, 0x00000000000000ff

    mov [rdi], rbx

    ; Success
    mov rax, 1
    ret
    
    .no_core_count_pointer:

        ; Error
        xor rax, rax
        ret

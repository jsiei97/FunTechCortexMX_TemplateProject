/**
 * STM32-H103 => STM32F103RBT6 
 *  F   = general-purpose
 *  103 = performance line
 *  R   = 64 pins
 *  B   = 128 Kbytes of Flash memory
 *  T   = LQFP
 *  6   = Industrial temperature range, –40 to 85 °C
 *
 * STM32F103Rx has 20 Kbytes of SRAM
 */
MEMORY
{
  ram (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
  stack(rwx): ORIGIN = 0x20004FFC, LENGTH = 0K

  rom (rx)  : ORIGIN = 0x00000000, LENGTH = 128K
}

SECTIONS
{
    .nvic_vector : 
    {
        *(vectors)    /* Vector table */
    } >rom

    .text : 
    {
        *(.text)      /* Program code */
        *(.text.*)
        *(.rodata)    /* Read only data */
        *(.rodata.*)        
    } >rom

    .data_init_begin : 
    {
        _DATAI_BEGIN = .;
    } >rom

    .data : 
    {
        _DATA_BEGIN = .;
        *(.data)      /* Data memory */
        *(.data.*)        
        _DATA_END = .;
    } >ram AT >rom

    .data_init_end : 
    {
        _DATAI_END = .;
    } >rom

    .bss :
    {
        _BSS_BEGIN = .;
        *(.bss)       /* Zero-filled run time allocate data memory */
        *(.bss.*)
        *(COMMON)        
        _BSS_END = .;
    } >ram 

    .heap :
    {
        _HEAP = .;
    } >ram

    .stack :
    {
        _STACKTOP = .;
    } >stack

}  

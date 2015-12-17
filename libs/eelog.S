/* avr eeprom debug logging
 * http://nerdralph.blogspot.ca
 * @author: Ralph Doncaster 2015
 * define ISR_SAFE if interrupts are enabled
 */

/* needed for <avr/io.h> to give io constant addresses */
#define __SFR_OFFSET 0
#include <avr/io.h>
#include <avr/eeprom.h>

#define tmpreg r0

.section .text.eelog,"ax",@progbits

; uses lightweight assembler function calling api - r26/27
.global eelog_
eelog_:
    sbic EECR, EEPE         ; wait for EEPROM ready
    rjmp eelog_
    in tmpreg, EEARL
    inc tmpreg
    out EEARL, tmpreg
    out EEDR, r26
#ifdef ISR_SAFE
    cli
#endif
    sbi EECR, EEMPE
    sbi EECR, EEPE
#ifdef ISR_SAFE
    reti
#else
    ret
#endif

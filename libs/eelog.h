/* avr eeprom debug logging
 * http://nerdralph.blogspot.ca
 * @author: Ralph Doncaster 2015
 */

#include <avr/io.h>
#include <avr/eeprom.h>

inline void eelog(char logdata)
{
    // no output, x register input, no clobbers
    asm volatile ( 
    "rcall eelog_\n"
    :
    : "x" (logdata)
    : );
}

__attribute__ ((naked))\
__attribute__ ((used))\
__attribute__ ((section (".init8")))\
void eelog_init(void)
{
    EEARL = 0xff;
#ifdef EEARH
    EEARH = 0;
#endif

}


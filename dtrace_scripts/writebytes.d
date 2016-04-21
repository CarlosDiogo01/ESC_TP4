#!/usr/sbin/dtrace -s

/*
 * writebytes.d - write bytes by process name. MODIFIED 
 *
 */

sysinfo:::writech
/execname=="iozone"/
{
	@bytes[execname] = sum(arg0); 
}

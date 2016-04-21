#!/usr/sbin/dtrace -s

/***********************************
* Script for counting Syscall calls
************************************/

syscall:::entry 
{ 
	@num[probefunc] = count();
}

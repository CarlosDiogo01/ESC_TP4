#!/usr/sbin/dtrace -s
/*
 * Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 *
 * This D script is used as an example in the Solaris Dynamic Tracing Guide
 * wiki in the "Aggregations" Chapter.
 *
 * The full text of the this chapter may be found here:
 *
 *   http://docs.oracle.com/cd/E36784_01/html/E36846/gkwuw.html#scrolltoc
 *
 * On machines that have DTrace installed, this script is available as
 * writesbycmd.d in /usr/demo/dtrace, a directory that contains all D scripts
 * used in the Solaris Dynamic Tracing Guide.  A table of the scripts and their
 * corresponding chapters may be found here:
 *
 *   file:///usr/demo/dtrace/index.html
 */

syscall::write:entry
{
	@counts[execname] = count();
}

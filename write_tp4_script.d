#!/usr/sbin/dtrace -s

#pragma D option quiet

syscall::open*:entry
/execname=="iozone" & uid==29214/
{
	self->path = copyinstr(arg1);
}

syscall::open*:return
/self->path=="iozone.tmp"/
{
	flag = 1;
	size = 0;
	total=0;
}

syscall::write:entry
/flag == 1/
{
	self->start_clock = timestamp;
	self->write_size = (arg2/1024);	
	size = size + self->write_size;
}

syscall::write:return
/self->start_clock > 0 & self->write_size > 0/
{
	self->stop_time = timestamp;
	self->elapsed = self->stop_time - self->start_clock;
	total = total + self->elapsed; 
}


syscall::close*:entry
/self->path=="iozone.tmp"/
{
	printf("%-12s %s\n","TAMANHO","TEMPO TOTAL");
	printf("%-12d %d\n",size,total);
	flag = 0;
}

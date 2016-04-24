#!/usr/sbin/dtrace -s

#pragma D option quiet

syscall::open*:entry
/execname=="iozone" & uid==29214/
{
	self->path = copyinstr(arg1);
	self->flag = arg2;
}

syscall::open*:return
/self->path=="iozone.tmp" /
{
	self->start_clock = timestamp;
	total=0;
	flag = 1;
	size = 0;
}

syscall::read:return
/self->start_clock > 0/
{
	self->read_size = (arg0/1024);	
	size = size + self->read_size;
}

syscall::close*:entry
/self->path=="iozone.tmp"/
{
	self->stop_clock = timestamp;
	self->elapsed = self->stop_clock - self->start_clock;
	total = total + self->elapsed; 
	printf("%-12s %s\n","TAMANHO","TEMPO TOTAL");
	printf("%-12d %d\n",size,total);
	flag = 0;
}

/** Flags for exercise 1 point 3 for Solaris 11
inline int O_WRONLY = 1;
inline int O_RDWR = 2;
inline int O_APPEND = 8;
inline int O_CREAT = 256;
**/


this string s_flags;

syscall::openat*:entry 
{
	self->path = copyinstr(arg1);
	self->flags = arg2;
}

syscall::openat*:return 
/strstr(self->path,"/etc") != NULL/
{
	this->s_flags = strjoin (
		self->flags & O_WRONLY ? "O_WRONLY"
		: self->flags & O_RDWR ? "O_RWR" : "O_RDONLY",
		strjoin ( self->flags & O_APPEND ? "|O_APPEND" : "",
			  self->flags & O_CREAT ? "|O_CREAT" : ""));
	printf("EXECNAME,PID,UID,GID,PATH,FLAGS,RETURN_VALUE\n");
	printf("%s,%d,%d,%d,%s,%s,%d\n", 
		execname, pid, uid, gid, self->path, this->s_flags, arg1); 	
}

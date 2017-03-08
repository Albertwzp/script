#include <my_global.h>
#include <my_sys.h>
#include <mysql.h>
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>
extern "C" {
	my_bool now_usec_init(UDF_INIT *initid, UDF_ARGS *args, char *message);
	char *now_usec(
}

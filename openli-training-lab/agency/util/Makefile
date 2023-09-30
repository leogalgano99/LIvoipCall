PJDIR = /home/openli-testagency/pjproject
include $(PJDIR)/build.mak

pcaputil: pcaputil.o
	$(PJ_CC) -o $@ $< $(PJ_LDFLAGS) $(PJ_LDLIBS)

pcaputil.o: pcaputil.c
	$(PJ_CC) -c -o $@ $< $(PJ_CFLAGS)

clean:
	rm -f pcaputil.o pcaputil

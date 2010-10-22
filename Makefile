THD_COMPS := thd keystate trigger eventnames devices cmdsocket obey
THCMD_COMPS := th-cmd cmdsocket

MAKEDEPEND = gcc -M $(CPPFLAGS) -o $*.d $<

all: thd th-cmd man

man: thd.1 th-cmd.1

thd: $(THD_COMPS:%=%.o)

th-cmd: $(THCMD_COMPS:%=%.o)

%.1: %.pod
	pod2man \
		--center="Triggerhappy daemon" \
		--section=1 \
		--release="" \
		$< > $@


clean:
	rm -f *.d
	rm -f *.o
	rm -f thd th-cmd
	rm -f thd.1 th-cmd.1

%.d : %.c
	$(MAKEDEPEND)

-include $(THD_COMPS:%=%.d) $(THCMD_COMPS:%=%.d)

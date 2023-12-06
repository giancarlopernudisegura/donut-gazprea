CC := clang++
CFLAGS := -O2
LDFLAGS := $(GAZLIB) -Wl,-rpath,$(shell dirname $(GAZLIB))

# Temporary file names
LL_FILE := $(shell mktemp).ll
ASM_FILE := $(shell mktemp).s

# Targets
all: donut

donut: $(ASM_FILE)
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

$(ASM_FILE): $(LL_FILE)
	llc --load=$(GAZLIB) -O2 $< -o $@

$(LL_FILE):
	$(GAZC) donut.gaz $@

clean:
	rm -f donut $(LL_FILE) $(ASM_FILE)

.PHONY: all clean

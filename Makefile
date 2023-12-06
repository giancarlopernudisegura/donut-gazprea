CC := clang++
CFLAGS := -O2
LDFLAGS := $(GAZLIB) -Wl,-rpath,$(shell dirname $(GAZLIB))

BUILD_DIR := $(shell pwd)/build
LL_FILE := $(BUILD_DIR)/donut.ll
ASM_FILE := $(BUILD_DIR)/donut.s

# Targets
all: donut

donut: $(ASM_FILE)
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

$(ASM_FILE): $(LL_FILE)
	llc --load=$(GAZLIB) -O2 $< -o $@

$(LL_FILE):
	@mkdir -p $(BUILD_DIR)
	$(GAZC) donut.gaz $@

clean:
	rm -f donut $(BUILD_DIR)

.PHONY: all clean

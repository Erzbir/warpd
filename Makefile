.PHONY: all man clean

BIN=warpd
CMAKE=cmake
BUILD_DIR=build
MAN=files/warpd.1.gz
CFLAGS=

all: $(BUILD_DIR) man
	$(CMAKE) -S . -B $(BUILD_DIR) -DCMAKE_C_FLAGS="$(CFLAGS)"
	$(CMAKE) --build $(BUILD_DIR) --target $(BIN) -j 10

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

HAS_SCDOC := $(shell command -v scdoc 2>/dev/null)

man: $(BUILD_DIR)
ifeq ($(HAS_SCDOC),)
	@echo "scdoc not found, skipping man page generation"
else
	scdoc < warpd.1.md | gzip > $(MAN)
endif

clean:
	@rm -rf $(BUILD_DIR)

ifndef PLATFORM
    UNAME_S := $(shell uname -s 2>/dev/null)
    ifeq ($(UNAME_S), Darwin)
        PLATFORM := macos
    else ifeq ($(UNAME_S), Linux)
        PLATFORM := linux
    else ifneq ($(OS),)
        ifeq ($(OS), Windows_NT)
            PLATFORM := windows
        endif
    endif
    PLATFORM ?= linux
endif

ifeq ($(PLATFORM), macos)
    include mk/macos.mk
else ifeq ($(PLATFORM), windows)
    include mk/windows.mk
else
    include mk/linux.mk
endif

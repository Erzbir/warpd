.PHONY: install uninstall

install: $(BUILD_DIR)/$(BIN)
	mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1/ $(DESTDIR)$(PREFIX)/bin/
	install -m644 $(MAN) $(DESTDIR)$(PREFIX)/share/man/man1/
	install -m755 $(BUILD_DIR)/$(BIN) $(DESTDIR)$(PREFIX)/bin/
uninstall:
	rm $(DESTDIR)$(PREFIX)/share/man/man1/warpd.1.gz\
		$(DESTDIR)$(PREFIX)/$(BUILD_DIR)/$(BIN)
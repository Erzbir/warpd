.PHONY: install uninstall codesign

install: $(BUILD_DIR)/$(BIN) codesign
	mkdir -p $(DESTDIR)/usr/local/bin/ \
		$(DESTDIR)/usr/local/share/man/man1/ \
		$(DESTDIR)/Library/LaunchAgents && \
	install -m644 $(MAN) $(DESTDIR)/usr/local/share/man/man1 && \
	install -m755 $(BUILD_DIR)/$(BIN) $(DESTDIR)/usr/local/bin/ && \
	install -m644 files/com.warpd.warpd.plist $(DESTDIR)/Library/LaunchAgents

uninstall:
	rm -f $(DESTDIR)/usr/local/share/man/man1/warpd.1.gz \
		$(DESTDIR)/usr/local/bin/warpd \
		$(DESTDIR)/Library/LaunchAgents/com.warpd.warpd.plist
		
KEYCHAIN_NAME=warpd-temp-keychain
KEYCHAIN_PASSWORD=
P12=codesign/warpd.p12
CER=codesign/warpd.cer

codesign: $(BUILD_DIR)/$(BIN)
	@echo "Signing $(BUILD_DIR)/$(BIN)..."
	@security create-keychain -p "$(KEYCHAIN_PASSWORD)" "$(KEYCHAIN_NAME)"
	@security list-keychains -d user -s "$(KEYCHAIN_NAME)"
	@security import $(P12) -k "$(KEYCHAIN_NAME)" -P "" -T /usr/bin/codesign
	@security import $(CER) -k "$(KEYCHAIN_NAME)" -T /usr/bin/codesign
	@security unlock-keychain -p "$(KEYCHAIN_PASSWORD)" "$(KEYCHAIN_NAME)"
	@security set-key-partition-list -S apple-tool:,apple: -s -k "$(KEYCHAIN_PASSWORD)" -D "$(identity)" -t private $(KEYCHAIN_NAME) > /dev/null 2>&1
	@codesign --force --deep --keychain "$(KEYCHAIN_NAME)" -s warpd "$(BUILD_DIR)/$(BIN)"
	@security delete-keychain "$(KEYCHAIN_NAME)"
	@echo "Signed: $(BUILD_DIR)/$(BIN)"
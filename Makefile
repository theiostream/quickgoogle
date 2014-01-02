TARGET = ::4.3
ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = QuickGoogle
QuickGoogle_FILES = QuickGoogle.m
QuickGoogle_FRAMEWORKS = UIKit
QuickGoogle_LDFLAGS = -lactivator

include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/Activator/Listeners/am.theiostre.quickgoogle/$(ECHO_END)
	$(ECHO_NOTHING)cp QGActivator.plist $(THEOS_STAGING_DIR)/Library/Activator/Listeners/am.theiostre.quickgoogle/Info.plist$(ECHO_END)

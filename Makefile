GO_EASY_ON_ME=1
THEOS_DEVICE_IP = 192.168.1.107
include theos/makefiles/common.mk

TWEAK_NAME = QuickGoogle
QuickGoogle_FILES = Tweak.xm
QuickGoogle_FRAMEWORKS = UIKit
QuickGoogle_LDFLAGS = -lactivator

include $(THEOS_MAKE_PATH)/tweak.mk

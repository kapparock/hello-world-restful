#====================================================================================
#			The MIT License (MIT)
#
#			Copyright (c) 2011 Kapparock LLC
#
#			Permission is hereby granted, free of charge, to any person obtaining a copy
#			of this software and associated documentation files (the "Software"), to deal
#			in the Software without restriction, including without limitation the rights
#			to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#			copies of the Software, and to permit persons to whom the Software is
#			furnished to do so, subject to the following conditions:
#
#			The above copyright notice and this permission notice shall be included in
#			all copies or substantial portions of the Software.
#
#			THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#			IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#			FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#			AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#			LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#			OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#			THE SOFTWARE.
#====================================================================================
include $(TOPDIR)/rules.mk

# Name and release number of this package
PKG_NAME:=hello-world-restful
PKG_RELEASE:=1.0.0


# This specifies the directory where we're going to build the program.  
# The root build directory, $(BUILD_DIR), is by default the build_mipsel 
# directory in your OpenWrt SDK directory
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)/src

include $(INCLUDE_DIR)/package.mk

# Specify package information for this program. 
# The variables defined here should be self explanatory.
# If you are running Kamikaze, delete the DESCRIPTION 
# variable below and uncomment the Kamikaze define
# directive for the description below
define Package/$(PKG_NAME)
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=$(PKG_NAME) -- Hello World Example for kappaBox SDK
	DEPENDS:=+jansson +rsserial +libstdcpp
endef

# Specify what needs to be done to prepare for building the package.
# In our case, we need to copy the source files to the build directory.
# This is NOT the default.  The default uses the PKG_SOURCE_URL and the
# PKG_SOURCE which is not defined here to download the source from the web.
# In order to just build a simple program that we have just written, it is
# much easier to do it this way.
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

# We do not need to define Build/Configure or Build/Compile directives
# The defaults are appropriate for compiling a simple program such as this one


# Specify where and how to install the program. Since we only have one file, 
# the kapparock-philips-hue executable, install it by copying it to the /bin directory on
# the router. The $(1) variable represents the root directory on the router running 
# OpenWrt. The $(INSTALL_DIR) variable contains a command to prepare the install 
# directory if it does not already exist.  Likewise $(INSTALL_BIN) contains the 
# command to copy the binary file from its current location (in our case the build
# directory) to the install directory.

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/lib/rsserial
	$(INSTALL_DIR) $(1)/usr/lib/rsserial/endpoints
	$(CP) $(PKG_BUILD_DIR)/$(PKG_NAME)*so* $(1)/usr/lib/
	ln -s /usr/lib/$(PKG_NAME).so $(1)/usr/lib/rsserial/endpoints/$(PKG_NAME).so
endef

#define Build/InstallDev
#	$(INSTALL_DIR) $(1)/usr/{lib,include}
#	$(CP) $(PKG_BUILD_DIR)/$(PKG_NAME)*so* $(1)/usr/lib
#	$(CP) ./src/*.h $(1)/usr/include/
#endef

define Build/Compile
	$(call Build/Compile/Default,processor_family=$(_processor_family_))
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# check if we are on real system
$(info $(Profile))
if [ -z "$${IPKG_INSTROOT}" ]; then
	echo "Restarting application..."
	/etc/init.d/rsserial-watch restart
fi
exit 0
endef

define Package/$(PKG_NAME)/UploadAndInstall
compile: $(STAGING_DIR_ROOT)/stamp/.$(PKG_NAME)_installed
	$(SCP) $$(PACKAGE_DIR)/$$(PKG_NAME)_$$(VERSION)_$$(ARCH_PACKAGES).ipk $(1):/tmp
	$(SSH) $(1) opkg install --force-overwrite /tmp/$(PKG_NAME)_$$(VERSION)_$$(ARCH_PACKAGES).ipk
	$(SSH) $(1) rm /tmp/$$(PKG_NAME)_$$(VERSION)_$$(ARCH_PACKAGES).ipk
endef
UPLOAD_PATH:=$(or $(PKG_DST), $($(PKG_NAME)_DST))
$(if $(UPLOAD_PATH), $(eval $(call Package/$(PKG_NAME)/UploadAndInstall, $(UPLOAD_PATH))))

# This line executes the necessary commands to compile our program.
# The above define directives specify all the information needed, but this
# line calls BuildPackage which in turn actually uses this information to
# build a package.
$(eval $(call BuildPackage,$(PKG_NAME)))

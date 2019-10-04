gsettings --schemadir ~/.local/share/gnome-shell/extensions/glassygnome@emiapwil/schemas \
          set org.gnome.shell.extensions.glassy-gnome filters \
	      "[
              (['Terminal'], byte 0x50, byte 0x32, byte 0x0a),
	          (['Firefox'], byte 0x5f, byte 0x50, byte 0x0a),
	          (['- Brave'], byte 0x5f, byte 0x50, byte 0x0a),
	          (['.*'], byte 0x5f, byte 0x50, byte 0x05)
          ]"


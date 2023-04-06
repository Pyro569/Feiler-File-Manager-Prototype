extends WorldEnvironment


func _ready(): # sets the WorldEvironment sky texture to your desktop background, only works on windows, if failure it stays as beauprizzler
	var desktopbgfile = OS.get_user_data_dir().get_base_dir().get_base_dir().get_base_dir() + "/Microsoft/Windows/Themes/TranscodedWallpaper"
	if FileAccess.file_exists(desktopbgfile):
		var desktopimage = Image.new()
		var bytes = FileAccess.get_file_as_bytes(desktopbgfile)
		desktopimage.load_png_from_buffer(bytes)
		if desktopimage.data["height"] == 0: # go through every supported image type because wallpaper location has no file extension
			desktopimage.load_jpg_from_buffer(bytes)
			if desktopimage.data["height"] == 0:
				desktopimage.load_bmp_from_buffer(bytes)
				if desktopimage.data["height"] == 0:
					desktopimage.load_tga_from_buffer(bytes)
					if desktopimage.data["height"] == 0:
						desktopimage.load_webp_from_buffer(bytes)
						if desktopimage.data["height"] == 0:
							return
		var desktoptexture = ImageTexture.new()
		desktoptexture.set_image(desktopimage)
		#print(desktopimage, desktoptexture)
		var newsky = PanoramaSkyMaterial.new()
		newsky.set_panorama(desktoptexture)
		#print(newsky)
		environment.sky.set_material(newsky)

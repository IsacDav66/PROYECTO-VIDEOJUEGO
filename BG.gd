extends ParallaxBackground

var scrolling_spedd = 100

func  _process(delta):
	scroll_offset.x -= scrolling_spedd * delta

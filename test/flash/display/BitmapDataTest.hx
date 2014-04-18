package flash.display;


import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import massive.munit.Assert;


class BitmapDataTest {
	
	
	@Test public function height () {
		
		var bitmapData = new BitmapData (1, 1);
		
		Assert.areEqual (1, bitmapData.height);
		
		bitmapData = new BitmapData (100, 100, true, 0xFFFF0000);
		
		Assert.areEqual (100.0, bitmapData.height);
		
	}
	
	
	@Test public function rect () {
		
		var bitmapData = new BitmapData (1, 1);
		
		Assert.areEqual (0, bitmapData.rect.x);
		Assert.areEqual (0, bitmapData.rect.y);
		Assert.areEqual (1, bitmapData.rect.width);
		Assert.areEqual (1, bitmapData.rect.height);
		
		bitmapData = new BitmapData (100, 100, true, 0xFFFF0000);
		
		Assert.areEqual (0, bitmapData.rect.x);
		Assert.areEqual (0, bitmapData.rect.y);
		Assert.areEqual (100.0, bitmapData.rect.width);
		Assert.areEqual (100.0, bitmapData.rect.height);
		
	}
	
	
	@Test public function transparent () {
		
		var bitmapData = new BitmapData (100, 100);
		
		Assert.isTrue (bitmapData.transparent);
		Assert.areEqual (hex (0xFFFFFF), hex (bitmapData.getPixel (0, 0)));
		Assert.areEqual (0xFF, bitmapData.getPixel32 (0, 0) >> 24 & 0xFF);
		
		bitmapData.setPixel32 (0, 0, 0x00FFFFFF);
		
		Assert.areEqual (0, bitmapData.getPixel32 (0, 0) >> 24 & 0xFF);
		
		bitmapData = new BitmapData (100, 100, false);
		
		Assert.isFalse (bitmapData.transparent);
		Assert.areEqual (hex (0xFFFFFF), hex (bitmapData.getPixel (0, 0)));
		Assert.areEqual (0xFF, bitmapData.getPixel32 (0, 0) >> 24 & 0xFF);
		
		bitmapData.setPixel32 (0, 0, 0x00FFFFFF);
		
		Assert.areEqual (0xFF, bitmapData.getPixel32 (0, 0) >> 24 & 0xFF);
		
		bitmapData = new BitmapData (100, 100, true);
		bitmapData.setPixel32 (0, 0, 0x00FFFFFF);
		
		var pixels = bitmapData.getPixels (bitmapData.rect);
		pixels.position = 0;
		
		bitmapData = new BitmapData (100, 100, false);
		bitmapData.setPixels (bitmapData.rect, pixels);
		
		Assert.areEqual (0xFF, bitmapData.getPixel32 (0, 0) >> 24 & 0xFF);
		
	}
	
	
	@Test public function width () {
		
		var bitmapData = new BitmapData (1, 1);
		
		Assert.areEqual (1, bitmapData.width);
		
		bitmapData = new BitmapData (100, 100, true, 0xFFFF0000);
		
		Assert.areEqual (100.0, bitmapData.width);
		
	}
	
	
	@Test public function new_ () {
		
		var bitmapData = new BitmapData (100, 100, true, 0xFFFF0000);
		
		Assert.areEqual (hex (0xFFFF0000), hex (bitmapData.getPixel32 (0, 0)));
		
		bitmapData = new BitmapData (100, 100);
		
		Assert.areEqual (hex (0xFFFFFFFF), hex (bitmapData.getPixel32 (0, 0)));
		
	}
	
	
	#if html5 @Ignore #end @Test public function applyFilter () {
		
		#if !html5
		
		//TODO: Test more filters
		
		var filter = new GlowFilter (0xFFFF0000, 1, 10, 10, 100);
		
		var bitmapData = new BitmapData (100, 100, true, 0xFFFF0000);
		var bitmapData2 = new BitmapData (100, 100);
		bitmapData2.applyFilter (bitmapData, bitmapData.rect, new Point (), filter);
		
		Assert.areEqual (hex (0xFFFF0000), hex (bitmapData2.getPixel32 (1, 1)));
		
		var filterRect = bitmapData2.generateFilterRect (bitmapData2.rect, filter);
		
		Assert.isTrue (filterRect.width > 100 && filterRect.width <= 115);
		Assert.isTrue (filterRect.height > 100 && filterRect.height <= 115);
		
		#end
		
	}
	
	
	@Test public function clone () {
		
		var bitmapData = new BitmapData (100, 100);
		var bitmapData2 = bitmapData.clone();
		
		Assert.areNotSame (bitmapData, bitmapData2);
		Assert.areEqual (bitmapData.width, bitmapData2.width);
		Assert.areEqual (bitmapData.height, bitmapData2.height);
		Assert.areEqual (bitmapData.transparent, bitmapData2.transparent);
		Assert.areEqual (bitmapData.getPixel32 (0, 0), bitmapData2.getPixel32 (0, 0));
		
		var bitmapData = new BitmapData (100, 100, false, 0x00FF0000);
		var bitmapData2 = bitmapData.clone();
		
		Assert.areNotSame (bitmapData, bitmapData2);
		Assert.areEqual (bitmapData.width, bitmapData2.width);
		Assert.areEqual (bitmapData.height, bitmapData2.height);
		Assert.areEqual (bitmapData.transparent, bitmapData2.transparent);
		Assert.areEqual (bitmapData.getPixel32 (0, 0), bitmapData2.getPixel32 (0, 0));
		
	}
	
	
	@Test public function colorTransform () {
		
		var colorTransform = new ColorTransform (0, 0, 0, 1, 0xFF, 0, 0, 0);
		
		var bitmapData = new BitmapData (100, 100);
		bitmapData.colorTransform (new Rectangle (0, 0, 50, 50), colorTransform);
		
		Assert.areEqual (hex (0xFFFF0000), hex (bitmapData.getPixel32 (0, 0)));
		Assert.areEqual (hex (0xFFFFFFFF), hex (bitmapData.getPixel32 (50, 50)));
		
		bitmapData = new BitmapData (100, 100);
		bitmapData.colorTransform (bitmapData.rect, colorTransform);
		
		Assert.areEqual (hex (0xFFFF0000), hex (bitmapData.getPixel32 (0, 0)));
		Assert.areEqual (hex (0xFFFF0000), hex (bitmapData.getPixel32 (50, 50)));
		
	}
	
	
	#if !flash @Ignore #end @Test public function compare () {
		
		#if flash
		
		var bitmapData = new BitmapData (50, 50, true, 0xFFFF8800);
		var bitmapData2 = new BitmapData (50, 50, true, 0xCCCC6600);
		var bitmapData3:BitmapData = cast bitmapData.compare (bitmapData2);
		
		Assert.areEqual (hex (0x332200), hex (bitmapData3.getPixel (0, 0)));
		
		bitmapData = new BitmapData (50, 50, true, 0xFFFFAA00);
		bitmapData2 = new BitmapData (50, 50, true, 0xCCFFAA00);
		bitmapData3 = cast bitmapData.compare (bitmapData2);
		
		Assert.areEqual (hex (0x33FFFFFF), hex (bitmapData3.getPixel32 (0, 0)));
		
		bitmapData = new BitmapData (50, 50, false, 0xFFFF0000);
		bitmapData2 = new BitmapData (50, 50, false, 0xFFFF0000);
		
		Assert.areEqual (0, bitmapData.compare (bitmapData));
		Assert.areEqual (0, bitmapData.compare (bitmapData2));
		
		bitmapData = new BitmapData (50, 50);
		bitmapData2 = new BitmapData (60, 50);
		
		Assert.areEqual (-3, bitmapData.compare (bitmapData2));
		
		bitmapData = new BitmapData (50, 50);
		bitmapData2 = new BitmapData (60, 60);
		
		Assert.areEqual (-3, bitmapData.compare (bitmapData2));
		
		bitmapData = new BitmapData (50, 50);
		bitmapData2 = new BitmapData (50, 60);
		
		Assert.areEqual (-4, bitmapData.compare (bitmapData2));
		
		#end
		
	}
	
	
	@Test public function copyChannel () {
		
		var bitmapData = new BitmapData (100, 100, true, 0xFF000000);
		var bitmapData2 = new BitmapData (100, 100, true, 0xFFFF0000);
		
		bitmapData.copyChannel (bitmapData2, bitmapData2.rect, new Point (), BitmapDataChannel.RED, BitmapDataChannel.RED);
		
		Assert.areEqual (hex (0xFFFF0000), hex (bitmapData.getPixel32 (0, 0)));
		
		var bitmapData = new BitmapData (100, 100, false);
		var bitmapData2 = new BitmapData (100, 100, true, 0x00FF0000);
		
		bitmapData.copyChannel (bitmapData2, bitmapData2.rect, new Point (), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
		
		Assert.areEqual (hex (0xFFFFFFFF), hex (bitmapData.getPixel32 (0, 0)));
		
		var bitmapData = new BitmapData (100, 100, true);
		var bitmapData2 = new BitmapData (100, 100, true, 0x22FF0000);
		
		bitmapData.copyChannel (bitmapData2, bitmapData2.rect, new Point (), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
		
		Assert.areEqual (hex (0x22FFFFFF), hex (bitmapData.getPixel32 (0, 0)));
		
		var bitmapData = new BitmapData (100, 80, false, 0x00FF0000);
		
		bitmapData.copyChannel (bitmapData, new Rectangle (0, 0, 20, 20), new Point (10, 10), BitmapDataChannel.RED, BitmapDataChannel.BLUE);
		
		Assert.areEqual (hex (0xFFFF00FF), hex (bitmapData.getPixel32 (10, 10)));
		Assert.areEqual (hex (0xFFFF0000), hex (bitmapData.getPixel32 (30, 30)));
		
	}
	
	
	@Test public function copyPixels () {
		
		var bitmapData = new BitmapData (100, 100);
		var bitmapData2 = new BitmapData (100, 100, true, 0xFFFF0000);
		
		bitmapData.copyPixels (bitmapData2, bitmapData2.rect, new Point ());
		
		Assert.areEqual (hex (0xFFFF0000), hex (bitmapData.getPixel32 (0, 0)));
		
		var bitmapData = new BitmapData (40, 40, false, 0x000000FF);
		var bitmapData2 = new BitmapData (80, 40, false, 0x0000CC44);
		
		bitmapData2.copyPixels (bitmapData, new Rectangle (0, 0, 20, 20), new Point (10, 10));
		
		Assert.areEqual (hex (0xFF00CC44), hex (bitmapData2.getPixel32 (0, 0)));
		Assert.areEqual (hex (0xFF0000FF), hex (bitmapData2.getPixel32 (10, 10)));
		Assert.areEqual (hex (0xFF00CC44), hex (bitmapData2.getPixel32 (30, 30)));
		
	}
	
	
	/*@Ignore @Test*/ public function copyPixelsToByteArray () {
		
		#if flash
		
		/*var bitmapData = new BitmapData (100, 100);
		var bytes = new ByteArray ();
		
		bitmapData.copyPixelsToByteArray (new Rectangle (0, 0, 20, 20), bytes);
		
		Assert.areEqual (20 * 20 * 4, bytes.length);*/
		
		#end
		
	}
	
	
	@Test public function dispose () {
		
		var bitmapData = new BitmapData (100, 100);
		bitmapData.dispose ();
		
		#if flash
		
		try {
			bitmapData.width;
		} catch (e:Dynamic) {
			Assert.isTrue (true);
		}
		
		#elseif neko
		
		Assert.areEqual (null, bitmapData.width);
		Assert.areEqual (null, bitmapData.height);
		
		#else
		
		Assert.areEqual (0, bitmapData.width);
		Assert.areEqual (0, bitmapData.height);
		
		#end
		
	}
	
	
	@Test public function draw () {
		
		var bitmapData = new BitmapData (100, 100);
		var bitmapData2 = new Bitmap (new BitmapData (100, 100, true, 0xFF0000FF));
		
		bitmapData.draw (bitmapData2);
		
		//Assert.areEqual (hex (0xFF0000FF), hex (bitmapData.getPixel32 (0, 0)));
		
		var sprite = new Sprite ();
		sprite.graphics.beginFill (0xFFFF0000);
		sprite.graphics.drawRect (0, 0, 100, 100);
		
		bitmapData.draw (sprite);
		
		//Assert.areEqual (hex (0xFFFF0000), hex (bitmapData.getPixel32 (0, 0)));
		
		var sprite2 = new Sprite ();
		sprite2.graphics.beginFill (0x00FF00);
		sprite2.graphics.drawRect (0, 0, 100, 100);
		
		sprite.x = 50;
		sprite.y = 50;
		sprite2.addChild (sprite);
		
		bitmapData.draw (sprite2);
		
		//TODO: Look into software renderer to find why alpha is off by one
		Assert.isTrue (hex (bitmapData.getPixel32 (50, 50)) == hex (0xFFFF0000) || hex (bitmapData.getPixel32 (50, 50)) == hex (0xFEFF0000));
		
	}
	
	
	/*@Ignore @Test*/ public function encode () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function fillRect () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function floodFill () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function generateFilterRect () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function getColorBoundsRect () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function getPixel () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function getPixel32 () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function getPixels () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function getVector () {
		
		
		
	}
	
	
	private function hex (value:Int):String {
		
		return StringTools.hex (value, 8);
		
	}
	
	
	/*@Ignore @Test*/ public function histogram () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function hitTest () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function lock () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function merge () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function noise () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function paletteMap () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function perlinNoise () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function pixelDissolve () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function scroll () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function setPixel () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function setPixel32 () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function setPixels () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function setVector () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function threshold () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function unlock () {
		
		
		
	}
	
	
	/*
	@Test public function testDispose () {
		
		var bitmapData = new BitmapData (100, 100);
		bitmapData.dispose ();
		
		#if flash
		
		try {
			bitmapData.width;
		} catch (e:Dynamic) {
			Assert.isTrue (true);
		}
		
		#elseif neko
		
		Assert.areEqual (null, bitmapData.width);
		Assert.areEqual (null, bitmapData.height);
		
		#else
		
		Assert.areEqual (0, bitmapData.width);
		Assert.areEqual (0, bitmapData.height);
		
		#end
		
	}
	
	
	@Test public function testDraw () {
		
		var color = 0xFFFF0000;
		var bitmapData = new BitmapData (100, 100);
		var sourceBitmap = new Bitmap (new BitmapData (100, 100, true, color));
		
		bitmapData.draw (sourceBitmap);
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFF0000, 8), StringTools.hex (pixel, 8));
		
	}
	
	
	#if (cpp || neko)
	
	@Test public function testEncode () {
		
		var color = 0xFFFF0000;
		var bitmapData = new BitmapData (100, 100, true, color);
		
		var png = bitmapData.encode ("png");
		bitmapData = BitmapData.loadFromBytes (png);
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (0xFFFF0000, pixel);
		
		var jpg = bitmapData.encode ("jpg", 1);
		bitmapData = BitmapData.loadFromBytes (jpg);
		
		pixel = bitmapData.getPixel32 (1, 1);
		
		// Since JPG is a lossy format, we need to allow for slightly different values
		
		Assert.isTrue ((0xFFFF0000 == pixel) || (0xFFFE0000 == pixel));
		
	}
	
	#end
	
	
	@Test public function testColorBoundsRect () {
		
		var mask = 0xFFFFFFFF;
		var color = 0xFFFFFFFF;
		
		var bitmapData = new BitmapData (100, 100);
		
		var colorBoundsRect = bitmapData.getColorBoundsRect (mask, color);
		
		Assert.areEqual (100.0, colorBoundsRect.width);
		Assert.areEqual (100.0, colorBoundsRect.height);
		
	}
	
	
	@Test public function testGetAndSetPixels () {
		
		var color = 0xFFFF0000;
		
		var bitmapData = new BitmapData (100, 100, true, color);
		var pixels = bitmapData.getPixels (bitmapData.rect);
		
		Assert.areEqual (100 * 100 * 4, pixels.length);
		
		bitmapData = new BitmapData (100, 100);
		
		pixels.position = 0;
		bitmapData.setPixels (bitmapData.rect, pixels);
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFF0000, 8), StringTools.hex (pixel, 8));
		
	}
	
	
	//@Test
	public function testHitTest () {
		
		var bitmapData = new BitmapData (100, 100);
		
		Assert.isFalse (bitmapData.hitTest (new Point (), 0, new Point (101, 101)));
		Assert.isTrue (bitmapData.hitTest (new Point (), 0, new Point (100, 100)));
		
	}
	
	
	//@Test
	public function testMerge () {
		
		#if neko
		
		var color = { a: 0xFF, rgb: 0x000000 };
		var color2 = { a: 0xFF, rgb: 0xFF0000 };
		
		#else
		
		var color = 0xFF000000;
		var color2 = 0xFFFF0000;
		
		#end
		
		var bitmapData = new BitmapData (100, 100, true, color);
		var sourceBitmapData = new BitmapData (100, 100, true, color2);
		
		bitmapData.merge (sourceBitmapData, sourceBitmapData.rect, new Point (), 1, 1, 1, 1);
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		#if neko
		
		Assert.areEqual (0xFF, pixel.a);
		Assert.areEqual (0xFF0000, pixel.rgb);
		
		#else
		
		Assert.areEqual (0xFFFF0000, pixel);
		
		#end
		
	}
	
	
	@Test public function testScroll () {
		
		var color = 0xFFFF0000;
		var bitmapData = new BitmapData (100, 100);
		
		bitmapData.fillRect (new Rectangle (0, 0, 100, 10), color);
		bitmapData.scroll (0, 10);
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFF0000, 8), StringTools.hex (pixel, 8));
		
		bitmapData.scroll (0, -20);
		
		pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFFFFFF, 8), StringTools.hex (pixel, 8));
		
	}*/
	
	
}

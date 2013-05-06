package flash.display;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
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
		Assert.areEqual (0xFFFFFF, bitmapData.getPixel (0, 0));
		Assert.areEqual (0xFF, bitmapData.getPixel32 (0, 0) >> 24 & 0xFF);
		
		bitmapData.setPixel32 (0, 0, 0x00FFFFFF);
		
		Assert.areEqual (0, bitmapData.getPixel32 (0, 0) >> 24 & 0xFF);
		
		bitmapData = new BitmapData (100, 100, false);
		
		Assert.isFalse (bitmapData.transparent);
		Assert.areEqual (0xFFFFFF, bitmapData.getPixel (0, 0));
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
	
	
	/*@Test public function testBasics () {
		
		var bitmapData = new BitmapData (100, 100, true, 0xFFFF0000);
		
		Assert.areEqual (100, bitmapData.width);
		Assert.areEqual (100, bitmapData.height);
		
		Assert.areEqual (0.0, bitmapData.rect.x);
		Assert.areEqual (0.0, bitmapData.rect.y);
		Assert.areEqual (100.0, bitmapData.rect.width);
		Assert.areEqual (100.0, bitmapData.rect.height);
		
		var pixel = bitmapData.getPixel (1, 1);
		
		Assert.areEqual (0xFF0000, pixel);
		
		pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFF0000, 8), StringTools.hex (pixel, 8));
		var color = 0x0000FF00;
		
		for (setX in 0...100) {
			
			for (setY in 0...100) {
				
				bitmapData.setPixel32 (setX, setY, color);
				
			}
			
		}
		
		pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.isTrue ((StringTools.hex (pixel, 8) == StringTools.hex (0x0000FF00, 8)) || pixel == 0);
		
		bitmapData.fillRect (bitmapData.rect, color);
		
		pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.isTrue ((StringTools.hex (0x0000FF00, 8) == StringTools.hex (pixel, 8)) || pixel == 0);
		
	}
	
	
	@Test public function testFilter () {
		
		var bitmapData = new BitmapData (100, 100);
		var color = 0xFFFF0000;
		var filter = new GlowFilter (color, 1, 10, 10, 100);
		
		var sourceBitmapData = new BitmapData (100, 100, true, color);
		bitmapData.applyFilter (sourceBitmapData, sourceBitmapData.rect, new Point (), filter);
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFF0000, 8), StringTools.hex (pixel, 8));
		
		var filterRect = untyped bitmapData.generateFilterRect (bitmapData.rect, filter);
		
		Assert.isTrue (filterRect.width > 100 && filterRect.width <= 115);
		Assert.isTrue (filterRect.height > 100 && filterRect.height <= 115);
		
	}
	
	
	@Test public function testClone () {
		
		var color = 0xFFFF0000;
		var bitmapData = new BitmapData (100, 100, true, color);
		var cloneBitmapData = bitmapData.clone ();
		
		Assert.areNotSame (cloneBitmapData, bitmapData);
		
		var pixel = bitmapData.getPixel32 (1, 1);
		var clonePixel = cloneBitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (pixel, clonePixel);
		
	}
	
	
	@Test public function testColorTransform () {
		
		var bitmapData = new BitmapData (100, 100);
		bitmapData.colorTransform (bitmapData.rect, new ColorTransform (0, 0, 0, 1, 0xFF, 0, 0, 0));
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFF0000, 8), StringTools.hex (pixel, 8));
		
	}
	
	
	@Test public function testCopyChannel () {
		
		var color = 0xFF000000;
		var color2 = 0xFFFF0000;
		
		var bitmapData = new BitmapData (100, 100, true, color);
		var sourceBitmapData = new BitmapData (100, 100, true, color2);
		
		bitmapData.copyChannel (sourceBitmapData, sourceBitmapData.rect, new Point (), BitmapDataChannel.RED, BitmapDataChannel.RED);
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFF0000, 8), StringTools.hex (pixel, 8));
		
	}
	
	
	@Test public function testCopyPixels () {
		
		var color = 0xFFFF0000;
		var bitmapData = new BitmapData (100, 100);
		var sourceBitmapData = new BitmapData (100, 100, true, color);
		
		bitmapData.copyPixels (sourceBitmapData, sourceBitmapData.rect, new Point ());
		
		var pixel = bitmapData.getPixel32 (1, 1);
		
		Assert.areEqual (StringTools.hex (0xFFFF0000, 8), StringTools.hex (pixel, 8));
		
	}
	
	
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

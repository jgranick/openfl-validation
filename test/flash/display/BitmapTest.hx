package flash.display;


import flash.display.Bitmap;
import flash.display.BitmapData;
import massive.munit.Assert;


class BitmapTest {
	
	
	@Test public function testBitmap () {
		
		var bitmap = new Bitmap ();
		var bitmapData = new BitmapData (100, 100, false, 0xFF0000);
		
		bitmap.bitmapData = bitmapData;
		
		Assert.areEqual (100.0, bitmap.width);
		Assert.areEqual (100.0, bitmap.height);
		
		bitmap.bitmapData = null;
		
		Assert.areEqual (0.0, bitmap.width);
		Assert.areEqual (0.0, bitmap.height);
		
	}
	
	
}

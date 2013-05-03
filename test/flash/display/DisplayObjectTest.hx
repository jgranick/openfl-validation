package flash.display;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.Lib;
import massive.munit.Assert;


class DisplayObjectTest {
	
	
	@Test public function testRect () {
		
		var sprite = new Sprite ();
		sprite.x = 100;
		sprite.y = 100;
		sprite.scaleX = 0.5;
		sprite.scaleY = 0.5;
		
		var bitmap = new Bitmap (new BitmapData (100, 100));
		sprite.addChild (bitmap);
		
		var rect = sprite.getRect (sprite);
		
		Assert.areEqual (0.0, rect.x);
		Assert.areEqual (0.0, rect.y);
		Assert.areEqual (100.0, rect.width);
		Assert.areEqual (100.0, rect.height);
		
		rect = sprite.getRect (Lib.current.stage);
		
		Assert.areEqual (100.0, rect.x);
		Assert.areEqual (100.0, rect.y);
		Assert.areEqual (50.0, rect.width);
		Assert.areEqual (50.0, rect.height);
		
		sprite.removeChild (bitmap);
		sprite.graphics.beginFill (0xFFFFFF);
		sprite.graphics.lineStyle (10);
		sprite.graphics.drawRect (0, 0, 100, 100);
		
		var bounds = sprite.getRect (sprite);
		
		Assert.isTrue (bounds.x <= 0);
		Assert.isTrue (bounds.y <= 0);
		Assert.isTrue (bounds.width >= 100);
		Assert.isTrue (bounds.height >= 100);
		
		bounds = sprite.getRect (Lib.current.stage);
		
		Assert.isTrue (bounds.x <= 100);
		Assert.isTrue (bounds.y <= 100);
		Assert.isTrue (bounds.width >= 50);
		Assert.isTrue (bounds.height >= 50);
		
	}
	
	
	@Test public function testCoordinates () {
		
		var sprite = new Sprite ();
		sprite.x = 100;
		sprite.y = 100;
		sprite.scaleX = 0.5;
		sprite.scaleY = 0.5;
		
		var globalPoint = sprite.localToGlobal (new Point ());
		
		Assert.areEqual (100.0, globalPoint.x);
		Assert.areEqual (100.0, globalPoint.y);
		
		var localPoint = sprite.globalToLocal (new Point ());
		
		// It should be -200, not -100, because the scale of the Sprite is reduced
		
		Assert.areEqual (-200.0, localPoint.x);
		Assert.areEqual (-200.0, localPoint.y);
		
		var bitmap = new Bitmap (new BitmapData (100, 100));
		sprite.addChild (bitmap);
		
		Assert.isTrue (sprite.hitTestPoint (100, 100));
		Assert.isFalse (sprite.hitTestPoint (151, 151));
		
	}
	

}

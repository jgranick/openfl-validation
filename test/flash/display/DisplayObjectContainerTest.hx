package flash.display;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;
import flash.Lib;
import massive.munit.Assert;


class DisplayObjectContainerTest {
	
	
	/*@Ignore @Test*/ public function mouseChildren () {
		
		
		
	}
	
	
	@Test public function numChildren () {
		
		var sprites = [];
		
		for (i in 0...4) {
			
			sprites.push (new Sprite ());
			
		}
		
		Assert.areEqual (0, sprites[0].numChildren);
		
		for (i in 1...4) {
			
			sprites[0].addChild (sprites[i]);
			Assert.areEqual (i, sprites[0].numChildren);
			
		}
		
		for (i in 1...4) {
			
			sprites[0].removeChild (sprites[i]);
			Assert.areEqual (3 - i, sprites[0].numChildren);
			
		}
		
	}
	
	
	/*@Ignore @Test*/ public function tabChildren () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function textSnapshot () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ /*public function new_ () {
		
		
		
	}*/
	
	
	@Test public function addChild () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		
		sprite.addChild (sprite2);
		
		Assert.areEqual (1, sprite.numChildren);
		Assert.areSame (sprite2, sprite.getChildAt (0));
		
		var sprite3 = new Sprite ();
		
		sprite.addChild (sprite3);
		
		Assert.areEqual (2, sprite.numChildren);
		Assert.areEqual (0, sprite.getChildIndex (sprite2));
		Assert.areEqual (1, sprite.getChildIndex (sprite3));
		
		sprite.addChild (sprite2);
		
		Assert.areEqual (0, sprite.getChildIndex (sprite3));
		Assert.areEqual (1, sprite.getChildIndex (sprite2));
		
		sprite2.addChild (sprite3);
		
		Assert.areSame (sprite3.parent, sprite2);
		
	}
	
	
	@Test public function addChildAt () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		
		sprite.addChildAt (sprite2, 0);
		
		Assert.areEqual (1, sprite.numChildren);
		Assert.areSame (sprite2, sprite.getChildAt (0));
		
		var sprite3 = new Sprite ();
		
		sprite.addChildAt (sprite3, 1);
		
		Assert.areEqual (2, sprite.numChildren);
		Assert.areEqual (0, sprite.getChildIndex (sprite2));
		Assert.areEqual (1, sprite.getChildIndex (sprite3));
		
		sprite.addChildAt (sprite2, 0);
		
		Assert.areEqual (0, sprite.getChildIndex (sprite2));
		Assert.areEqual (1, sprite.getChildIndex (sprite3));
		
		sprite.addChildAt (sprite2, 1);
		
		Assert.areEqual (0, sprite.getChildIndex (sprite3));
		Assert.areEqual (1, sprite.getChildIndex (sprite2));
		
	}
	
	
	/*@Ignore @Test*/ public function areInaccessibleObjectsUnderPoint () {
		
		
		
	}
	
	
	@Test public function contains () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		
		Assert.isFalse (sprite.contains (sprite2));
		
		sprite.addChild (sprite2);
		
		Assert.isTrue (sprite.contains (sprite2));
		
		var sprite3 = new Sprite ();
		
		sprite.addChild (sprite3);
		
		Assert.isTrue (sprite.contains (sprite3));
		
		sprite.removeChild (sprite3);
		sprite.removeChild (sprite2);
		
		Assert.isFalse (sprite.contains (sprite2));
		Assert.isFalse (sprite.contains (sprite3));
		
	}
	
	
	@Test public function getChildAt () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		
		sprite.addChild (sprite2);
		
		Assert.areSame (sprite2, sprite.getChildAt (0));
		
		var sprite3 = new Sprite ();
		sprite.addChild (sprite3);
		
		Assert.areSame (sprite3, sprite.getChildAt (1));
		
		sprite2.addChild (sprite3);
		
		Assert.areSame (sprite3, sprite2.getChildAt (0));
		
		try {
			
			sprite.getChildAt (2);
			Assert.fail ("");
			
		} catch (e:Dynamic) {}
		
	}
	
	
	@Test public function getChildByName () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		var sprite3 = new Sprite ();
		
		sprite2.name = "a";
		sprite3.name = "a";
		
		sprite.addChild (sprite2);
		sprite.addChild (sprite3);
		
		Assert.isNull (sprite.getChildByName ("b"));
		Assert.areSame (sprite2, sprite.getChildByName ("a"));
		
		sprite3.name = "b";
		
		Assert.areSame (sprite3, sprite.getChildByName ("b"));
		
	}
	
	
	@Test public function getChildIndex () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		var sprite3 = new Sprite ();
		
		sprite.addChild (sprite2);
		sprite.addChild (sprite3);
		
		Assert.areEqual (0, sprite.getChildIndex (sprite2));
		Assert.areEqual (1, sprite.getChildIndex (sprite3));
		
		try {
			
			sprite2.getChildIndex (sprite3);
			Assert.fail ("");
			
		} catch (e:Dynamic) {}
		
	}
	
	
	@Test public function getObjectsUnderPoint () {
		
		var sprite = new Sprite ();
		
		var sprite2 = new Sprite ();
		sprite2.graphics.beginFill (0xFF0000);
		sprite2.graphics.drawRect (0, 0, 100, 100);
		sprite.addChild (sprite2);
		
		Assert.areEqual (sprite2, sprite.getObjectsUnderPoint (new Point (10, 10))[0]);
		Assert.areEqual (0, sprite.getObjectsUnderPoint (new Point ()).length);
		
		sprite.removeChild (sprite2);
		
		Assert.areEqual (0, sprite.getObjectsUnderPoint (new Point ()).length);
		
	}
	
	
	@Test public function removeChild () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		var sprite3 = new Sprite ();
		
		sprite.addChild (sprite2);
		sprite.addChild (sprite3);
		sprite.removeChild (sprite2);
		sprite.removeChild (sprite3);
		
		Assert.areEqual (0, sprite.numChildren);
		
		try {
			
			sprite.removeChild (sprite2);
			Assert.fail ("");
			
		} catch (e:Dynamic) {}
		
	}
	
	
	@Test public function removeChildAt () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		var sprite3 = new Sprite ();
		
		sprite.addChild (sprite2);
		sprite.addChild (sprite3);
		sprite.removeChildAt (0);
		sprite.removeChildAt (0);
		
		Assert.areEqual (0, sprite.numChildren);
		
		try {
			
			sprite.removeChildAt (0);
			Assert.fail ("");
			
		} catch (e:Dynamic) {}
		
	}
	
	
	@Test public function setChildIndex () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		var sprite3 = new Sprite ();
		
		sprite.addChild (sprite2);
		sprite.addChild (sprite3);
		
		sprite.setChildIndex (sprite3, 0);
		
		Assert.areEqual (0, sprite.getChildIndex (sprite3));
		
		sprite.setChildIndex (sprite2, 0);
		
		Assert.areEqual (0, sprite.getChildIndex (sprite2));
		
		try {
			
			sprite.removeChild (sprite2);
			sprite.setChildIndex (sprite2, 0);
			Assert.fail ("");
			
		} catch (e:Dynamic) {}
		
	}
	
	
	@Test public function swapChildren () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		var sprite3 = new Sprite ();
		
		sprite.addChild (sprite2);
		sprite.addChild (sprite3);
		
		sprite.swapChildren (sprite2, sprite3);
		
		Assert.areEqual (0, sprite.getChildIndex (sprite3));
		Assert.areEqual (1, sprite.getChildIndex (sprite2));
		
		try {
			
			sprite.removeChild (sprite2);
			sprite.swapChildren (sprite2, sprite3);
			Assert.fail ("");
			
		} catch (e:Dynamic) {}
		
	}
	
	
	@Test public function swapChildrenAt () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		var sprite3 = new Sprite ();
		
		sprite.addChild (sprite2);
		sprite.addChild (sprite3);
		
		sprite.swapChildrenAt (0, 1);
		
		Assert.areEqual (0, sprite.getChildIndex (sprite3));
		Assert.areEqual (1, sprite.getChildIndex (sprite2));
		
		try {
			
			sprite.removeChild (sprite2);
			sprite.swapChildrenAt (0, 1);
			Assert.fail ("");
			
		} catch (e:Dynamic) {}
		
	}
	
	
}
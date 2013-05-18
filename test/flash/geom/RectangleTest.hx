package flash.geom;


import massive.munit.Assert;


class RectangleTest {
	
	
	@Test public function bottom () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.areEqual (100, rect.bottom);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (0, rect.bottom);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.bottom);
		
	}
	
	
	@Test public function bottomRight () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.isNotNull (rect.bottomRight);
		Assert.isType (rect.bottomRight, flash.geom.Point);
		
		Assert.areEqual (100, rect.bottomRight.x);
		Assert.areEqual (100, rect.bottomRight.y);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (0, rect.bottomRight.x);
		Assert.areEqual (0, rect.bottomRight.y);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.bottomRight.x);
		Assert.areEqual (0, rect.bottomRight.y);
		
	}
	
	
	@Test public function height () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.areEqual (100, rect.height);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (100, rect.height);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.height);
		
	}
	
	
	@Test public function left () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.areEqual (0, rect.left);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (-100, rect.left);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.left);
		
	}
	
	
	@Test public function right () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.areEqual (100, rect.right);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (0, rect.right);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.right);
		
	}
	
	
	@Test public function size () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.isNotNull (rect.size);
		Assert.isType (rect.size, flash.geom.Point);
		
		Assert.areEqual (100, rect.size.x);
		Assert.areEqual (100, rect.size.y);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (100, rect.size.x);
		Assert.areEqual (100, rect.size.y);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.size.x);
		Assert.areEqual (0, rect.size.y);
		
	}
	
	
	@Test public function top () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.areEqual (0, rect.top);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (-100, rect.top);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.top);
		
	}
	
	
	@Test public function topLeft () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.isNotNull (rect.topLeft);
		Assert.isType (rect.topLeft, flash.geom.Point);
		
		Assert.areEqual (0, rect.topLeft.x);
		Assert.areEqual (0, rect.topLeft.y);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (-100, rect.topLeft.x);
		Assert.areEqual (-100, rect.topLeft.y);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.topLeft.x);
		Assert.areEqual (0, rect.topLeft.y);
		
	}
	
	
	@Test public function width () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.areEqual (100, rect.width);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (100, rect.width);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.width);
		
	}
	
	
	@Test public function x () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.areEqual (0, rect.x);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (-100, rect.x);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.x);
		
	}
	
	
	@Test public function y () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.areEqual (0, rect.y);
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.areEqual (-100, rect.y);
		
		rect = new Rectangle (0, 0, 0, 0);
		
		Assert.areEqual (0, rect.y);
		
	}
	
	
	@Test public function new () {
		
		var rect = new Rectangle ();
		
		Assert.isNotNull (rect);
		Assert.areEqual (0, rect.x);
		Assert.areEqual (0, rect.y);
		Assert.areEqual (0, rect.width);
		Assert.areEqual (0, rect.height);
		
		rect = new Rectangle (100, 100, 100, 100);
		
		Assert.areEqual (100, rect.x);
		Assert.areEqual (100, rect.y);
		Assert.areEqual (100, rect.width);
		Assert.areEqual (100, rect.height);
		
	}
	
	
	@Test public function clone () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		var clone = rect.clone ();
		
		Assert.areNotSame (rect, clone);
		Assert.areEqual (rect.x, clone.x);
		Assert.areEqual (rect.y, clone.y);
		Assert.areEqual (rect.width, clone.width);
		Assert.areEqual (rect.height, clone.height);
		
	}
	
	
	@Test public function contains () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.isTrue (rect.contains (0, 0));
		Assert.isTrue (rect.contains (99, 99));
		Assert.isFalse (rect.contains (100, 100));
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.isTrue (rect.contains (-1, -1));
		Assert.isTrue (rect.contains (-100, -100));
		Assert.isFalse (rect.contains (-101, -101));
		
	}
	
	
	@Test public function containsPoint () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.isTrue (rect.containsPoint (new Point (0, 0)));
		Assert.isTrue (rect.containsPoint (new Point (99, 99)));
		Assert.isFalse (rect.containsPoint (new Point (100, 100)));
		
		rect = new Rectangle (-100, -100, 100, 100);
		
		Assert.isTrue (rect.containsPoint (new Point (-1, -1)));
		Assert.isTrue (rect.containsPoint (new Point (-100, -100)));
		Assert.isFalse (rect.containsPoint (new Point (-101, -101)));
		
	}
	
	
	@Test public function containsRect () {
		
		var rect = new Rectangle (0, 0, 100, 100);
		
		Assert.isTrue (rect.containsRect (new Rectangle (0, 0, 100, 100)));
		Assert.isFalse (rect.containsRect (new Rectangle ()));
		Assert.isFalse (rect.containsRect (new Rectangle (0, 0, 1, 0)));
		Assert.isTrue (rect.containsRect (new Rectangle (0, 0, 1, 1)));
		Assert.isTrue (rect.containsRect (new Rectangle (1, 1)));
		Assert.isFalse (rect.containsRect (new Rectangle (-1, 0, 100, 100)));
		Assert.isFalse (rect.containsRect (new Rectangle (0, 0, 100, 101)));
		
		rect = new Rectangle (-100, -100, 200, 200);
		
		Assert.isTrue (rect.containsRect (new Rectangle (-100, -100, 200, 200)));
		Assert.isTrue (rect.containsRect (new Rectangle ()));
		Assert.isFalse (rect.containsRect (new Rectangle (-100, -100)));
		Assert.isFalse (rect.containsRect (new Rectangle (100, 100)));
		Assert.isTrue (rect.containsRect (new Rectangle (99, 99)));
		Assert.isFalse (rect.containsRect (new Rectangle (-101, -100, 200, 200)));
		Assert.isFalse (rect.containsRect (new Rectangle (-100, -100, 201, 201)));
		
	}
	
	
	@Ignore @Test public function copyFrom () {
		
		
		
	}
	
	
	@Ignore @Test public function equals () {
		
		
		
	}
	
	
	@Ignore @Test public function inflate () {
		
		
		
	}
	
	
	@Ignore @Test public function inflatePoint () {
		
		
		
	}
	
	
	@Ignore @Test public function intersection () {
		
		
		
	}
	
	
	@Ignore @Test public function intersects () {
		
		
		
	}
	
	
	@Ignore @Test public function isEmpty () {
		
		
		
	}
	
	
	@Ignore @Test public function offset () {
		
		
		
	}
	
	
	@Ignore @Test public function offsetPoint () {
		
		
		
	}
	
	
	@Ignore @Test public function setPoint () {
		
		
		
	}
	
	
	@Ignore @Test public function setTo () {
		
		
		
	}
	
	
	/*@Ignore @Test public function toString () {
		
		
		
	}*/
	
	
	@Ignore @Test public function union () {
		
		
		
	}
	
	
}
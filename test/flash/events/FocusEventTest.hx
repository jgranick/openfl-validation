package flash.events;


import flash.display.Sprite;
import flash.events.FocusEvent;
import massive.munit.Assert;


class FocusEventTest {
	
	
	/*@Ignore @Test*/ public function isRelatedObjectInaccessible () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function keyCode () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function relatedObject () {
		
		
		
	}
	
	
	/*@Ignore @Test*/ public function shiftKey () {
		
		
		
	}
	
	
	@Test public function new_ () {
		
		var sprite = new Sprite ();
		var sprite2 = new Sprite ();
		sprite.addChild (sprite2);
		
		var called = false;
		
		var spriteListener = function (e) {
			
			Assert.areSame (sprite, e.target);
			Assert.areSame (sprite, e.currentTarget);
			Assert.isNull (e.relatedObject);
			
			called = true;
			
		}
		
		var sprite2Listener = function (e) {
			
			Assert.fail ("Should not call child");
			
		}
		
		sprite.addEventListener (FocusEvent.FOCUS_IN, spriteListener);
		sprite2.addEventListener (FocusEvent.FOCUS_IN, sprite2Listener);
		
		Lib.current.stage.focus = sprite;
		Assert.isTrue (called);
		
		sprite.removeEventListener (FocusEvent.FOCUS_IN, spriteListener);
		sprite2.removeEventListener (FocusEvent.FOCUS_IN, sprite2Listener);
		
		var called = false;
		var called2 = false;
		
		spriteListener = function (e) {
			
			called = true;
			
			Assert.areSame (sprite, e.target);
			Assert.areSame (sprite, e.currentTarget);
			Assert.areSame (sprite2, e.relatedObject);
			
		}
		
		sprite2Listener = function (e) {
			
			called2 = true;
			
			Assert.areSame (sprite2, e.target);
			Assert.areSame (sprite2, e.currentTarget);
			Assert.areSame (sprite, e.relatedObject);
			
		}
		
		sprite.addEventListener (FocusEvent.FOCUS_OUT, spriteListener);
		sprite2.addEventListener (FocusEvent.FOCUS_IN, sprite2Listener);
		
		Lib.current.stage.focus = sprite2;
		
		Assert.isTrue (called);
		Assert.isTrue (called2);
		
		sprite.removeEventListener (FocusEvent.FOCUS_OUT, spriteListener);
		sprite2.removeEventListener (FocusEvent.FOCUS_IN, sprite2Listener);
		called2 = false;
		
		spriteListener = function (e) {
			
			Assert.fail ("Should not be called");
			
		}
		
		sprite2Listener = function (e) {
			
			called2 = true;
			
			Assert.areSame (sprite2, e.target);
			Assert.areSame (sprite2, e.currentTarget);
			Assert.areSame (null, e.relatedObject);
			
		}
		
		sprite.addEventListener (FocusEvent.FOCUS_OUT, spriteListener);
		sprite2.addEventListener (FocusEvent.FOCUS_OUT, sprite2Listener);
		
		Lib.current.stage.focus = null;
		Assert.isTrue (called2);
		
	}
	
	
}
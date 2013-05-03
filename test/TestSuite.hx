import massive.munit.TestSuite;

import ExampleTest;
import flash.display.DisplayObjectContainerTest;
import flash.display.DisplayObjectTest;
import flash.display.BitmapDataTest;
import flash.display.GraphicsTest;
import flash.display.BitmapTest;
import flash.utils.ByteArrayTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(ExampleTest);
		add(flash.display.DisplayObjectContainerTest);
		add(flash.display.DisplayObjectTest);
		add(flash.display.BitmapDataTest);
		add(flash.display.GraphicsTest);
		add(flash.display.BitmapTest);
		add(flash.utils.ByteArrayTest);
	}
}

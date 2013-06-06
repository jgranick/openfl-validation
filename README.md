Install
-------

    git clone https://github.com/openfl/openfl-validation
    haxelib dev openfl-validation openfl-validation
    haxelib install munit
    
Testing
-------

For HTML5 or Flash Player, you can use munit to run the testing:

    cd openfl-validation
    haxelib run munit test
    
For other targets, you can test using the normal OpenFL "test" command:

    cd openfl-validation
    openfl test windows
    openfl test windows -neko
    (etc)

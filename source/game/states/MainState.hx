package game.states;

import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.net.FileReference;
import flixel.ui.FlxButton;
import sys.io.File;
import haxe.Http;
class MainState extends MusicBeatState
{
	private var BG:FlxSprite;
	private var doShit:FlxSprite;

	private var downloadURL:String = "https://github.com/Hackx2/FNF-AstroEngine/releases/download/0.2.1/AstroEngine.32bit.zip";
    private var _file:FileReference;
	override function create()
	{
		BG = new FlxSprite(-80).loadGraphic(backend.utils.Paths.image('menuDesat', 'shared'));
		BG.scrollFactor.set(0, 0);
		BG.setGraphicSize(Std.int(BG.width * 1.175));
		BG.screenCenter();
		BG.antialiasing = true;
		BG.color = 0xffffb87e;
		add(BG);

		var doShit:FlxButton = new FlxButton(0, 600, "Download", function()
		{
			tracev2("lmao", 'add');

            var http = new Http(downloadURL);
            http.onData = function(data:String) {
                _file = new FileReference();
                _file.addEventListener(Event.COMPLETE, onSaveComplete);
                _file.addEventListener(Event.CANCEL, onSaveCancel);
                _file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
                _file.save(data, "AstroEngine.zip");
            };
            http.onError = function(error:String) {
                trace("Error downloading file: " + error);
            };
            http.request(false); // false for GET request
        });
		doShit.screenCenter(X);
		doShit.scale.set(2.4, 2.4);
		add(doShit);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public static function tracev2(what:String, type:String = 'add')
	{
		if (what == null || type == null)
			return;
		Reflect.field(FlxG.log, type)(what);
		trace(what);
	}

    function removeStuff() {
        _file.removeEventListener(Event.COMPLETE, onSaveComplete);
        _file.removeEventListener(Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
    }

	function onSaveComplete(_):Void
	{
		removeStuff();
		FlxG.log.notice("Successfully saved file.");
	}
	function onSaveCancel(_):Void
		removeStuff();
	function onSaveError(_):Void
	{
		removeStuff();
		FlxG.log.error("Problem saving file");
	}
}

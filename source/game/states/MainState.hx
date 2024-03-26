package game.states;

import backend.data.EngineData;
import openfl.events.ProgressEvent;
import openfl.net.URLRequest;
import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.net.FileReference;
import flixel.ui.FlxButton;
import sys.io.File;
import haxe.Http;
import game.Main.*;

class MainState extends MusicBeatState
{
	// Background
	private var BG:FlxSprite;
	private var doShit:FlxSprite;
    private var logo:FlxSprite;

	//Download Bar Stuff
	private var laSexyBar:FlxSprite;
	private var urlRequest:URLRequest;

	// Download Shit
	private var bit:Float = 64;
	private var downloadURL:String;
	private var newVersion:String = "1.9.9";

	override function create()
	{
		BG = new FlxSprite(-80).loadGraphic(backend.utils.Paths.image('bgs/dark', 'shared'));
		BG.scrollFactor.set(0, 0);
		BG.setGraphicSize(Std.int(BG.width * 1.175));
		BG.screenCenter();
		add(BG);

		logo = new FlxSprite();
		logo.frames = Paths.getSparrowAtlas('logoBumpin', 'shared');
		logo.animation.addByPrefix('whatthefuck', 'logo bumpin', 24, true);
		logo.animation.play('whatthefuck');
        logo.scale.set(0.7,0.7);
        logo.antialiasing = true;
        logo.setPosition(FlxG.width - (logo.width - 50), -50);
		add(logo);

		var doShit:FlxButton = new FlxButton(0, 600, "Download", onClick);
		doShit.screenCenter(X);
		doShit.scale.set(2.4, 2.4);
		doShit.x -= 350;
		add(doShit);

		laSexyBar = new FlxSprite((FlxG.width - 200) / 2, (FlxG.height - 20) / 2);
		laSexyBar.makeGraphic(200, 20, 0xFF000000);
		laSexyBar.scale.x = 0;
		laSexyBar.visible = false;
		add(laSexyBar);
	}

    override function update(elapsed:Float)
        super.update(elapsed);

	private function onClick():Void
	{
		var fileRef:FileReference = new FileReference();
		urlRequest = new URLRequest(downloadURL);
		fileRef.addEventListener(Event.COMPLETE, onLoadComplete);
		fileRef.addEventListener(ProgressEvent.PROGRESS, onProgress);

		fileRef.download(urlRequest, "game.zip");
		tracev2("Downloading >w<");
	}

	private function onProgress(event:ProgressEvent):Void
	{
		var fuck:Float = event.bytesLoaded / event.bytesTotal;

		laSexyBar.visible = true;
		laSexyBar.scale.x = fuck;
		tracev2('Download Progress: ${Math.round(fuck * 100)}%');
	}

	private function onLoadComplete(event:Event):Void
	{
		laSexyBar.visible = false;
		tracev2("Download Completed >w<");
	}


	public function new()
	{
		super();

		var http = new haxe.Http("https://raw.githubusercontent.com/Hackx2/FNF-AstroEngine/main/gitVersion.txt");

		http.onData = function(data:String)
		{
			newVersion = data.split('\n')[0].trim();
			trace('FUCK: $newVersion  | $data');
			var curVersion:String = EngineData.mainCoreShit.coreVersion.trim();
			trace('version online: ' + newVersion + ', your version: ' + curVersion);
		}

		http.onError = function(error)
		{
			trace('error: $error');
		}

		http.request();

		downloadURL = 'https://github.com/Hackx2/FNF-AstroEngine/releases/download/${newVersion}/AstroEngine.${bit}bit.zip';
	}
}

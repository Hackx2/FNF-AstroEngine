package game.states;

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
	private var logo:FlxSprite;

	// Download Bar Stuff
	private var laSexyBar:FlxSprite;
	private var urlRequest:URLRequest;
	private var downloadPercent:FlxText;

	// Download Shit
	private var bit:Float = 64;
	private var downloadURL:String;
	private var newVersion:String;
	private var doShit:FlxButton;

	override function create()
	{
		BG = new FlxSprite().loadGraphic(Paths.image('bgs/lightNormal'));
		BG.scrollFactor.set(0, 0);
		BG.screenCenter();
		add(BG);

		logo = new FlxSprite();
		logo.frames = Paths.getSparrowAtlas('logoBumpin');
		logo.animation.addByPrefix('whatthefuck', 'logo bumpin', 24, true);
		logo.animation.play('whatthefuck');
		logo.scale.set(0.9, 0.9);
		logo.antialiasing = true;
		logo.screenCenter(XY);
		logo.y -= 75;
		add(logo);

		doShit = new FlxButton(0, 600, "Download", onClick);
		doShit.screenCenter(X);
		doShit.scale.set(2.7, 2.7);
		//doShit.x -= 350;
		add(doShit);

		laSexyBar = new FlxSprite((FlxG.width - 200) / 2, (FlxG.height - 20) / 2);
		laSexyBar.makeGraphic(200, 20, 0xFF000000);
		laSexyBar.scale.x = 0;

		downloadPercent = new FlxText();
		downloadPercent.setFormat(Paths.font("PhantomMuff.ttf"), 24, FlxColor.BLACK);
		downloadPercent.screenCenter();
		downloadPercent.y += 150;
	}

	override function update(elapsed:Float)
		super.update(elapsed);

	private function onClick():Void
	{
		var fileRef:FileReference = new FileReference();
		urlRequest = new URLRequest(downloadURL);
		fileRef.addEventListener(Event.COMPLETE, complete);
		fileRef.addEventListener(ProgressEvent.PROGRESS, progress);
		fileRef.addEventListener(Event.CANCEL, dude);

		fileRef.download(urlRequest, 'AstroEngine${bit}bit.zip');

		tracev2("Downloading >w<");
	}

	private function dude(_):Void {
		return;
	}

	private function progress(event:ProgressEvent):Void
	{
		var fuck:Float = event.bytesLoaded / event.bytesTotal;
		var rounded:Float = Math.round((fuck) * 100);
		var lastPer = rounded;

		FlxG.watch.addQuick("Downloaded Percent: ", rounded);

		add(downloadPercent);
		downloadPercent.text = '${rounded}%';
		doShit.visible = false;
		tracev2('Download Progress: $rounded%');
		//laSexyBar.scale.x = fuck;
	}

	private function complete(event:Event):Void
	{
		remove(downloadPercent);
		doShit.visible = true;
		tracev2("Download Completed >w<");
	}

	public function new()
	{
		super();

		var http = new Http("https://raw.githubusercontent.com/Hackx2/FNF-AstroEngine/main/gitVersion.txt");

		http.onData = function(data:String)
		{
			newVersion = data.split('\n')[0].trim();
			trace('version online: ' + newVersion + ', your version: ' + EngineData.mainCoreShit.coreVersion.trim());
		}

		http.onError = function(error)
		{
			trace('error: $error');
		}

		http.request();

		downloadURL = 'https://github.com/Hackx2/FNF-AstroEngine/releases/download/${newVersion}/AstroEngine.${bit}bit.zip';
	}
}

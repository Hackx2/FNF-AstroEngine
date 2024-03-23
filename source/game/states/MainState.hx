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
	private var BG:FlxSprite;
	private var doShit:FlxSprite;

	private var downloadURL:String = "https://github.com/Hackx2/FNF-AstroEngine/releases/download/0.2.1/AstroEngine.32bit.zip";
	
    private var laSexyBar:FlxSprite;
    private var urlRequest:URLRequest;

    override function create()
	{
		BG = new FlxSprite(-80).loadGraphic(backend.utils.Paths.image('menuDesat', 'shared'));
		BG.scrollFactor.set(0, 0);
		BG.setGraphicSize(Std.int(BG.width * 1.175));
		BG.screenCenter();
		BG.antialiasing = true;
		BG.color = 0xffffb87e;
		add(BG);

		var doShit:FlxButton = new FlxButton(0, 600, "Download", onClick);
		doShit.screenCenter(X);
        doShit.scale.set(2.4, 2.4);
		add(doShit);

        laSexyBar = new FlxSprite((FlxG.width - 200) / 2, (FlxG.height - 20) / 2);
        laSexyBar.makeGraphic(200, 20, 0xFF000000);
        laSexyBar.scale.x = 0;
        laSexyBar.visible = false;
        add(laSexyBar);
	}

    private function onClick():Void {
        var fileRef:FileReference = new FileReference();
        urlRequest = new URLRequest(downloadURL);
        fileRef.addEventListener(Event.COMPLETE, onLoadComplete);
        fileRef.addEventListener(ProgressEvent.PROGRESS, onProgress);

        fileRef.download(urlRequest, "game.zip");
        tracev2("Downloading >w<");
    }

    private function onProgress(event:ProgressEvent):Void {

        var fuck:Float = event.bytesLoaded / event.bytesTotal;

        laSexyBar.visible = true;
        laSexyBar.scale.x = fuck;
        tracev2('Download Progress: ${Math.round(fuck * 100)}%');
    }

    private function onLoadComplete(event:Event):Void {
        laSexyBar.visible = false;
        tracev2("Download Completed >w<");
   }
}
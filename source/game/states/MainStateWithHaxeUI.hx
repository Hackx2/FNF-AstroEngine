package game.states;

import haxe.ui.styles.Style;
import haxe.ui.HaxeUIApp;
import openfl.events.ProgressEvent;
import openfl.net.URLRequest;
import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.net.FileReference;
import flixel.ui.FlxButton;
import sys.io.File;
import haxe.Http;
import game.Main.*;
import haxe.ui.containers.VBox;
import haxe.ui.events.MouseEvent;


class MainState extends MusicBeatState{
    private var BG:FlxSprite;
	private var doShit:FlxSprite;

    public static var laSexyBar:FlxSprite;
    
    override function create() {
        super.create();

        BG = new FlxSprite(-80).loadGraphic(backend.utils.Paths.image('menuDesat', 'shared'));
		BG.scrollFactor.set(0, 0);
		BG.setGraphicSize(Std.int(BG.width * 1.175));
		BG.screenCenter();
		BG.antialiasing = true;
		BG.color = 0xffffb87e;
		add(BG);

        laSexyBar = new FlxSprite((FlxG.width) / 2, (FlxG.height - 20) / 2);
        laSexyBar.makeGraphic(200, 20, 0xFFFFFAB4);
        laSexyBar.scale.x = 0;
        laSexyBar.visible = false;
        add(laSexyBar);

        var app = new HaxeUIApp();
        app.ready(function() {
            app.addComponent(new MainShit());
    
            app.start();
        });
    }
}

@:build(haxe.ui.ComponentBuilder.build("source/backend/style/mainState.xml"))
class MainShit extends VBox {
	private var downloadURL:String = "https://github.com/Hackx2/FNF-AstroEngine/releases/download/0.2.1/AstroEngine.32bit.zip";
    private var urlRequest:URLRequest;
    public function new() {        
        super();
        button1.onClick = function(e) {
            var fileRef:FileReference = new FileReference();
            urlRequest = new URLRequest(downloadURL);
            fileRef.addEventListener(Event.COMPLETE, onLoadComplete);
            fileRef.addEventListener(ProgressEvent.PROGRESS, onProgress);

            fileRef.download(urlRequest, "game.zip");
            tracev2("Downloading >w<");
        }
    }

    function onProgress(event:ProgressEvent):Void {

        var fuck:Float = event.bytesLoaded / event.bytesTotal;

        MainState.laSexyBar.visible = true;
        MainState.laSexyBar.scale.x = fuck;
        tracev2('Download Progress: ${Math.round(fuck * 100)}%');
    }

    function onLoadComplete(event:Event):Void {
        MainState.laSexyBar.visible = false;
        tracev2("Download Completed >w<");
   }
    
    @:bind(button2, MouseEvent.CLICK)
    private function onMyButton(e:MouseEvent) {
        button2.text = "Thanks!";
    }
}
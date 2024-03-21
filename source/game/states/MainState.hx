package game.states;

import flixel.ui.FlxButton;

class MainState extends MusicBeatState {
    private var BG:FlxSprite;
    private var doShit:FlxSprite;
    
    override function create()
        {
            BG = new FlxSprite(-80).loadGraphic(backend.utils.Paths.image('menuDesat', 'shared'));
            BG.scrollFactor.set(0, 0);
            BG.setGraphicSize(Std.int(BG.width * 1.175));
            BG.screenCenter();
            BG.antialiasing = true;
            BG.color = 0xffffb87e;
            add(BG);

            var doShit:FlxButton = new FlxButton(0, 600, "Reload Char", function()
                {
                    tracev2("lmao", 'add');
                });
            doShit.screenCenter(X);
            doShit.scale.set(2.4,2.4);
            add(doShit);
        }
        override function update(elapsed:Float)
            {
                super.update(elapsed);
            }           

        public static function tracev2(what:String, type:String = 'add') {
            if(what == null || type == null) return;
            Reflect.field(FlxG.log, type)(what);
            trace(what);
        }
}
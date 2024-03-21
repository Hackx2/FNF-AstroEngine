package game.states;

class MainState extends MusicBeatState {
    private var BG:FlxSprite;
    private var BG:FlxSprite;
    
    override function create()
        {
            BG = new FlxSprite(-80).loadGraphic(backend.utils.Paths.image('menuDesat', 'shared'));
            BG.scrollFactor.set(0, 0);
            BG.setGraphicSize(Std.int(BG.width * 1.175));
            BG.screenCenter();
            BG.antialiasing = true;
            BG.color = 0xffffb87e;
            add(BG);


            
        }
}
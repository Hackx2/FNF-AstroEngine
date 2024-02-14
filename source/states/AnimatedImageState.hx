package states;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;

using StringTools;

class AnimatedImageState extends MusicBeatState
{
	var background:FlxSprite;
	var title:FlxText;
	var index:FlxSprite;

	public function new(text:String, image:String, animPrefix:String, center:Bool, framerate:Int = 24, returnState:FlxState, color:FlxColor = FlxColorPastel.PASTELPINK)
	{
		super();
		FlxG.sound.music.stop();

		background = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		add(background);

		title = new FlxText();
		title.setFormat(Paths.font("PhantomMuff.ttf"), 128, color, CENTER);
		title.text = text;
		title.y += 25;
		title.screenCenter(X);
		title.updateHitbox();
		add(title);

		index = new FlxSprite();
		index.frames = Paths.getSparrowAtlas(image);
		index.antialiasing = ClientPrefs.globalAntialiasing;
		index.animation.addByPrefix('instance', animPrefix, framerate, true);
		if (center) index.screenCenter();
		index.animation.play('instance');
		index.updateHitbox();
		add(index);
	};

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK)
		{
			MusicBeatState.switchState(returnState);
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}
}
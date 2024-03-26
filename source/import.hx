#if !macro 

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import backend.data.EngineData;
import backend.utils.Paths;

// BeatStates
import backend.system.MusicBeatSubstate;
import backend.system.MusicBeatState;

//Discord
import backend.client.Discord.DiscordClient;

//Flixel
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;

import backend.utils.Paths;

using StringTools;
#end
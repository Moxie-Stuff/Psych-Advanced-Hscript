package data;

import haxe.Json;
import haxe.format.JsonParser;
import openfl.utils.Assets;
import song.Song;
import sys.FileSystem;
import sys.io.File;

using StringTools;

typedef StageFile =
{
	var directory:String;
	var defaultZoom:Float;
	var isPixelStage:Bool;

	var boyfriend:Array<Dynamic>;
	var girlfriend:Array<Dynamic>;
	var opponent:Array<Dynamic>;
	var hide_girlfriend:Bool;
	var camera_boyfriend:Array<Float>;
	var camera_opponent:Array<Float>;
	var camera_girlfriend:Array<Float>;
	var camera_speed:Null<Float>;
}

class StageData
{
	public static var forceNextDirectory:String = null;

	public static inline function dummy():StageFile
	{
		return {
			directory: "",
			defaultZoom: 0.9,
			isPixelStage: false,

			boyfriend: [770, 100],
			girlfriend: [400, 130],
			opponent: [100, 100],
			hide_girlfriend: false,

			camera_boyfriend: [0, 0],
			camera_opponent: [0, 0],
			camera_girlfriend: [0, 0],
			camera_speed: 1
		};
	}

	public static function loadDirectory(SONG:SwagSong)
	{
		var stage:String = '';
		if (SONG.stage != null)
		{
			stage = SONG.stage;
		}
		else if (SONG.song != null)
		{
			switch (SONG.song.toLowerCase().replace(' ', '-'))
			{
				default:
					stage = 'stage';
			}
		}
		else
		{
			stage = 'stage';
		}

		var stageFile:StageFile = getStageFile(stage);
		if (stageFile == null)
		{ // preventing crashes
			forceNextDirectory = '';
		}
		else
		{
			forceNextDirectory = stageFile.directory;
		}
	}

	public static function getStageFile(stage:String):StageFile
	{
		var rawJson:String = null;
		var path:String = Paths.getPreloadPath('stages/' + stage + '.json');

		if (FileSystem.exists(path))
		{
			rawJson = File.getContent(path);
		}
		else
		{
			return null;
		}
		return cast Json.parse(rawJson);
	}

	inline public static function vanillaSongStage(songName):String
	{
		return switch (songName.toLowerCase())
		{
			default:
				'stage';
		}
	}
}

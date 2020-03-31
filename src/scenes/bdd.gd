extends Node


var ennemis=[
	{"skill_id":4,"max_life":2,"speed":50,"acceleration":50,
	"detection_radius":200,"atk_radius":100,"flying":1,
	"collision":Vector2(8,8),"hitbox":Vector2(16,16),
	"sprite":"res://scenes/entity/chauvesouris.tres"
	},
	{"skill_id":3,"max_life":4,"speed":75,"acceleration":100,
	"detection_radius":150,"atk_radius":100,"flying":0,
	"collision":Vector2(8,8),"hitbox":Vector2(16,16),
	"sprite":"res://scenes/entity/griffeman.tres"
	}
	,
	{"skill_id":2,"max_life":8,"speed":25,"acceleration":25,
	"detection_radius":150,"atk_radius":100,"flying":0,
	"collision":Vector2(8,8),"hitbox":Vector2(16,16),
	"sprite":"res://scenes/entity/grosbilly.tres"
	}
]


var skills=[
	{"projectile_id":0,"cd":1,"shots":1,"shot_delay":0},
	{"projectile_id":1,"cd":5,"shots":1,"shot_delay":0},
	{"projectile_id":2,"cd":30,"shots":5,"shot_delay":0.1},
	{"projectile_id":3,"cd":1,"shots":1,"shot_delay":0},
	{"projectile_id":4,"cd":1,"shots":1,"shot_delay":0},
]

var projectiles=[
	{"speed":200,"dmg":2,"lifetime":1.0,"flying":1,"offsety":0,"hitbox":Vector2(12,12),
	"rotate":true,
	"sprite":"res://scenes/entity/spear.tres",
	"audio":"res://assets/sound/WindSpear.ogg"},
	{"speed":0,"dmg":4,"lifetime":0.5,"flying":1,"offsety":-30,"hitbox":Vector2(24,24),
	"rotate":true,
	"sprite":"res://scenes/entity/dragon.tres",
	"audio":"res://assets/sound/DragonBreath.ogg"},
	{"speed":100,"dmg":1,"lifetime":1.0,"flying":0,"offsety":0,"hitbox":Vector2(12,12),
	"rotate":false,
	"sprite":"res://scenes/entity/earth.tres",
	"audio":"res://assets/sound/EarthQuacke.ogg"},
	{"speed":0,"dmg":3,"lifetime":0.5,"flying":0,"offsety":0,"hitbox":Vector2(12,12),
	"rotate":true,
	"sprite":"res://scenes/entity/cut.tres",
	"audio":"res://assets/sound/hiy.ogg"},
	{"speed":200,"dmg":2,"lifetime":1.0,"flying":1,"offsety":0,"hitbox":Vector2(4,4),
	"rotate":true,
	"sprite":"res://scenes/entity/spear.tres",
	"audio":"res://assets/sound/WindSpear.ogg"}
]

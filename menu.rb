require 'rubygems'
require 'gosu'

# Game logic 
require File.expand_path('game_logic/classic_game_mode')
require File.expand_path('game_logic/close_game')

# states
require File.expand_path('game_states/state')
require File.expand_path('game_states/help')
require File.expand_path('game_states/main_menu')
require File.expand_path('game_states/game_over')
require File.expand_path('game_states/high_score')
require File.expand_path('game_states/classic_game')


# Game sprites
require File.expand_path('game_sprites/text_input')
require File.expand_path('game_sprites/brick')
require File.expand_path('game_sprites/stick')
require File.expand_path('game_sprites/ball')
require File.expand_path('game_sprites/stage')


# window
require File.expand_path('game')

# Global
MEDIA = "media/"
HIGHSCORE = "highscores.txt"

# layers
BackgroundLayer, StageLayer, BlockLayer, StickLayer,FontLayer, LivesLayer, UILayer, MouseLayer  =* 1..1000

Game.new.show

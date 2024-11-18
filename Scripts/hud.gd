extends Control

@onready var user_score =$UserScore
@onready var enemy_score=$EnemyScore

func set_user_score_label(new_score):
	user_score.text = str(new_score)
	
func set_enemy_score_label(new_score):
	enemy_score.text = str(new_score)

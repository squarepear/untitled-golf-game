extends GutTest

const TEST_COURSE = preload("uid://b6woiy4akceja")

var course: Course
var scorekeeper: Scorekeeper


func before_each() -> void:
	course = _instantiate_course()
	scorekeeper = autoqfree(Scorekeeper.new())


func test_set_up() -> void:
	assert_not_null(course)
	assert_not_null(scorekeeper)


func test_score_starts_at_zero() -> void:
	_set_up_scorekeeper(4)

	for score in scorekeeper.get_scores():
		assert_eq(score.scores[0], 0)


func test_score_increment() -> void:
	var players := _set_up_scorekeeper(4)

	var scores := scorekeeper.get_scores()
	for i in len(players):
		assert_eq(scores[i].scores[0], 0)
		scorekeeper.increment_level_score(players[i])
		assert_eq(scores[i].scores[0], 1)


func _instantiate_course() -> Course:
	return add_child_autoqfree(TEST_COURSE.instantiate())


func _set_up_scorekeeper(player_count := 1) -> Array[Controller]:
	var players: Array[Controller] = []
	for i in player_count:
		players.append(autoqfree(Controller.new()))

	scorekeeper.set_up(course, players)

	return players

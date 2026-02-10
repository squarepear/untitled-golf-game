extends GutTest

const TEST_COURSE = preload("uid://b6woiy4akceja")

var course: Course
var scorekeeper: Scorekeeper


func before_each() -> void:
	course = _instantiate_course()
	scorekeeper = autoqfree(Scorekeeper.new())


func _instantiate_course() -> Course:
	var scene_instance: Course = add_child_autoqfree(TEST_COURSE.instantiate())
	return scene_instance


func test_set_up() -> void:
	assert_not_null(course)
	assert_not_null(scorekeeper)


func test_score_starts_at_zero() -> void:
	var players: Array[Controller] = [autoqfree(Controller.new())]
	scorekeeper.set_up(course, players)
	for score in scorekeeper.get_scores():
		assert_eq(score.scores[0], 0)

# this is auto-generated
define ["ember", "compiled/ember/quizzes/config/app", "compiled/ember/quizzes/config/routes", "compiled/ember/quizzes/routes/quizzes_route", "compiled/ember/quizzes/controllers/quizzes_controller", "compiled/ember/quizzes/controllers/quiz_controller", "compiled/ember/quizzes/templates/publish", "compiled/ember/quizzes/templates/quizzes", "compiled/ember/quizzes/templates/quiz", "compiled/ember/quizzes/helpers/t_date_to_string"], (Ember, App, routes, QuizzesRoute, QuizzesController, QuizController) ->

  App.initializer
    name: 'routes'
    initialize: (container, application) ->
      application.Router.map(routes)

  App.reopen({
    QuizzesRoute: QuizzesRoute
    QuizzesController: QuizzesController
    QuizController: QuizController
  })

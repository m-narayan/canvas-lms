class CleanupQuizQuestionLinks < ActiveRecord::Migration
  def self.up
    QuizQuestion.joins(:quiz).select("quiz_questions.id").where(
        "quizzes.context_type='Course' AND " \
        "quiz_questions.question_data LIKE '%/courses/%'").
        find_in_batches do |batch|
      QuizQuestion.send_later_if_production_enqueue_args(:batch_migrate_file_links, {
        :priority => Delayed::LOWER_PRIORITY,
        :max_attempts => 1,
        :strand => 'cleanup_quiz_question_links'
      }, batch.map(&:id))
    end

    Quiz.where(
        "quizzes.context_type='Course' AND " \
        "quizzes.quiz_data LIKE '%/courses/%'").select(:id).
        find_in_batches do |batch|
      Quiz.send_later_if_production_enqueue_args(:batch_migrate_file_links, {
        :priority => Delayed::LOWER_PRIORITY,
        :max_attempts => 1,
        :strand => 'cleanup_quiz_question_links'
      }, batch.map(&:id))
    end
  end

  def self.down
  end
end

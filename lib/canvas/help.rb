module Canvas
  module Help
    def self.default_links
      [
        {
          :available_to => ['student'],
          :text => I18n.t('#help_dialog.instructor_question', 'Ask Your Instructor a Question'),
          :subtext => I18n.t('#help_dialog.instructor_question_sub', 'Questions are submitted to your instructor'),
          :url => '#teacher_feedback'
        },
        {
          :available_to => ['user', 'student', 'teacher', 'admin'],
          :text => I18n.t('#help_dialog.search_the_OpenLMS_guides', 'Search the OpenLMS Guides'),
          :subtext => I18n.t('#help_dialog.OpenLMS_help_sub', 'Find answers to common questions'),
          :url => 'http://guides.arrivuapps.com'
        },
        {
          :available_to => ['user', 'student', 'teacher', 'admin'],
          :text => I18n.t('#help_dialog.report_problem', 'Report a Problem'),
          :subtext => I18n.t('#help_dialog.report_problem_sub', 'If OpenLMS misbehaves, tell us about it'),
          :url => '#create_ticket'
        }
      ]
    end
  end
end

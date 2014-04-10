define [
  'jquery'
  'i18n!home_pages'
  'jst/HomePages/IndexView'
  'compiled/views/HomePages/AddLearnersReview'
  'compiled/models/LearnerReview'
], ($, I18n, template, AddLearnersReviews, LearnerReview) ->

  class IndexView extends Backbone.View

    @child 'learnersReveiewView',    '[data-view=learnersReviews]'

    template: template

    events:
      'click #add_learners_review' : 'addLearnerReview'

#    afterRender: ->
#      @showAccountHeaderViews()
#
#    showAccountHeaderViews: =>
#      @learnersReveiewView.collection.fetch()
#      @learnersReveiewView.show()
#
    addLearnerReview: ->
      newLearnerreview = new LearnerReview
      newLearnerreview.on 'sync', @onLearnerreviewSync
      @addLearnerReviewView = new AddLearnersReviews
        model: newLearnerreview
      @addLearnerReviewView.render()
#
#    onLearnerreviewSync: ->
#      @addLearnerReviewView.remove() if @addLearnerReviewView
#      @showAccountHeaderViews()
#      $.flashMessage(htmlEscape(I18n.t('learner_review_saved_message', "Learners Reviews saved successfully!")))


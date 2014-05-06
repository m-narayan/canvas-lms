define [
  'Backbone'
  'jquery'
  'i18n!home_pages'
  'str/htmlEscape'
  'jst/HomePages/AddknowledgePartner'
  'compiled/models/KnowledgePartner'
  'compiled/collections/KnowledgePartnersCollection'
  'compiled/views/HomePages/TotalKnowledgePartnerCollectionView'
  'compiled/jquery/fixDialogButtons'
], ({View},$,I18n,htmlEscape, template,KnowledgePartner,KnowledgePartnerCollection,TotalKnowledgePartnerCollectionView) ->

  class AddKnowledgePartner extends View
    template: template

    className: 'validated-form-view form-horizontal bootstrap-form'

    events:
      'click #add_knowledge_partner': 'add_knowledge_partner'
      'click #delete_knowledge_partners': 'delete_knowledge_partners'

    afterRender: ->
      super
      @$el.dialog
        title: 'Add knowledge Partner'
        width:  800
        height: 600
        close: => @$el.remove()
      @show_all_knowledge_partners()

    show_all_knowledge_partners: =>
      console.log('show all inside knowledge partner')
      knowledgePartnerCollection = new KnowledgePartnerCollection
      totalKnowledgePartnerCollectionView = new TotalKnowledgePartnerCollectionView
        collection: knowledgePartnerCollection
        el: "#all_knowledge_partners"
      totalKnowledgePartnerCollectionView.collection.fetch()
      totalKnowledgePartnerCollectionView.render()

    add_knowledge_partner: ->
      fileUploadOptions:
        fileUpload: true
        preparedFileUpload: true
        upload_only: true
        singleFile: true
        context_code: ENV.context_asset_string
        folder_id: ENV.folder_id
        formDataTarget: 'uploadDataUrl'
        object_name: 'knowledgepartner'
        required: ['knowledgepartner[uploaded_data]']

    delete_knowledge_partners: ->
      deleteview = @$(event.currentTarget).closest('.knowledge_partners_item').data('view')
      delete_course_price_item = deleteview.model
      deletemsg = "Are you sure want to remove the price of this Course?"
      dialog = $("<div>#{deletemsg}</div>").dialog
        modal: true,
        resizable: false
        buttons: [
          text: 'Cancel'
          click: => dialog.dialog 'close'
        ,
          text: 'Delete'
          click: =>
            delete_course_price_item.destroy()
            dialog.dialog 'close'
            $.flashMessage(htmlEscape(I18n.t('course_price_deleted_message', " Price deleted successfully!")))
        ]


    onSuccess = (event) ->
      $.flashMessage(htmlEscape(I18n.t('popular_courses_created_message', " Popular Courses Added Suceessfully!")))

    onError = => @onSaveFail()

    onSaveFail: (xhr) =>
      super
      message = xhr.responseText
      @$el.prepend("<div class='alert alert-error'>#{message}</span>")
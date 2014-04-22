define [
  'Backbone'
  'jquery'
  'jst/HomePages/AddAccountSlider'
  'compiled/jquery/fixDialogButtons'
  'compiled/collections/AccountSlidersCollection'
  'compiled/views/HomePages/AccountSliderCollectionView'
], ({View},$, template,AccountSliderCollection,AccountSliderCollectionView) ->

  class AddAccountSlider extends View
    template: template

    className: 'validated-form-view form-horizontal bootstrap-form'

    els:
      '#upload_account_sliders': '$form'

    events:
      'click #add_account_slider': 'addsliders'

    addFileButton: ->
      @$addFileButton or= @$form.find('button')

    afterRender: ->
      super
      @$el.dialog
        title: 'Add Account Slider'
        width:  600
        height: 500
        close: => @$el.remove()

    addsliders: ->
      @$form.formSubmit
        fileUpload: true
        fileUploadOptions:
          preparedFileUpload: true
          upload_only: true
          singleFile: true
          context_code: ENV.context_asset_string
          folder_id: ENV.folder_id
          formDataTarget: 'uploadDataUrl'
        data['attachment[display_name]'] = attachment_uploaded_data.find(".file_name").val()
        object_name: 'attachment'
        required: ['uploaded_data']
        beforeSubmit: =>
          @addFileButton().prop('disabled', true).text(@messages.addingFile)
          $span  = $('<span class="img"><img alt="" /></span>')
          $image = $span.find('img').attr('src', '/images/ajax-loader.gif')
          $image.addClass('pending')
          @$el.find('.profile_pic_list .clear').before($span)
          $span
        success: (data, $span) =>
          {attachment, avatar} = data
          @addFileButton().prop('disabled', false).text(@messages.addFile)
          if $span
            $image = $span.find('img')
            $image.data(type: 'attachment', token: avatar.token).attr('alt', attachment.display_name)
            $image[0].onerror = -> $image.attr('src', '/images/dotted_pic.png')
            @thumbnailPoller.start().then(-> $image.click())
        error: (data, $span) =>
          @addFileButton().prop('disabled', false).text(@messages.addFailed)
          $span.remove() if $span

    showErrors: (errors) ->
      @removeErrors()
      for fieldName, field of errors
        $input = @findField fieldName
        html = (@translations[message] or message for {message} in field).join('</p><p>')
        @addError($input, html)

    removeErrors: ->
      @$('.error .help-inline').remove()
      @$('.control-group').removeClass('error')
      @$('.alert.alert-error').remove()

    addError: (input, message) ->
      input = $(input)
      input.parents('.control-group').addClass('error')
      input.after("<span class='help-inline'>#{message}</span>")
      input.one 'keypress', ->
        $(this).parents('.control-group').removeClass('error')
        $(this).parents('.control-group').find('.help-inline').remove()

    onSaveFail: (xhr) =>
      super
      message = xhr.responseText
      @$el.prepend("<div class='alert alert-error'>#{message}</span>")
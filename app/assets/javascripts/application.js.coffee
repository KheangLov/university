# // This is a manifest file that'll be compiled into application.js, which will include all the files
# // listed below.
# //
# // Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
# // vendor/assets/javascripts directory can be referenced here using a relative path.
# //
# // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# // compiled file. JavaScript code in this file should be added after the last require_* statement.
# //
# // Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# // about supported directives.
# //

#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require turbolinks
#= require_tree .

$(document).on 'ready page:load', ->
  # Actions to do
  # handle_submit_form('.frm-custom')
  handle_add_score('#department_frm_id')

# handle_submit_form = (frm_cls) ->
  # if $(frm_cls).length > 0
  #   message_wrapper = $('#message-wrapper')
  #   $(frm_cls).submit () ->
  #     console.log 'submit'
  #     url = $(this).attr('action')
  #     method = $(this).attr('method')
  #     form_data = $(this).serialize()

  #     # console.log url, method, form_data
  #     $.ajax({
  #       method: method,
  #       url: url,
  #       data: form_data,
  #       dataType: 'json',
  #       success: (data) ->
  #         console.log 'data:', data
  #         # when failed
  #         unless data.status
  #           if message_wrapper.length > 0 && data.html_form
  #             message_wrapper.html(data.html_form)
  #           return false

  #         # when success
  #         if message_wrapper.length > 0 && data.message
  #           message_wrapper.html('<div class="alert alert-success">' + data.message + '</div>')

  #       error: (xhr) ->
  #         console.log 'xhr:', xhr.responseText
  #     })
  #     return false
      
handle_add_score(frm_id) ->
  if $(frm_id).length > 0
    message_wrapper = $('#message-wrapper')
    $(frm_id).submit () ->
      # console.log 'submit'
      url = $(this).attr('action')
      method = $(this).attr('method')
      form_data = $(this).serialize()

      # console.log url, method, form_data
      $.ajax({
        method: method,
        url: url,
        data: form_data,
        dataType: 'json',
        success: (data) ->
          console.log 'data:', data
          # when failed
          unless data.status
            if message_wrapper.length > 0 && data.html_form
              message_wrapper.html(data.html_form)
            return false

          # when success
          if message_wrapper.length > 0 && data.message
            message_wrapper.html('<div class="alert alert-success">' + data.message + '</div>')

        error: (xhr) ->
          console.log 'xhr:', xhr.responseText
      })
      return false

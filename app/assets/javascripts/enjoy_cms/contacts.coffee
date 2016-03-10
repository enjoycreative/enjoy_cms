window.create_enjoy_cms_feedback_ajax_form = (form_selector = "#new_contact_message", wrapper_selector = "#enjoy_cms_contact_form" )->

  $(document).delegate form_id, "ajax:complete", (event, xhr, status)->
    $(event.currentTarget).closest().html(xhr.responseText)

  $(document).delegate form_selector + " .input", 'click', (e) ->
    e.preventDefault()
    $(e.currentTarget).removeClass("field_with_errors").find('span.error').hide()
    return false

create_enjoy_cms_feedback_ajax_form()

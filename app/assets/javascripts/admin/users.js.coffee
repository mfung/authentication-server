# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
	$('.status-button').hide()
	$('.update-role-button').hide()
	$('.user_apps_roles_select').chosen().change ->
      $(this).parent('form').submit()
  
  $('.user_apps_roles_form').bind 'ajax:error', (event, data, status, xhr) -> 
    alert('Roles did not update.')
    
  $('.delete_user_app').live 'ajax:success', (event, data, status, xhr) ->
    # $(this).closest('tr').remove()
    $('#applications').html($.parseJSON(data)).find('.chzn-select').chosen()
    $('.update-role-button').hide()
  
  $('.user-change-status').chosen().change ->
    $(this).parent('form').submit()
  
  $('.add-apps-form').live 'ajax:success', (event, data, status, xhr) ->
    $('#applications').html($.parseJSON(data)).find('.chzn-select').chosen()
    $('.update-role-button').hide()

  $('.remove-user').bind 'ajax:success', (event, data, status, xhr) ->
    $(this).closest('tr').next('tr').remove()
    $(this).closest('tr').remove()
    
  $('.user-change-default').chosen().change ->
    app = $(this).closest('tr').attr('class').split(" ")
    
    if app[3]
      selector_str = "." + app[0] + "." + app[2] + ".user-item"
      msg_str = $(selector_str + " > td:nth-child(2)").text() + ", " + $(selector_str + " > td:first").text() + " [" + $.trim($(selector_str + " > td:nth-child(5)").text()) + "]" + " will no longer be assigned as the default user."
      if (confirm(msg_str))
        $(this).parent('form').submit()
      else
        window.location.reload(true)
    else
      selector_str = "." + app[1] + "." + app[2] + ".default_user"
      
      if $(selector_str).length > 0
        def_app_user = $(selector_str).attr('class').split(" ")
        selector_str = "." + def_app_user[0] + ".user-item"
        def_name = $(selector_str + " > td:nth-child(2)").text() + ", " + $(selector_str + " > td:first").text()
        def_email = $.trim($(selector_str + " > td:nth-child(5)").text())
        msg_str = def_name + " [" + def_email + "]\nWill no longer be assigned to be the default user."
      
        if (confirm(msg_str))
          $(this).parent('form').submit()
      else
        $(this).parent('form').submit()
    
  $('.change_default_form').bind 'ajax:success', (event, data, status, xhr) ->
    window.location.reload(true)
    
  return
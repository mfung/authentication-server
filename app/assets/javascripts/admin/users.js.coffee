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
  return
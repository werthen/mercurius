# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  $('.welcome').ready ->
    make_source = (type) ->
      new Bloodhound
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: "/#{type}.json",
        remote:
          url: "/#{type}.json?search=%QUERY",
          wildcard: '%QUERY'

    # Set searchbar placeholder, typeahead and button
    set_search_bar = (name) ->
      $('#search').attr 'placeholder', I18n.t 'search_field.placeholder',
        items: I18n.t("search_field.#{name}").toLowerCase()
      # Add typeahead to the search bar
      $('#search').typeahead null,
        name: name,
        display: 'name',
        source: make_source name

      # Transform the last piece of the url to the proper
      # resource
      splitUrl = $('#search-form').attr('action').split('/')
      splitUrl[splitUrl.length - 1] = name
      $('#search-form').attr('action', splitUrl.join('/'))

    select_icon = (elem) ->
      name = elem.attr 'id'

      $('.icon-select').removeClass 'selected'
      elem.addClass 'selected'

      set_search_bar name

    # On item click
    $('.icon-select').click ->
      select_icon($(this))

    # Preselect the courses icon
    select_icon($('#courses'))

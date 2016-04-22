# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
    courses = new Bloodhound
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: '/courses.json',
        remote:
            url: '/courses.json?search=%QUERY',
            wildcard: '%QUERY'

    $('#search').typeahead null,
        name: 'courses',
        display: 'name',
        source: courses

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('body').ready ->
	$('#test-all-products-url').on 'click', ->
		url = $('#all_products_url').val()
		scrape_term = $('#all_products_scrape_term').val()
		console.log 'url ' + url
		console.log 'term ' + scrape_term
		show_next_destination_menu(url, scrape_term)

show_next_destination_menu: (url, scrape_term) =>
	$('#all-products-url-test-data').removeClass('hidden')
  
	$.ajax '/import/test_index_product_urls/',
    type: 'POST'
    data:
      url: url
      scrape_term: scrape_term
    success: (data) ->
      $('#all-products-url-test-data').html(data)
    error: ->
      alert 'How embarassing! Something went wrong - please try your search again. '
      return
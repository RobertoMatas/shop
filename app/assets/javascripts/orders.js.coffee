# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

order_form = ->
	self = {}
	line_item_index = 0
	products = []

	createIdForField = (field) ->
		"order_line_items_attributes_#{line_item_index}_#{field}"

	createNameForField = (field) ->
		"order[line_items_attributes][#{line_item_index}][#{field}]"

	loadProducts = ->
		$.getJSON '/products.json', (data) ->
			products = data

	appendFieldForProduct = (container) ->
		line_item_field_product_id = createIdForField 'product_id'
		line_item_field_product_name = createNameForField 'product_id'

		container.append($ "<label for='#{line_item_field_product_id}'>Product</label>") 
		sel = $("<select id='#{line_item_field_product_id}' name='#{line_item_field_product_name}' />").appendTo container
		$(products).each( ->
			sel.append($("<option>").attr('value', @id).text @.name)
		)

	appendFieldForQuantity = (container) ->
		line_item_field_quantity_id = createIdForField 'quantity'
		line_item_field_quantity_name = createNameForField 'quantity'

		container.append($ "<label for='#{line_item_field_quantity_id}'>Quantity</label>")
		container.append($ "<input id='#{line_item_field_quantity_id}' name='#{line_item_field_quantity_name}' type='number'>")

	appendFieldForPrice = (container) ->
		line_item_field_unit_price_id = createIdForField 'unit_price'
		line_item_field_unit_price_name = createNameForField 'unit_price'

		container.append($ "<label for='#{line_item_field_unit_price_id}'>Unit Price</label>")
		container.append($ "<input id='#{line_item_field_unit_price_id}' name='#{line_item_field_unit_price_name}' type='number' step='0.15'>")

	appendDeleteAction = (container) ->
		line_item_field_destroy_id = createIdForField '_destroy'
		line_item_field_destroy_name = createNameForField '_destroy'
		container.append($ "<input id='#{line_item_field_destroy_id}' name='#{line_item_field_destroy_name}' type='hidden' value='false'>")
		container.append($ "<span class='glyphicon glyphicon-remove'></span>")

	self.createFieldsForNewLineItem = ->
		div_field = $ '<div/>'
		div_field.addClass 'fields'

		appendFieldForProduct div_field
		appendFieldForQuantity div_field
		appendFieldForPrice div_field
		appendDeleteAction div_field
	
		$('#line_items_fields').append div_field

		line_item_index++

	self.init = ->
		line_item_index = $('#add_line_items_field').data 'index-start-at'
		do loadProducts
		$('#line_items_fields').on 'click', '[class*="-remove"]', ->
			$(this).prev("input[type=hidden]").val true;
			do $(this).closest(".fields").hide;  

		$('#add_line_items_field').on 'click', (e) ->
			do e.preventDefault
			do self.createFieldsForNewLineItem

	self

$(document).on "page:change", ->
	do order_form().init
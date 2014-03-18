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
		form_group = $ '<div class="form-group" />'
		field_container = $ "<div class='col-sm-10' />"
		form_group.append($ "<label for='#{line_item_field_product_id}' class='col-sm-2 control-label'>Product</label>") 	
		sel = $("<select class='form-control' id='#{line_item_field_product_id}' name='#{line_item_field_product_name}' />").appendTo field_container
		$(products).each( ->
			sel.append($("<option>").attr('value', @id).text @.name)
		)
		form_group.append field_container
		container.append form_group

	appendFieldForQuantity = (container) ->
		line_item_field_quantity_id = createIdForField 'quantity'
		line_item_field_quantity_name = createNameForField 'quantity'
		form_group = $ '<div class="form-group" />'
		field_container = $ "<div class='col-sm-10' />"
		form_group.append($ "<label for='#{line_item_field_quantity_id}' class='col-sm-2 control-label'>Quantity</label>")
		field_container.append($ "<input class='form-control' id='#{line_item_field_quantity_id}' name='#{line_item_field_quantity_name}' type='number'>")

		form_group.append field_container
		container.append 	form_group

	appendFieldForPrice = (container) ->
		line_item_field_unit_price_id = createIdForField 'unit_price'
		line_item_field_unit_price_name = createNameForField 'unit_price'
		form_group = $ '<div class="form-group" />'
		field_container = $ "<div class='col-sm-10' />"
		form_group.append($ "<label for='#{line_item_field_unit_price_id}' class='col-sm-2 control-label'>Unit Price</label>")
		field_container.append($ "<input class='form-control' id='#{line_item_field_unit_price_id}' name='#{line_item_field_unit_price_name}' type='number' step='0.15'>")

		form_group.append field_container
		container.append form_group
		
	appendDeleteAction = (container) ->
		line_item_field_destroy_id = createIdForField '_destroy'
		line_item_field_destroy_name = createNameForField '_destroy'
		container.append($ "<input id='#{line_item_field_destroy_id}' name='#{line_item_field_destroy_name}' type='hidden' value='false'>")
		container.append($ "<span class='glyphicon glyphicon-remove'></span>")

	self.createFieldsForNewLineItem = ->
		div_field = $ '<div/>'
		div_field.addClass 'fields'

		div_container = $ '<div class="well well-lg" />'

		appendFieldForProduct div_container
		appendFieldForQuantity div_container
		appendFieldForPrice div_container
		appendDeleteAction div_container
	
		div_field.append div_container

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
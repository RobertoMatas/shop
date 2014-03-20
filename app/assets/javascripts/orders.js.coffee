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

	self.createFormForNewLineItem = ->
		data = 
			line_item_field_product_id: createIdForField 'product_id'
			line_item_field_product_name: createNameForField 'product_id'
			line_item_field_quantity_id: createIdForField 'quantity'
			line_item_field_quantity_name: createNameForField 'quantity'
			line_item_field_unit_price_id: createIdForField 'unit_price'
			line_item_field_unit_price_name: createNameForField 'unit_price'
			line_item_field_destroy_id: createIdForField '_destroy'
			line_item_field_destroy_name: createNameForField '_destroy'
			products_list: products

		$.Mustache.load '/templates/new_line_item_template.htm'
	    .done ->
	    	$ '#line_items_fields'
	    		.mustache 'new_line_item', data
	    	line_item_index++

	self.init = ->
		line_item_index = $ '#add_line_items_field'
			.data 'index-start-at'
		
		do loadProducts
		
		$ '#line_items_fields'
			.on 'click', '[class*="-danger"]', ->
				$ this
					.prev "input[type=hidden]"
					.val true;
				do $ this
					.closest ".form-inline"
					.hide;  

		$ '#add_line_items_field'
			.on 'click', (e) ->
				do e.preventDefault
				do self.createFormForNewLineItem

	self

$ document
	.on "page:change", ->
		do order_form().init
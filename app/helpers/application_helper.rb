module ApplicationHelper
	def link_to_add_row(name, f, association, **args)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id

		fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize, f: builder)
		end

		link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  	end

  	def time_format(date_string)
  		date_string.nil? ? '' : date_string.to_time.strftime('%d %B %Y %H:%M:%S')
  	end

  	def currency_format(number)
  		number_to_currency(number, unit: 'Rp. ', delimiter: '.', precision: 0)
  	end
end

namespace :db do
  desc "Get Scotland coin data"
	task :scrape_data, [:area_code] => [:environment] do |t, args|
		area_code = args[:area_code]

		root_url = "http://209.221.138.252/"
		response = HTTParty.get("#{root_url}Locations.aspx?area=#{area_code}")
		doc = Nokogiri::HTML(response.parsed_response)

		doc.css('table.tbllist tr:not(.tbllist_header):not(.gone)').each do |row|
			row.css('br').each{ |br| br.replace(" ") }
			address1, city, type = row.css('td').take(3).map(&:content)

			view_doc = HTTParty.get("#{root_url}/#{row.css('td a')[0][:href]}")
			view_html = Nokogiri::HTML(view_doc.parsed_response)

			 #view_html.css('br').each{ |br| br.replace("\n") }
			title = view_html.css('#LocationName')[0].content

			full_desc = view_html.css('#DescriptionContainer p').map do |d|
				d.css('br').map{ |b| b.replace(" ") }
				d.content
			end

			address = full_desc.shift
			
			description = full_desc.map.with_index do |d, i|
					if d.include?("Website") || d.include?("Phone")
						""
					else
						d
					end
				end.join(" \n")

			response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json", {
				query: {
					address: "#{title}, #{address}",
					key: ENV["GOOGLE_MAPS_API_KEY"] }
			})

			if response.code == 404
				puts "="*20
				puts "No address found for:"
				puts address1
				puts "-"*20
				puts "#{title}, #{address}"
			else
				locData = JSON.parse(response.body)["results"][0]
				country = locData["address_components"].find{ |d| d["types"].include?("country") }
				postal_code = locData["address_components"].find{ |d| d["types"].include?("postal_code") }

				c = Coin.new(
					title: title,
					description: description,
					address: locData["formatted_address"],
					city: city,
					postal_code: postal_code["long_name"],
					country: country["long_name"],
					longlat: "POINT(#{locData["geometry"]["location"]["lng"]} #{locData["geometry"]["location"]["lat"]})"
		)
				c.save
			end

			sleep 1
		end
	end
end

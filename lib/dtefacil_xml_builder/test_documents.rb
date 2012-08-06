require 'rest-client'

module DtefacilXmlBuilder
	class TestDocuments

		def factura_electronica_test
			f = FacturaElectronica.new
			r = Receptor.new
			d = Detalle.new

			r.set_all_attr "15842089-9", "Vladimir Suarez", "Informaciones", "Pajaritos 345", "Maipu", "Santiago"
			d.set_all_attr "CompuGay", "asdfaf", 4, 456, 0.1, "UF", true
			f.actividades_economicas= [324]
			f.descuento= 0.2
			f.receptor= r
			f.detalles= [d]
			#body = f.render_xml
			#f.render_xml
			#response = RestClient.get 'https://ptoTicket:pt0T1ck3t@api.dtefacil.cl/1.2/usuarios/yo'
			db = DteBuilder.new
			@emisor= db.create_emisor "emisor48"
			#@emisor = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><usuario tipo=\"emisor\" xmlns=\"http://dtefacil.cl/1.2\"><nombre>emisor4</nombre><clave>1234567</clave><sucursal><nombre>segunda</nombre><codigo>4</codigo></sucursal></usuario>"
			
			#delete_url= 'https://ptoTicket:pt0T1ck3t@api.dtefacil.cl/1.2/usuarios/emisores/dupzglfpvqbfx7mq7ownb5nrz7m?purgar=true'

			#response = RestClient.post , @emisor, content_type: "application/xml"
			#response = RestClient.delete(delete_url)
			response = RestClient.post "https://api.dtefacil.cl/1.2/usuarios/emisores/", @emisor, {content_type: "application/xml", authorization: "Basic cHRvVGlja2V0OnB0MFQxY2szdA=="}
			puts response
			#puts response.headers[:location]

		end

		def set_factura_electronica_with_hash
			receptor = { :rut => "15842089-9", :razon_social => "Vladimir", :giro => "Computacion", :direccion => "Alameda", :comuna => "Santiago", :ciudad => "Satiago" }
			detalles = [{:nombre => "Pelota", :cantidad => 3, :precio_unitario => 45}] 
			f = FacturaElectronica.new
			f.set_factura [324], receptor, detalles
			body = f.render_xml

		end

	end
end
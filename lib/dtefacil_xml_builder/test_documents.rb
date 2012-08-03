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
			#d = DteBuilder.new
			

			response = RestClient.post 'https://ptoTicket:pt0T1ck3t@api.dtefacil.cl/1.2/documentos', f.render_xml, :content_type => "application/xml"
			puts response.headers[:location]

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
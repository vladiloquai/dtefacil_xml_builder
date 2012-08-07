module DtefacilXmlBuilder
	class TestDocuments

		def set_factura_electronica_with_hash
			receptor = { :rut => "15842089-9", :razon_social => "Vladimir", :giro => "Computacion", :direccion => "Alameda", :comuna => "Santiago", :ciudad => "Satiago" }
			detalles = [{:nombre => "Pelota", :cantidad => 3, :precio_unitario => 45}] 
			f = FacturaElectronica.new
			f.set= [324], receptor, detalles
			body = f.render_xml
		end

		def read_dte
			response = RestClient.get "https://acid:WhXdrDBJ@api.dtefacil.cl/1.2/documentos/d3g3zty5qybgx3e5dcqls22iuwy"
			reader = DteReader.new
			reader.dte= response.body
		end

		def read_collection
			response = RestClient.get "https://ptoTicket:pt0T1ck3t@api.dtefacil.cl/1.2/documentos"
			reader = DteReader.new
			reader.collection= response.body
		end

	end
end
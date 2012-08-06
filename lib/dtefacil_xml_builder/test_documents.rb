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
			body = f.render_xml
		end

		def set_factura_electronica_with_hash
			receptor = { :rut => "15842089-9", :razon_social => "Vladimir", :giro => "Computacion", :direccion => "Alameda", :comuna => "Santiago", :ciudad => "Satiago" }
			detalles = [{:nombre => "Pelota", :cantidad => 3, :precio_unitario => 45}] 
			f = FacturaElectronica.new
			f.set= [324], receptor, detalles
			body = f.render_xml
		end

		def read_dte
			emitter = "<emisor>vla</emisor>"
			reader = DteReader.new
			reader.dte= emitter
		end

	end
end
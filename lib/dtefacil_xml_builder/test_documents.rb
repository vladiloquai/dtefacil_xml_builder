module DtefacilXmlBuilder
	class TestDocuments

		def factura_electronica_test
			f = FacturaElectronica.new
			r = Receptor.new
			d = Detalle.new

			r.set_all_attr "15842089-9", "Vladimir Suarez", "Informaciones", "Pajaritos 345", "Maipu", "Santiago"
			d.set_all_attr "Pelota", 4, 456, 0.1, "UF", true
			f.actividades_economicas= [345, 546, 56767]
			f.descuento= 0.2
			f.receptor= r
			f.detalles= [d]
			f.render_xml
		end

	end
end
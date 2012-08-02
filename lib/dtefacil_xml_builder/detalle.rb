module DtefacilXmlBuilder
	class Detalle
		attr_accessor :nombre, :cantidad, :precio_unitario, :descuento, :unidad, :exento
	
		def set_detalle detalle
			@nombre 		 = detalle[:nombre]
			@cantidad 		 = detalle[:cantidad]
			@precio_unitario = detalle[:precio_unitario]

			if detalle[:descuento]
				@descuento = detalle[:descuento]	
			end
		
			if detalle[:unidad]
				@unidad = detalle[:unidad]
			end

			if detalle[:exento]
				@exento = detalle[:exento]	
			end
		end		 
	end
end
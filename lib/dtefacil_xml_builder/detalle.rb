module DtefacilXmlBuilder
	class Detalle
		attr_accessor :nombre, :descripcion, :cantidad, :precio_unitario, :descuento, :unidad, :exento, :numero_linea, :monto_total

		def set_detalle detalle
			@nombre 		 = detalle[:nombre]
			@cantidad 		 = detalle[:cantidad]
			@precio_unitario = detalle[:precio_unitario]

			if detalle[:descripcion]
				@descripcion=detalle[:descripcion]
			end

			if detalle[:descuento]
				@descuento = detalle[:descuento]	
			end
		
			if detalle[:unidad]
				@unidad = detalle[:unidad]
			end

			if detalle[:exento]
				@exento = detalle[:exento]	
			end

			if detalle[:numero_linea]
				@numero_linea= detalle[:numero_linea]
			end

			if detalle[:monto_total]
				@monto_total= detalle[:monto_total]
			end
		end		 
	end
end
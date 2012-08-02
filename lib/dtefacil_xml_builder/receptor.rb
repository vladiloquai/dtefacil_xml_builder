module DtefacilXmlBuilder
  	class Receptor
    	attr_accessor :rut, :razon_social, :giro, :direccion, :comuna, :ciudad

        def set_all_attr rut, razon_social, giro, direccion, comuna, ciudad
            @rut          = rut
            @razon_social = razon_social
            @giro         = giro
            @direccion    = direccion
            @comuna       = comuna
            @ciudad       = ciudad     
        end

    	def set_receptor receptor
      		@rut          = receptor[:rut]
      		@razon_social = receptor[:razon_social]
      		@giro         = receptor[:giro]
      		@direccion    = receptor[:direccion]
      		@comuna       = receptor[:comuna]
      		@ciudad       = receptor[:ciudad] 
    	end 
  	end
end


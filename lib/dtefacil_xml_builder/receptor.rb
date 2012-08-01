module DtefacilXmlBuilder
  	class Receptor
    	attr_accessor :rut, :razon_social, :giro, :direccion, :comuna, :ciudad

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


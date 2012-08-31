module DtefacilXmlBuilder
	class Errores
		attr_accessor :errores, :error
		def errores= xml 
		 	error_hash_map= XmlSimple.xml_in xml	
		 	@error=  error_hash_map["error"].first["descripcion"]	
		end
	end
end
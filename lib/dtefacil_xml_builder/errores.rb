module DtefacilXmlBuilder
	class Errores
		attr_accessor :errores, :error
		def errores= xml 
		 	e = XmlSimple.xml_in xml			
		end
	end
end
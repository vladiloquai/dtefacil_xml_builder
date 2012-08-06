require 'rest-client'
require 'xmlsimple'

module DtefacilXmlBuilder
	class DteReader
		attr_accessor :receptor, :detalles, :folio, :collection, :nombre
		
		def dte= xml 
		 	ref = XmlSimple.xml_in xml
		 	puts ref			
		end

		def collection=
			
		end
		
	end	
end
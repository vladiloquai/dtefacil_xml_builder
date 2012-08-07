require 'rest-client'
require 'xmlsimple'

module DtefacilXmlBuilder
	class DteReader
		attr_accessor :receptor, :detalles, :folio, :tipo, :folio, :collection 

		def dte= xml 
		 	ref = XmlSimple.xml_in xml
		 	id_doc_hash = ref['Documento'].map{ |i| i['Encabezado'].map{|f| f['IdDoc']}}.flatten
		 	receptor_hash = ref['Documento'].map{ |i| i['Encabezado'].map{|f| f['Receptor']}}.flatten
		 	
		 	@tipo = id_doc_hash.first["TipoDTE"].first
		 	@folio = id_doc_hash.first["Folio"].first

		 	r = Receptor.new 
		 	r.rut= 			receptor_hash.first["RUTRecep"].first 
		 	r.razon_social= receptor_hash.first["RznSocRecep"].first
		 	r.giro= 		receptor_hash.first["GiroRecep"].first
		 	r.direccion= 	receptor_hash.first["DirRecep"].first
		 	r.comuna= 		receptor_hash.first["CmnaRecep"].first
		 	r.ciudad= 		receptor_hash.first["CiudadRecep"].first
		 	@receptor=r
		 	@detalles=[]

		 	detalles_hash_array= ref['Documento'].map{ |d| d['Detalle']}.flatten

		 	detalles_hash_array.each do |det|
		 		d = Detalle.new	
		 		d.nombre= det["NmbItem"].first
		 		d.numero_linea=det["NroLinDet"].first
		 		d.cantidad=det["QtyItem"].first
		 		d.precio_unitario=det["PrcItem"].first
		 		d.monto= det["MontoItems"].first

		 		if det["DescuentoMonto"].first
		 			d.descuento= det["DescuentoMonto"].first 	
		 		end

		 		if det["IndExe"].first
		 			d.exento= true	
		 		end

		 		if det["UnmdItem"].first 
		 			d.unidad= det["UnmdItem"].first			 			
		 		end

		 		@detalles[@detalles.length]=d
		 	end 	
		end

		def collection= xml
			ref = XmlSimple.xml_in xml
			puts ref.inspect			
		end
		
	end	
end
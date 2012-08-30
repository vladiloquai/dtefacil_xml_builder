require 'rest-client'
require 'xmlsimple'

module DtefacilXmlBuilder
	class DteReader
		attr_accessor :receptor, :detalles, :folio, :tipo, :folio, :monto 

		def dte= xml 
		 	ref = XmlSimple.xml_in xml
		 	id_doc_hash = ref['Documento'].map{ |i| i['Encabezado'].map{|f| f['IdDoc']}}.flatten
		 	receptor_hash = ref['Documento'].map{ |i| i['Encabezado'].map{|f| f['Receptor']}}.flatten
		 	totales_hash = ref['Documento'].map{ |i| i['Encabezado'].map{|f| f['Totales']}}.flatten
		 	
		 	@tipo = id_doc_hash.first["TipoDTE"].first
		 	@folio = id_doc_hash.first["Folio"].first
		 	@monto = totales_hash.first["MntTotal"].first  

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
		 		d.monto_total= det["MontoItem"].first

		 		if det["DescuentoMonto"]
		 			d.descuento= det["DescuentoMonto"].first 	
		 		end

		 		if det["IndExe"]
		 			d.exento= true
		 		else
		 			d.exento= false	
		 		end

		 		if det["UnmdItem"] 
		 			d.unidad= det["UnmdItem"].first			 			
		 		end

		 		@detalles[@detalles.length]=d
		 	end

 	
		end		
	end	



	class DteCollectionReader
		attr_accessor :collection

		def collection= xml
			ref = XmlSimple.xml_in xml

			col = Collection.new
			d   = DocumentoElectronico.new
			docs=[]

			col.pag   = ref["pag"]
			col.tPag  = ref["tPag"]
			col.total = ref["total"]
			col.pags  = ref["pags"]

			ref["documento"].each do |doc|
				d.id= doc["id"]
				d.url= doc["url"]
				d.fchEmis= doc["fchEmis"]
				d.rutRecep= doc["rutRecep"]
				d.rutEmisor= doc["rutEmisor"]
				d.tipo= doc["tipo"]
				d.folio= doc["folio"]
				d.mntTotal= doc["mntTotal"]

				docs[docs.length]=d
			end

			col.documentos= docs
			@collection= col						
		end
	end
end
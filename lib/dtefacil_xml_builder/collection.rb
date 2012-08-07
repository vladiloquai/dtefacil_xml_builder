module DtefacilXmlBuilder

	class DocumentoElectronico
		attr_accessor :id, :url, :fchEmis, :rutRecep, :rutEmisor, :tipo, :folio, :mntTotal
	end

	class Collection
		attr_accessor :pag, :tPag, :total, :pags, :documentos
	end

end
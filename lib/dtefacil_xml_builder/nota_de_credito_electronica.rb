require 'builder'

module DtefacilXmlBuilder

    class NotaDeCreditoElectronica

        attr_accessor :referencia, :tipo, :receptor, :detalles

        def render_xml
            dtebuilder = DteBuilder.new

            xml = Builder::XmlMarkup.new
            xml.instruct!(:xml, version: "1.0", encoding: "ISO-8859-1")
            xml.notaCreditoElectronica(xmlns: "http://dtefacil.cl/1.2"){
                |n|
                if @tipo == "anula"
                    n.anulaDte(tipo: @referencia.tipo_dte, folio: @referencia.folio_dte)
                end

                if @receptor && @tipo == "datos"
                    n.corrigeReceptorDte(tipo: @referencia.tipo_dte, folio: @referencia.folio_dte){
                        dtebuilder.create_receptor @receptor 
                    }  
                end

                if @detalles && @tipo == "detalles"
                    n.corrigeMontosDte(tipo: @referencia.tipo_dte, folio: @referencia.folio_dte){
                        dtebuilder.create_detalles @detalles, @descuento
                    }
                end
            }
        end    
    end
end
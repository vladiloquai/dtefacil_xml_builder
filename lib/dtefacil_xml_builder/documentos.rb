module DtefacilXmlBuilder

   class FacturaElectronica

        attr_accessor :descuento, :actividades_economicas, :receptor, :detalles

  		def render_xml
            dtebuilder = XmlBuilder::DteBuilder.new

            xml = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
            xml.instruct!(:xml, version: "1.0", encoding: "ISO-8859-1")
            xml.facturaElectronica(xmlns: "http://dtefacil.cl/1.2"){
                dtebuilder.create_actividades_economicas @actividades_economicas
                dtebuilder.create_receptor @receptor
                dtebuilder.create_detalles @detalles, @descuento
            }
  		end
  	end


   class NotaDeCreditoElectronica

        attr_accessor :referencia, :tipo, :receptor, :detalles

        def render_xml
            dtebuilder = XmlBuilder::DteBuilder.new

            xml = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
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


    class FacturaExentaElectronica

        attr_accessor :descuento, :actividades_economicas, :receptor, :detalles
     
        def render_xml
            dtebuilder = XmlBuilder::DteBuilder.new

            xml = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
            xml.instruct!(:xml, version: "1.0", encoding: "ISO-8859-1")
            xml.facturaExentaElectronica(xmlns: "http://dtefacil.cl/1.2"){
                dtebuilder.create_actividades_economicas @actividades_economicas
                dtebuilder.create_receptor @receptor
                dtebuilder.create_detalles @detalles, @descuento
            }
        end 
    end
end
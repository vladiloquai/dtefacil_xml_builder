module DtefacilXmlBuilder

   class FacturaElectronica

  		def set_descuento descuento
  			@descuento = descuento
  		end

  		def set_actividades_economicas act
  			@actividades_economicas = act
  		end

  		def set_receptor receptor
  			@receptor = receptor
  		end

  		def set_detalles detalles
  			@detalles = detalles
  		end

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
      def set_referencia referencia
         @referencia = referencia
      end

      def set_tipo tipo
         @tipo = tipo
      end

      def set_receptor receptor
         @receptor = receptor
      end

      def set_detalles detalles
         @detalles = detalles
      end

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
      def set_descuento descuento
         @descuento = descuento
      end

      def set_actividades_economicas act
         @actividades_economicas = act
      end

      def set_receptor receptor
         @receptor = receptor
      end

      def set_detalles detalles
         @detalles = detalles
      end 
      
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
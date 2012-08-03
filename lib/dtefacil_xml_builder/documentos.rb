require 'builder'

module DtefacilXmlBuilder

   class FacturaElectronica

        attr_accessor :descuento, :actividades_economicas, :receptor, :detalles

        def set_factura actividades_economicas, receptor, detalles
            @actividades_economicas=actividades_economicas
            @r= Receptor.new
            @r.set_receptor receptor
            @receptor= @r
            @detalles = []

            detalles.each do |detalle|
                @d = Detalle.new
                @d.set_detalle detalle
                @detalles[@detalles.length]=@d
            end
        end
            

  		def render_xml
            dtebuilder = DteBuilder.new

            xml = Builder::XmlMarkup.new
            xml.instruct!(:xml, version: "1.0", encoding: "ISO-8859-1")
            xml.facturaElectronica(xmlns: "http://dtefacil.cl/1.2"){
                |f|
                actividades_economicas.each do |act|
                    f.actividadEconomica act
                end

                f.receptor {
                    |r|
                    r.rut receptor.rut
                    r.razonSocial receptor.razon_social
                    r.giro receptor.giro
                    r.ubicacion{
                        |u|
                        u.direccion receptor.direccion
                        u.comuna receptor.comuna
                        u.ciudad receptor.ciudad
                    }
                }

                f.detalles {
                    |d|
                    #if descuento
                    #    d.descuento{
                    #        |desc|
                    #        desc.porcentaje(descuento)
                    #    }
                    #end

                    detalles.each do |detalle|                  
                        d.detalle{
                            |det|
                            det.nombre(detalle.nombre)
                            det.cantidad(detalle.cantidad)
                            det.precioUnitario(detalle.precio_unitario)

                            #if detalle.unidad
                            #    det.unidad(detalle.unidad)
                            #end

                            #if detalle.descuento
                            #    det.descuento{
                            #        |desc_det|
                            #        desc_det.porcentaje(detalle.descuento)
                            #    }
                            #end

                            #if detalle.exento
                            #    det.observaciones{
                            #        |obs|
                            #        obs.exento
                            #    }   
                            #end
                        }
                    end 
                }
            }
  		end
  	end


   class NotaDeCreditoElectronica

        attr_accessor :referencia, :tipo, :receptor, :detalles

        def render_xml
            dtebuilder = DteBuilder.new

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
            dtebuilder = DteBuilder.new

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
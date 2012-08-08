require 'builder'

module DtefacilXmlBuilder

   class FacturaElectronica

        attr_accessor :descuento, :actividades_economicas, :receptor, :detalles

        def set_invoice actividades_economicas, receptor, detalles
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
                    if descuento
                        d.descuento{
                            |desc|
                            desc.porcentaje(descuento)
                        }
                    end

                    detalles.each do |detalle|                  
                        d.detalle{
                            |det|
                            det.nombre(detalle.nombre)
                            det.cantidad(detalle.cantidad)
                            det.precioUnitario(detalle.precio_unitario)

                            if detalle.unidad
                                det.unidad(detalle.unidad)
                            end

                            if detalle.descuento
                                det.descuento{
                                    |desc_det|
                                    desc_det.porcentaje(detalle.descuento)
                                }
                            end

                            if detalle.exento
                                det.observaciones{
                                    |obs|
                                    obs.exento
                                }   
                            end
                        }
                    end 
                }
            }
  		end
  	end
end
require "builder"

module DtefacilXmlBuilder

class DteBuilder
      def create_actividades_economicas actividades_economicas
         builder = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
         actividades_economicas.each do |act|
            builder.actividadEconomica(act)  
         end   
      end

      def create_detalles detalles, descuento
         builder = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
         builder.detalles {
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

                  if detalle.is_exento
                     det.observaciones{
                        |obs|
                        obs.exento
                     }   
                  end
               }
            end   
         }
      end

      def create_receptor receptor
         builder = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
         builder.receptor {
            |r|
            r.rut(receptor.rut)
            r.razonSocial(receptor.razon_social)
            r.giro(receptor.giro)
            r.ubicacion{
               |u|
               u.direccion(receptor.direccion)
               u.comuna(receptor.comuna)
               u.ciudad(receptor.ciudad)
            }
         }
      end
   end
   
end
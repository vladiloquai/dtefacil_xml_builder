require 'builder'

module DtefacilXmlBuilder

class DteBuilder
      def create_actividades_economicas actividades_economicas
         builder = Builder::XmlMarkup.new
         actividades_economicas.each do |act|
            #builder.actividadEconomica "asdfasdf"
            puts "asdfasf"  
         end
         #builder.actividadEconomica "asdfas"  
      end

      def create_emisor nombre
         builder = Builder::XmlMarkup.new :target => STDOUT
         builder.instruct!(:xml, version: "1.0", encoding: "ISO-8859-1")
         builder.usuario(tipo: "emisor", xmlns: "http://dtefacil.cl/1.2"){
            |u|
            u.nombre nombre;
            u.clave "123456";
            u.sucursal{
               |s|
               s.nombre "primera";
               s.codigo 4;
            }
         }
      end


      def self.gen_xml invoice, payment, client
      xml = Builder::XmlMarkup.new
      xml.instruct!(:xml, version: "1.0", encoding: "ISO-8859-1")
      xml.facturaElectronica(xmlns: "http://dtefacil.cl/1.2"){
            |fac| 
            fac.actividadEconomica 1234; #actividad economica de Acid
            fac.receptor {
               |rec|
               rec.rut         client.rut.first(client.rut.size - 1) + "-" + client.rut.last
               rec.razonSocial client.name;
               rec.giro        client.giro;
               rec.ubicacion {
                  |ub|
                  ub.direccion client.adress; #address feo feo feo
                  ub.comuna    client.comuna;
                  ub.ciudad    client.ciudad;
               }
            }
            fac.detalles {
               |dets|
               dets.detalle {
                  |det|
                  det.nombre         payment.name;
                  det.cantidad       1;
                  det.precioUnitario invoice.amount;
               }
            }
         }
      end


      def create_detalles detalles, descuento
         builder = Builder::XmlMarkup.new
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

                  if detalle.exento
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
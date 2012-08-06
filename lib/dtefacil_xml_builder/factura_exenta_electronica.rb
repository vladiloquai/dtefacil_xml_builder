require 'builder'

module DtefacilXmlBuilder

    class FacturaExentaElectronica

        attr_accessor :descuento, :actividades_economicas, :receptor, :detalles
     
        def render_xml
            dtebuilder = DteBuilder.new

            xml = Builder::XmlMarkup.new
            xml.instruct!(:xml, version: "1.0", encoding: "ISO-8859-1")
            xml.facturaExentaElectronica(xmlns: "http://dtefacil.cl/1.2"){
                dtebuilder.create_actividades_economicas @actividades_economicas
                dtebuilder.create_receptor @receptor
                dtebuilder.create_detalles @detalles, @descuento
            }
        end 
    end
end
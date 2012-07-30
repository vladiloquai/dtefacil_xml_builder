require "builder"

module DtefacilXmlBuilder

	class DteBuilder
      def create_actividades_economicas actividades_economicas
         builder = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
         actividades_economicas.each do |act|
            builder.actividadEconomica(act)  
         end   
      end
   end
   
end
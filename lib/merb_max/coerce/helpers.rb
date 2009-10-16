module Merb
  module ResponderMixin
    module ClassMethods  
      # #to_i on input
      #
      def coerce_to_i(*keys)
        coerce(*keys){ |non_integer| non_integer.to_i }
      end
      
      # converts string rep of TRUE (html: on; flash: true) to TrueClass|FalseClass
      #
      def coerce_str_to_bool(*keys)
        coerce(*keys){ |str_bool| (str_bool == 'on' || str_bool == 'true')}
      end
    end
  end
end
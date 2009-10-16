# Make an easy accessor for checking the role of the server
#
module Merb
  class << self
    def role;Merb::Config[:role] || :www;end;
  end
end

module Merb  
  module ControllerMixin #changed from ResponderMixin
    
    # Instance level:
    #   Conditionally runs a block if the server is in the given roles
    #
    def role_does(*r)
      if r.member?(Merb.role) && block_given?
        yield
      end
    end  
    
    module ClassMethods      
      # Conditionally runs a block, great for setting up what a controller
      #   will do in a given role
      # 
      # @see Merb::Responder::Mixin#role_does
      #
      # @example
      #   class Home
      #     role_config(:api){
      #       only_provides(:js,:xml)
      #     }
      #
      #     role_config(:www){
      #       only_provides(:html, :js)
      #     }
      #
      def role_config(*r)
        if r.member?(Merb.role) && block_given?
          yield
        end
      end     
      
      
      
    end
    
  end
end
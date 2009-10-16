module Merb
  class Controller
    class << self
      alias :orig_inherited :inherited
      # Default any subclasses meta tags to that of the parent
      def inherited(klass)
        orig_inherited(klass)
        klass.meta(self.meta)
      end
      
      # Setter/Getter for meta Tags
      #
      # @param tags [Hash|Symbol|Nil]
      #   Hash      => Sets the given meta tags
      #   NilClass  => Returns the full hash of meta tags
      #   Symbol    => Returns the specific meta tag
      #
      # @api public
      def meta(tags = nil)
        @meta_tags ||={}
        
        if tags.is_a? Hash
          @meta_tags.merge!(tags) 
        elsif tags.is_a? Symbol
          return @meta_tags[tags]
        end

        @meta_tags
      end
    end

    # Getter/Setter for a controller instance's meta tags
    # 
    # @param tags [Hash|NilClass|Symbol]
    #   Hash      => Sets the given meta tags
    #   NilClass  => Outputs the HTML
    #   Symbol    => Returns the specific meta tag
    #
    # @returns [Hash|String]
    #
    # @api public
    def meta(tags = nil)
      @meta_tags ||= self.class.meta.clone

      if tags.is_a? Hash
        @meta_tags.merge!(tags)
        @meta_tags
      elsif tags.is_a? Symbol
        return @meta_tags[tags]
      else
        output_meta_tags @meta_tags
      end
    end

    protected

    # Outputs meta tags
    #
    # @param meta_data [Hash]
    #   Meta Tags to output
    #
    # @api private
    def output_meta_tags(meta_data)
      _meta_data = meta_data.clone
      meta_title = _meta_data.delete :title
      markup = meta_title ? %{<title>#{meta_title}</title>} : ''

      _meta_data.each{|name,content|
        markup << %{<meta name="#{name}" content="#{content}" />}
      }
      
      markup
    end
  end
end
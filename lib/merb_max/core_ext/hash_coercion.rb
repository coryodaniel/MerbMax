class Hash
  
  # Finds a deeply nested value and modifies it in place
  #
  # @example
  #   my_hash[:top_level][:sub_level] = 3
  #   my_hash.coerce(:top_level, :sub_level) {|v| v * 30}
  #   puts my_hash[:top_level][:sub_level] 
  #   # => 90
  #
  def coerce(*_keys_, &block)
    last_level    = self

    _keys_.each_with_index do |_key_, _idx_|
      if last_level.is_a?(Hash) && last_level.has_key?(_key_)
        if _idx_ + 1 == _keys_.length
          # Found, change the value
          last_level[_key_] = block.call(last_level[_key_])
        else                   
          last_level = last_level[_key_]
        end
      else 
        break
      end
    end
    
  end
  
end
module JSON
  def self.to_ostruct(json)
    hash_to_ostruct parse(json)
  end

private
  def self.hash_to_ostruct(hash)
    OpenStruct.new.tap { |ostruct|
      hash.each_pair do |k,v|
        if v.is_a? Hash
          ostruct.send "#{k}=", hash_to_ostruct(v)
        elsif v.respond_to? :each
          ostruct.send "#{k}=", v.map { |e| e.is_a?(Hash) ? hash_to_ostruct(e) : e }
        else
          ostruct.send "#{k}=", v
        end
      end
    }
  end
end

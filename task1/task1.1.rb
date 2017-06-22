class String
  def seq
    gsub(/(.)\1*/) { |c| "#{c.size}#{c[0]}" }
  end
end

puts s = '1'
5.times { puts s = s.seq }


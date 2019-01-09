def deep_diff(a, b, root_path=[])
  union_keys = a.keys() | b.keys()
  acc = {}
  union_keys.each { | key |
    a_val = a[key]
    b_val = b[key]
    path = root_path + [key]
    if a_val != b_val
      if a_val.class == b_val.class and a_val.class == Array
        acc = acc.merge(deep_diff_arr(a_val, b_val, path))
      elsif a_val.class == b_val.class and a_val.class == Hash
        acc = acc.merge(deep_diff(a_val, b_val, path))
      else
        acc[path] = [a_val, b_val]
      end
    end
  }
  acc
end

def deep_diff_arr(a, b, root_path)
  max_length = [a.length, b.length].max
  acc = {}
  (0..max_length).each do | n |
    a_val = a[n]
    b_val = b[n]
    path = root_path + [n]
    if a_val != b_val
      if a_val.class == b_val.class and a_val.class == Array
        acc = acc.merge(deep_diff_arr(a_val, b_val, path))
      elsif a_val.class == b_val.class and a_val.class == Hash
        acc = acc.merge(deep_diff(a_val, b_val, path))
      else
        acc[path] = [a_val, b_val]
      end
    end
  end
  acc
end

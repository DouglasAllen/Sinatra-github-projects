def put_array(*arg)
  arg
end

data = {one: "a hash", two: "with no hash rockets",  three: "it's the new style"}
puts put_array data.inspect

data = {id1: "a hash", id2: "with no hash rockets",  id3: "it's the new style"}
puts put_array data.inspect

def to_array(*arg)
  arg
end
  
data = {one: "a hash", two: "really", three: "but is defined as an associative array", four: "go look at Array.assoc"}
puts to_array data
  

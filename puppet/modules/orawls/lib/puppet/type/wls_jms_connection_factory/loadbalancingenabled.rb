newproperty(:loadbalancingenabled) do
  include EasyType

  desc 'loadbalancingenabled'
  newvalues(1, 0)

  to_translate_to_resource do | raw_resource|
    raw_resource['loadbalancingenabled']
  end

end

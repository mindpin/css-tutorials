window.buildel = (str)->
  arr = str.split('.')
  $re = jQuery("<#{arr.shift()}>")
  for klass in arr
    $re.addClass klass
  return $re
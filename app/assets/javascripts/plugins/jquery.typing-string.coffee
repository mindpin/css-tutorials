_show = ($el, str, idx, callback)->
  if idx < str.length
    $el.append str[idx]
    setTimeout ->
      _show $el, str, idx + 1, callback
    , 20

  else
    $el.append jQuery('<br/>')
    callback() if callback?


# 在指定的 dom 中逐个显示传入的文字
# 显示完毕后，调用指定方法
jQuery.fn.typing_string = (str, callback)->
  _show this, str, 0, callback
  return this
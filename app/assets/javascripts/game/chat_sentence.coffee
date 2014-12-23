window.ChatSentence = class ChatSentence
  constructor: (data)->
    if typeof data is 'string'
      _data = 
        text: data
    else
      _data = data

    @text = _data.text
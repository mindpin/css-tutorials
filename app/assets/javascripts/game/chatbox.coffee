# 对话面板
window.ChatBox = class ChatBox
  constructor: (@game)->
    @$chatbox = jQuery('.panel.chatbox')
    @pops = []

  # 清除所有泡泡，再调用回调方法
  clear: (callback)->
    _clear_count = @pops.length
    return callback() if _clear_count is 0

    for pop in @pops
      pop.remove ->
        _clear_count--
        callback() if _clear_count is 0

  # 显示对话脚本
  # 对话脚本可能包括 NPC 头像
  # 依次显示所有子句
  # 当子句全部显示完毕后，执行回调
  show_sentences: (script, callback)->
    callback_holder = new CallbackHolder
    finish = ->
      callback_holder.do 'finish'

    gamelog '[chatbox] show SENTENCES'

    npc =  @game.get_npc script.npc if script.npc

    chatpop = new ChatPop @$chatbox, npc
    chatpop
      .sentences script.sentences
      .on 'finish', ->
        finish()

    @pops.push chatpop

    return callback_holder

  # # 显示 html 片断
  # show_html: (script, callback)->
  #   htmlpop = new HTMLPop @$chatbox
  #   htmlpop.show script, ->
  #     htmlpop.remove()
  #     callback()

  # # 显示提问框
  # show_question: (script, callback)->
  #   gamelog '[chatbox] show question'

  #   questionpop = new QuestionPop @$chatbox
  #   console.log questionpop
  #   questionpop.show script, (result)=>
  #     gamelog '[chatbox] user selected: ' + result 
  #     @last_result = result
  #     questionpop.remove()
  #     callback()



  # _show: (chatpop, content, idx)->
  #   if idx < content.length
  #     ct = content[idx]

  #     _c0 = =>
  #       gamelog '[chatbox] continue content'
  #       @_show chatpop, content, idx + 1

  #     _c1 = =>
  #       chatpop.wait _c0


  #     if typeof ct is 'string'
  #       chatpop.append ct, _c1
  #     else if ct.link?
  #       chatpop.append_link ct.link, ct.text, ct.title, _c1
  #     else if ct.nowait
  #       chatpop.append ct.nowait, _c0
  #     else if ct.delay
  #       chatpop.append ct.text, =>
  #         setTimeout =>
  #           _c0()
  #         , ct.delay

  #     return

  #   gamelog '[chatbox] content end'
  #   if not @keep
  #     chatpop.remove() # remove 里会调用 callback
  #   else
  #     # 如果保持对话泡泡，则等待事件 game.clearchat 时清空
  #     chatpop.callback()
  #     chatpop.callback = null
  #     jQuery(document).one 'game.clearchat', ->
  #       chatpop.remove()
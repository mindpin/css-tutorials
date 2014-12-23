# 对话面板
window.ChatBox = class ChatBox
  constructor: (@game)->
    @$chatbox = jQuery('.panel.chatbox')

  # 显示旁白脚本
  # 依次显示所有子句
  # 当子句全部显示完毕后，执行回调
  show_aside: (script)->
    callback_holder = new CallbackHolder
    finish = ->
      callback_holder.do 'finish'

    gamelog '[chatbox] show aside'
    chatpop = new ChatPop @$chatbox
    chatpop
      .sentences script.aside
      .on 'finish', ->
        finish()

    return callback_holder
    
    # chatpop = new ChatPop @$chatbox
    # chatpop.callback = callback
    # @_show chatpop, script.aside, 0

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

  # # 显示对话脚本
  # # 对话脚本包括 NPC 头像
  # # 对话脚本可能包含多句对话
  # # 每一句对话后，需要显示“点击继续”
  # # 点击后，继续下一句对话
  # # 当对话全部完毕后，点击运行 callback
  # show_chat: (script, callback)->
  #   gamelog "[chatbox] show chat by npc: #{script.chat}"
  #   gamelog script
  #   npc =  @game.get_npc script.chat
    
  #   chatpop = new ChatPop @$chatbox, npc
  #   chatpop.callback = callback

  #   @keep = script.keep # 是否保持对话泡泡
  #   @_show chatpop, script.content, 0

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
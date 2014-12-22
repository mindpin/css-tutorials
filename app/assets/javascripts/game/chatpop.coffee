# 对话面板
window.ChatBox = class ChatBox
  constructor: (@game)->
    @$chatbox = jQuery('.panel.chatbox')

  # 显示旁白脚本
  # 旁白脚本可能包含多句对话
  # 每一句对话后，需要显示“点击继续”
  # 点击后，继续下一句对话
  # 当对话全部完毕后，点击运行 callback
  show_aside: (script, callback)->
    gamelog '[chatbox] show aside'
    gamelog script
    
    chatpop = new ChatPop @$chatbox
    chatpop.callback = callback
    @_show chatpop, script.aside, 0

  # 显示对话脚本
  # 对话脚本包括 NPC 头像
  # 对话脚本可能包含多句对话
  # 每一句对话后，需要显示“点击继续”
  # 点击后，继续下一句对话
  # 当对话全部完毕后，点击运行 callback
  show_chat: (script, callback)->
    gamelog "[chatbox] show chat by npc: #{script.chat}"
    gamelog script
    npc =  @game.get_npc script.chat
    
    chatpop = new ChatPop @$chatbox, npc
    chatpop.callback = callback
    @_show chatpop, script.content, 0

  _show: (chatpop, content, idx)->
    if idx < content.length
      ct = content[idx]

      _c0 = =>
        gamelog '[chatbox] continue content'
        @_show chatpop, content, idx + 1

      _c1 = =>
        chatpop.wait _c0


      if typeof ct is 'string'
        chatpop.append ct, _c1
      else if ct.link?
        chatpop.append_link ct.link, ct.text, ct.title, _c1
      else if ct.nowait
        chatpop.append ct.nowait, _c0
      else if ct.delay
        chatpop.append ct.text, =>
          setTimeout =>
            _c0()
          , ct.delay

    else
      gamelog '[chatbox] content end'
      chatpop.remove() # remove 里会调用 callback

# 对话泡泡

# 用法
# pop = new ChatPop($panel, npc)
# pop.append(str1, callback)
# pop.append(str2, callback)
# pop.remove()

# 旁白对话
# pop = new ChatPop($panel)

# 显示等待提示
# pop.wait(callback)

window.ChatPop = class ChatPop
  constructor: (@$panel, @npc)->
    @$chatpop = buildel 'div.chatpop'
      .css
        'opacity': 0
        'top': 30
      .animate
        'opacity': 1
        'top': 0
      , 500
      .appendTo @$panel

    if @npc?
      @$npc_avatar = buildel 'img.avatar'
        .attr 'src', npc.avatar
        .appendTo @$chatpop
    else
      @$chatpop.addClass 'no-npc'

    @$area = buildel 'div.area'
      .appendTo @$chatpop

    @$pop = buildel 'div.pop'
      .appendTo @$area

    if @npc?
      @$npc_name = buildel 'div.name'
        .html @npc.name + ":"
        .appendTo @$pop

  append: (str, callback)->
    $log = buildel 'div.log'
      .appendTo @$pop
      .typing_string str, callback

  append_link: (url, text, title, callback)->
    $log = buildel 'div.log'
      .appendTo @$pop
    $a = buildel 'a.chat-link'
      .attr
        href: url
        title: title
        target: '_blank'
      .appendTo $log
      .typing_string text, callback
      .on 'click', (evt)->
        evt.stopPropagation()

  wait: (callback)->
    $wait = buildel 'div.click-to-continue'
      .append buildel('span').html('点击屏幕任意位置继续')
      .hide().fadeIn 100
      .appendTo @$area

    jQuery(document).one 'click', ->
      $wait.remove()
      callback()

  remove: ->
    @$chatpop
      .animate
        'opacity': 0
      , 200, =>
        @$chatpop.remove()
        @callback() if @callback()
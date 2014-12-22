window.gamelog = (param)->
  console.log param

ScriptRunner = class ScriptRunner
  constructor: (@game)->
    @chatbox = new ChatBox @game

  run: (script, callback)->
    kind = 'aside' if script.aside?
    kind = 'chat' if script.chat?

    switch kind
      when 'aside'
        gamelog '[runner] aside:'
        @chatbox.show_aside script, =>
          gamelog '[runner] aside end, run next script'
          callback()

      when 'chat'
        gamelog '[runner] chat:'
        @chatbox.show_chat script, =>
          gamelog '[runner] aside end, run next script'
          callback()
        return


# 游戏脚本解析器
window.Game = class Game
  constructor: (@data)->
    @load_npcs()

    @init()
    @start()

  load_npcs: ->
    @npcs = {}
    for npc_data in @data.npcs
      @npcs[npc_data.name] = new NPC npc_data.name, npc_data.avatar

  get_npc: (name)->
    @npcs[name]

  init: ->
    @runner = new ScriptRunner @

    # $css_textarea = jQuery('textarea.code.css').val @data.init.css
    # $html_textarea = jQuery('textarea.code.html').val @data.init.html

    # @cm_css = CodeMirror.fromTextArea $css_textarea[0], {
    #   mode: 'css'
    #   lineNumbers: true
    #   theme: 'vibrant-ink'
    #   lineWrapping: true
    # }

    # @cm_html = CodeMirror.fromTextArea $html_textarea[0], {
    #   mode: 'htmlmixed'
    #   lineNumbers: true
    #   theme: 'vibrant-ink'
    #   lineWrapping: true
    # }

  start: ->
    @idx = -1
    jQuery(document).on 'game.next_script', =>
      @idx++
      @run_next()

    jQuery(document).trigger 'game.next_script'

  # 执行下一条脚本
  run_next: ->
    gamelog '[game] run next:'
    if @idx < @data.scripts.length
      @runner.run @data.scripts[@idx], =>
        gamelog '[game] a script end'
        @idx++
        @run_next()

    else
      gamelog '脚本运行结束'
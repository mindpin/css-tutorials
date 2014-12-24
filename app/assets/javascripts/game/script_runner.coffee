# 判断脚本类型，并调用对应的执行方法
window.ScriptRunner = class ScriptRunner
  constructor: (@game)->
    @chatbox = new ChatBox @game

  run: (script)->
    callback_holder = new CallbackHolder
    finish = ->
      callback_holder.do 'finish'

    _run = =>
      # sentences
      if script.sentences
        gamelog '[runner] script SENTENCES'
        @chatbox
          .show_sentences script
          .on 'finish', =>
            gamelog '[runner] SENTENCES finished'
            finish()

    script.clear ?= true
    if script.clear
      @chatbox.clear _run
    else
      _run()

    return callback_holder


    # kind = 'chat' if script.chat?
    # kind = 'select' if script.select?
    # kind = 'by_last_result' if script.by_last_result?
    # kind = 'showhtml' if script.showhtml?

    # switch kind
    #   when 'aside'
    #     gamelog '[runner] aside:'
    #     @chatbox.show_aside script, =>
    #       gamelog '[runner] aside end, run next script'
    #       callback()

    #   when 'chat'
    #     gamelog '[runner] chat:'
    #     @chatbox.show_chat script, =>
    #       gamelog '[runner] aside end, run next script'
    #       callback()

    #   when 'select'
    #     gamelog '[runner] question:'
    #     @chatbox.show_question script, =>
    #       callback()

    #   when 'by_last_result'
    #     gamelog '[runner] by last result:'
    #     script1 = script.by_last_result.scripts[@chatbox.last_result]
    #     @run script1, callback

    #   when 'showhtml'
    #     gamelog '[runner] show html:'
    #     @chatbox.show_html script, =>
    #       callback()


    # kind = 'clearchat' if script.clearchat?
    # switch kind
    #   when 'clearchat'
    #     jQuery(document).trigger('game.clearchat')
    #     setTimeout ->
    #       callback()
    #     , 300
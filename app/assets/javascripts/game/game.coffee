# 游戏脚本解析器
window.Game = class Game
  constructor: (@data)->
    @scripts = @data.scripts
    @load_npcs()

    @init()
    @start()

  load_npcs: ->
    @npcs = {}
    for npc_data in @data.npcs
      @npcs[npc_data.id] = new NPC npc_data

  get_npc: (id)->
    @npcs[id]

  init: ->
    @runner = new ScriptRunner @

  start: ->
    @idx = 0
    @run_next()

  # 执行下一条脚本
  run_next: ->
    if @idx < @scripts.length
      gamelog "[game] run script ##{@idx}"
      @runner
        .run @scripts[@idx]
        .on 'finish', =>
          gamelog '[game] a script finished'
          gamelog ''
          @idx++
          @run_next()

    else
      gamelog '脚本运行结束'
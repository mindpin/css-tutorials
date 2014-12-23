jQuery(document).on 'ready page:load', ->
  return if not window.story_data?
  game = new Game window.story_data
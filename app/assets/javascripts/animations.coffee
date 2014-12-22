# 使用了缓动曲线扩展库：
# http://gsgd.co.uk/sandbox/jquery/easing/

# 提示 css 输入区域
jQuery(document).on 'animation.tip-to-css-panel', (evt, func)->
  jQuery('.panel.css').addClass('animation-tip-to')
  func()

# 提示 html 输入区域
jQuery(document).on 'animation.tip-to-html-panel', (evt, func)->
  jQuery('.panel.css').removeClass('animation-tip-to')
  jQuery('.panel.html').addClass('animation-tip-to')
  func()

# html 输入区域抖动
jQuery(document).on 'animation.html-be-attack', (evt, func)->
  jQuery('.panel.html').addClass('tip2')
  func()

# NPC 被攻击
jQuery(document).on 'animation.npc-be-attack', (evt, func)->
  jQuery('.panel.tips').addClass('animation-be-attack')
  setTimeout ->
    func()
  , 1000
  setTimeout ->
    jQuery('.panel.tips').removeClass 'animation-be-attack'
  , 2000

# 坏猫变走 css 区域
jQuery(document).on 'animation.lock-css-area', (evt, func)->
  jQuery('.panel.css').addClass('be-attack-and-fade')
  setTimeout ->
    func()
  , 3000

# 坏猫变走 html 区域
jQuery(document).on 'animation.lock-html-area', (evt, func)->
  jQuery('.panel.html').addClass('be-attack-and-fade')
  setTimeout ->
    func()
  , 3000

# 坏猫变走 preview 区域
jQuery(document).on 'animation.lock-preview-area', (evt, func)->
  jQuery('.panel.preview').addClass('be-attack-and-fade')
  setTimeout ->
    func()
  , 3000

# ben7th 被坏猫吹飞
jQuery(document).on 'animation.ben7th-fly', (evt, func)->
  $img = jQuery('.tip-info .avatar').find('img')

  $img
    .animate
      'top': -200
    , 300, 'easeOutQuad'

    .animate
      'top': 600
    , 300, 'easeInQuad', ->
      jQuery('.tip-info .dbox')
        .animate
          'top': 600
        , 300, 'easeInQuad', ->
          jQuery('.tip-info .dbox').css 'top', ''
          func()

# 坏猫消失
jQuery(document).on 'animation.badcat-fadeout', (evt, func)->
  $img = jQuery('.tip-info .avatar')
    .find('img')

  $img.fadeOut 500, ->
    jQuery('.tip-info .dbox').fadeOut 500, ->
      setTimeout ->
        jQuery('.tip-info .dbox').show()
        func()
      , 500
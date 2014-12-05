jQuery(document).on 'ready page:load', ->
  editor = jQuery('.markdown-source')
  cm = CodeMirror.fromTextArea editor[0], {
    mode: 'gfm'
    lineNumbers: true
    styleActiveLine: true
    theme: 'vibrant-ink'
    indentWithTabs: false
    lineWrapping: true
  }
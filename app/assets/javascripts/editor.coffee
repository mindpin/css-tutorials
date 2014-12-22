jQuery(document).on 'ready page:load', ->
  return

  html_editor = jQuery('.html.editor .source')
  CodeMirror.fromTextArea html_editor[0], {
    mode: 'htmlmixed'
    lineNumbers: true
    styleActiveLine: true
    theme: 'vibrant-ink'
    indentWithTabs: false
    lineWrapping: true
  }

  css_editor = jQuery('.css.editor .source')
  CodeMirror.fromTextArea css_editor[0], {
    mode: 'css'
    lineNumbers: true
    styleActiveLine: true
    theme: 'vibrant-ink'
    indentWithTabs: false
    lineWrapping: true
  }

  js_editor = jQuery('.js.editor .source')
  CodeMirror.fromTextArea js_editor[0], {
    mode: 'javascript'
    lineNumbers: true
    styleActiveLine: true
    theme: 'vibrant-ink'
    indentWithTabs: false
    lineWrapping: true
  }
  
  markdown_editor = jQuery('.markdown.editor .source')
  CodeMirror.fromTextArea markdown_editor[0], {
    mode: 'gfm'
    lineNumbers: true
    styleActiveLine: true
    theme: 'vibrant-ink'
    indentWithTabs: false
    lineWrapping: true
  }
$ ->
  unless toggleMenu?
    toggleMenu = (buttonID, menuID)->
      c = $(buttonID).attr('class')
      if c == 'selected'
        $(menuID).hide()
        $(buttonID).attr('class', 'unselected')
      else
        $(menuID).show()
        $(buttonID).attr('class', 'selected')

  $('.versions').on 'click', '#version-ddown-button', () ->
    toggleMenu('#version-ddown-button', '#version-list')
    #toggleSelected('#version-ddown-title')
    #toggleSelected('#version-ddown-arrow')

  # Mouse click on sub menu or account link
  $('.versions').on 'mouseup', '#version-ddown-button', () -> false
  $('.versions').on 'mouseup', '#version-list', () -> false

  $().on 'mouseup', document, () ->
    $('#version-list').hide()
    $('#version-ddown-button').attr('class', 'unselected')

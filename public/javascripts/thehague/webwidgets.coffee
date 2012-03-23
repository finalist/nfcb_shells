this.AUTHORITY_CODE = 'HHS'

$ ->
  $('#product_panel').bind 'productLinkPress', () ->
    switchToDetailAndContactsView()
  $('#product_panel').bind 'themeLinkPress', () ->
    switchToThemeView()
  $('#product_panel').bind 'detailBackButtonPress', () ->
    switchToSearchAndResultsView()
  $('#product_panel').bind 'themeBackButtonPress', () ->
    switchToSearchAndResultsView()
  $('#search_panel').bind 'search', () ->
    switchToSearchAndResultsView()

  init()

init = () ->
  window.loadSearchPanel(window.AUTHORITY_CODE)

switchToDetailAndContactsView = () ->
  $('#search_explanation').addClass('hidden')
  $('#search_panel').removeClass('hidden')
  $('#product_panel').addClass('hidden')
  $('#theme_panel').addClass('hidden')
  $('#details_panel').removeClass('hidden')
  $('#contacts_panel').removeClass('hidden')

switchToSearchAndResultsView = () ->
  $('#search_explanation').addClass('hidden')
  $('#details_panel').addClass('hidden')
  $('#contacts_panel').addClass('hidden')
  $('#theme_panel').addClass('hidden')
  $('#search_panel').removeClass('hidden')
  $('#product_panel').removeClass('hidden')

switchToThemeView = () ->
  $('#search_explanation').addClass('hidden')
  $('#details_panel').addClass('hidden')
  $('#contacts_panel').addClass('hidden')
  $('#search_panel').removeClass('hidden')
  $('#product_panel').addClass('hidden')
  $('#theme_panel').removeClass('hidden')

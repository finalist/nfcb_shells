#
# AUTHORITY_CODE is already defined in rlb_required.coffee, but should be overridden here when needed
# if you override AUTHORITY_CODE here, you should remove "this.AUTHORITY_CODE = window.getAuthFromUrl()" from the init function
#
this.AUTHORITY_CODE = 'null'
this.AUTHORITY_CODE = window.getAuthFromUrl()

#
# DEVELOPMENT SPECIFIC, SETTING SERVER FOR OTHER THAN PRODUCTION ENVIRONMENTS
#
getDomainPortString = () ->
  host = 'http://' + document.location.hostname
  port = document.location.port
  if port == null
    host
  else
    host + ":" + port
this.RLB_SERVER = getDomainPortString()


$ ->
  $('#product_panel').bind 'productLinkPress', () ->
    switchToDetailAndContactsView()
  $('#product_panel').bind 'themeLinkPress', () ->
    switchToThemeView()
  $('#product_panel').bind 'detailBackButtonPress', () ->
    switchToSearchAndResultsView()
  $('#product_panel').bind 'themeBackButtonPress', () ->
    switchToSearchAndResultsView()

  init()

init = () ->
  window.loadSearchPanel(window.AUTHORITY_CODE)
  window.loadStartPage('product_panel')

switchToDetailAndContactsView = () ->
  $('#search_panel').addClass('hidden')
  $('#product_panel').addClass('hidden')
  $('#theme_panel').addClass('hidden')
  $('#details_panel').removeClass('hidden')
  $('#contacts_panel').removeClass('hidden')

switchToSearchAndResultsView = () ->
  $('#details_panel').addClass('hidden')
  $('#contacts_panel').addClass('hidden')
  $('#theme_panel').addClass('hidden')
  $('#search_panel').removeClass('hidden')
  $('#product_panel').removeClass('hidden')

switchToThemeView = () ->
  $('#details_panel').addClass('hidden')
  $('#contacts_panel').addClass('hidden')
  $('#search_panel').addClass('hidden')
  $('#product_panel').addClass('hidden')
  $('#theme_panel').removeClass('hidden')

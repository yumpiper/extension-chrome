console.log 'Yo FOOOOOD'
console.log $('#main')

processPage = ->
    results = $('#search .g')
    return unless results.length
    console.debug results

    results.each -> loadGoogleResult @

icons =
  'flour':    ['grains']
  'parmesan': ['eggs']
  'eggs':     ['eggs']
  'milk':     ['milk']
  'butter':   ['milk']
  'lemon':    ['vegetables']
  'chicken':  ['meat']
  'cream':    ['milk']
  'bread':    ['grains']
  'vegetable':['vegetables']
  'garlic':   ['vegetables']
  'paprika':  ['vegetables']


loadGoogleResult = (element)->
  console.log recipeUrl = $(element).find('.r > a[href]').first().attr('href')

  chrome.runtime.sendMessage
    msg:'getUrl'
    url:recipeUrl
  , (results)->
    #$.get(recipeUrl, 'text').then (results)->
    results = results.replace(/(<[^>]*\b)src/gmi,'$1x-src').replace(/<(\/?)script/gmi,'<$1x-script')
    myParsedElement = $(results)
    console.log myParsedElement

    allIngredients = []
    myParsedElement.find('[itemprop="ingredients"]').each -> allIngredients.push $(@).text()
    matchedIngredients = []
    _.each allIngredients, (ingredient)->
      match = ingredient.match ingredientsRegex
      matchedIngredients.push match[1].toLowerCase() if match
    matchedIngredients = _.uniq matchedIngredients
    console.log recipeUrl, matchedIngredients
    if matchedIngredients.length is 0
      $(element).find('h3').addClass('done')
      return
    getRating(matchedIngredients)
    .done ->
      $(element).find('h3').addClass('done')
    .then (result)->
      return unless result.ratings.yummy + result.ratings.health >0
      console.log result
      $(element).find('h3').append "
      <span class='HACKATHON-search-wrapper'>
        <span class='HACKATHON-google yummie'>Yummie <span class='number'>#{result.ratings.yummy}</span></span>
        <span class='HACKATHON-google healthy'>Healthy <span class='number'>#{result.ratings.health}</span></span>
      </span>"

      allIcons = []
      ingredientIcons = _.intersection _.keys(icons),matchedIngredients
      for ingredient in ingredientIcons
        allIcons = _.union allIcons, icons[ingredient]
      console.log allIcons
      imgTags = ''
      for icon in allIcons
        imgTags += "<img class='icon' src='"  + chrome.extension.getURL("img/#{icon}.png") + "'>"
      $(element).find('.st').append("<div class='mysugr-nutrients'>#{imgTags}</div>")

$('#main')[0].addEventListener(
  'DOMNodeInserted'
  (event)->
    return unless event.relatedNode.id is 'search'
    processPage()
)

processPage()

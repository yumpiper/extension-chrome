ingredientsRegex = null

runScriptForDomain = (domain)->
  $.get(chrome.extension.getURL("domains/#{domain}.coffee"),'text')
  .done (source)->eval CoffeeScript.compile source, bare: false

#
# Load the list of ingredients from Github
# That's a simple text file with one ingredient per line
#
loadIngredients = ->
  $.get('https://rawgit.com/hermes11/Food/master/ingredients-list.txt','text')
  .done (text)->
    keywords = text.split /\n/
    ingredientsRegex = new RegExp '\\b((?:' + (keywords.join '|') + ')s?)\\b','i'

getRatingHtml = (ingredients)->
  getRating(ingredients).then (result)->
    url = chrome.extension.getURL("img/rating-#{result.ratings.yummy}-#{result.ratings.health}.png")
    "<div id='HACKATHON-foodrating' style='background-image:url(#{url})'>
      <span class='HACKATHON-score'>
        <span class='yummie'>#{result.ratings.yummy}</span>
        <span class='health'>#{result.ratings.health}</span>
      </span>
     </div>
    "

loadIngredients()
.then ->
  domain = window.location.hostname.replace(/^www\./,'').match(/^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}/)
  runScriptForDomain(domain).fail -> runScriptForDomain 'microformats'

console.log 'germanfood.about.com'
allIngredients = []
$('[itemprop="ingredients"]').each -> allIngredients.push $(@).text()
console.log allIngredients
matchedIngredients = []
_.each allIngredients, (ingredient)->
  match = ingredient.match ingredientsRegex
  matchedIngredients.push match[1] if match
matchedIngredients = _.uniq matchedIngredients

console.log matchedIngredients

largestImage = _.reduce $('img'),(result,image)->
  $image = $(image)
  return result unless $image.width() * $image.height > result.width * result.height
  result.width  = $image.width()
  result.height = $image.height()
  result.element= image
, {element: null, width:0, height: 0}

getRatingHtml(matchedIngredients).then (html)->
  $(largestImage.element).wrap('<div style="position:relative" class="HACKATHON-wrapper">').append html
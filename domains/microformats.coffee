console.log 'microformats'
allIngredients = []
$('[itemprop="ingredients"]').each -> allIngredients.push $(@).text()
matchedIngredients = []
_.each allIngredients, (ingredient)->
  match = ingredient.match ingredientsRegex
  matchedIngredients.push match[1] if match
matchedIngredients = _.uniq matchedIngredients

bestImage = $('[itemprop=image]')
if bestImage.length>0 then bestImage = bestImage[0]
else
  largestImage = _.reduce $('img'),(result,image)->
    $image = $(image)
    return result unless $image.width() * $image.height() > result.width * result.height
    result.width  = $image.width()
    result.height = $image.height()
    result.element= image
  , {element: null, width:0, height: 0}
  console.log largestImage
  bestImage = largestImage.element

console.log bestImage

getRatingHtml(matchedIngredients).then (html)->
  $(bestImage).wrap('<div style="position:relative" class="HACKATHON-wrapper">').parent().append html
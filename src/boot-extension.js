function getRating(ingredients)
{
  console.log('getRating');
  var deferred = $.Deferred();
  var url='http://127.0.0.1:5000/?ingredients='+ingredients.join(',').toLowerCase();
  chrome.runtime.sendMessage({msg:'getUrl',url:url}, function(results){
    console.log(results);
    deferred.resolve(results);
  });
  return deferred;
  return $.getJSON('http://127.0.0.1:5000/?ingredients='+ingredients.join(',').toLowerCase());
}

$.get(
  chrome.extension.getURL("src/extension.coffee"),
  "text"
)
.done(function(source){
  eval(CoffeeScript.compile(source, {bare: false}));
});
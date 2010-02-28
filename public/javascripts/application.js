// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var AJAX_INDICATOR = '/images/progress.gif'

function addToOnLoad(f_) {
  var oldOnLoad = window.onload;
  
  window.onload = function() {
    if (oldOnLoad) {
      oldOnLoad();
    }
    f_();
  };
}

function setFlashNotice(msg_) {
  setFlash('notice', msg_);
}

function setFlashError(msg_) {
  setFlash('error', msg_);
}

function setFlash(type_, msg_) {
  var flash = $('flash-' + type_);

  flash.innerHTML = msg_; 
  flash.show();
}

function insert_ajax_indicator(element_) {
  element_.innerHTML = '<img src="' + AJAX_INDICATOR + '" class="ajax-indicator" />';
}

function openPhoto(src_) {
  window.open(src_, 'photo', 'menubar=no, toolbar=no, location=no, scrollbars=no, resizable=yes, status=no, width=640, height=480')
}

var generate_rating = function (element, count) {
    var wrapper = $("<div class='static-rating-wrapper' ></div>");
    var self = this;
    var elem = element;
    var q = Math.round(count);
    elem.append(wrapper);
    wrapper.empty();
    for(var i = 0; i < q; i++){
        wrapper.append("<div class='static-rating-element'> </div>");
    }
};

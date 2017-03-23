/**
 * Created by FD on 23.03.2017.
 */
var ready = function() {
    $('a[data-rel="lightcase:myCollection:slideshow"]').lightcase({showSequenceInfo: false, transition: 'scrollHorizontal'});
    $('a[data-rel="lightcase"]').lightcase();
};


$(document).on('turbolinks:load', ready);
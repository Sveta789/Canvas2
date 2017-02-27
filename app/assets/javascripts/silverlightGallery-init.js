var ready = function() {
    var containers = $(".track");
    containers.each(function (index,container) {
;
        var track = $(container).find(".slider-container").silverTrack({
            perPage: Math.floor(($(window).width()/350 * 0.8)),
            itemClass: "silverlight-item",
            cover: true,
            easing: "easeInOutQuad",
            duration: 600
        });
        console.log("Win width: " + $(window).width() + " , items: " + Math.floor(($(window).width()/350 * 0.8)));
        track.install(new SilverTrack.Plugins.Css3Animation());

        track.install(new SilverTrack.Plugins.Navigator({
            prev: $("a.prev", $(container)),
            next: $("a.next",  $(container))
        }));


        track.start();
    });
    $('a[data-rel="lightcase:myCollection:slideshow"]').lightcase({showSequenceInfo: false, transition: 'scrollHorizontal'});
    $('a[data-rel="lightcase"]').lightcase();

};


$(document).on('turbolinks:load', ready);


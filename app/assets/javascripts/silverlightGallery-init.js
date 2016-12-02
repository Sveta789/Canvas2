var ready = function() {
    var containers = $(".track");
    containers.each(function (index,container) {
        var track = $(container).find(".slider-container").silverTrack({
            itemClass: "silverlight-item",
            cover: true,
            easing: "easeInOutQuad",
            duration: 600
        });

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


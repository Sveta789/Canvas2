
$(document).on('turbolinks:load', function () {

    //replacing
    TabsReplace({tabs_name: '.tab_item',
        container_name: '.tabs_container',
        active_tab: 'active_tab',
        active_button: 'active_tab_button',
        button_name: '.tabs_button'});

    //fading
    TabsReplace({tabs_name: '.tab_item_fade',
        container_name: '.tabs_container_fade',
        active_tab: 'active_tab_fade',
        active_button: 'active_tab_button_fade',
        button_name: '.tabs_button_fade'});
});

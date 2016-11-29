
$(document).on('turbolinks:load', function () {
    Tabs({tabs_name: '.tab_item',
        container_name: '.tabs_container',
        active_tab: 'active_tab',
        active_button: 'active_tab_button',
        button_name: '.tabs_button'});
});

var Tabs = function(options){
    var tabs_class = options.tabs_name;
    var container = options.container_name;
    var active_tab_name = options.active_tab;
    var active_button_name = options.active_button;
    var tab_buttons_name = options.button_name;
    var tabs_buttons =  $(tab_buttons_name);
    var tabs = $(container + " " + tabs_class);
    tabs_buttons.each(function (index, element) {
        $(element).on('click', function () {
            //Операции с самой кнопкой
            tabs_buttons.each(function (counter) {
               $(this).removeClass(active_button_name);
                if(counter == index) {
                    $(this).toggleClass(active_button_name, true);
                }
            });
            // Операции с вкладками
            tabs.each(function (i, tab) {
                $(tab).removeClass(active_tab_name);
                if(i == index) {
                    $(tab).toggleClass(active_tab_name, true);
                }
            });

        })
    });
};

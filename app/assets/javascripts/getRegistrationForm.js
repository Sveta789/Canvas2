$(document).on('turbolinks:load', function () {
    $('#sign_up_btn').on('click', function () {
        $.ajax('/signup').done(function () {
            $('#registration_box').append('<div class = "answer"></div>');
        })
    })
});


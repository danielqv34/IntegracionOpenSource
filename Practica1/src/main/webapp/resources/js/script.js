/**
 * Created by ezequ on 6/25/2016.
 */
$(document).ready(function () {
    $('#home').click(function () {
        $(location).attr('href', 'index.jsp');
    });
    $('#back').click(function () {
        $(location).attr('href', 'ServletIndex');
    });
});
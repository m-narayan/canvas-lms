function logout()
{
   window.open("https://beacon.arrivu.corecloud.com/sign_out","_self")

 $.ajax({
      url: "/logout",
      type: "GET",
      async:false,
      success: function(){
         success = true
      }
    });
    if(success){ //AND THIS CHANGED
     window.open("https://beacon.arrivu.corecloud.com/sign_out","_self")
    }
}
$(document).ready(function(){
  var calender_menu = $('#calendar_menu_item');
  var course_menu = "<li class='menu-item'><a href='https://beacon.arrivu.corecloud.com/courses' class='menu-item-no-drop'>Course library</a></li>";
  $(course_menu).insertAfter($(calender_menu));

});

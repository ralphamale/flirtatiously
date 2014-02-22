<input type="text" name="profile[zip_code]" value="<%= @profile.zip_code%>"></label>


OLD

// <---script>
// $(document).ready(function() {
//   $('.profile-field').on('click', '.editable', function(event) {
//     var $text = $(event.currentTarget);
//
//     var $profileField = $(event.target).closest('.profile-field')
//
//
//     var inputValue = $text.html();
//     var inputName = $text.attr("name");
//
//     $profileField.html("<textarea class=\"editing\" name=\"" + inputName + "\">" + inputValue + "</textarea>");
//   });
//
//   $('.profile-field').on('blur', '.editing', function(event) {
//     var $inputField = $(this);
//     var $profileField = $(this).closest('.profile-field');
//     var paramsName = $(this).attr("name");
//     var paramsValue = $(this).val();
//
//     var formData = $(this).serializeJSON();
//     console.log(formData);
//     var $that = $(this);
//     $.ajax({
//             url: "<%= profile_url(@profile.id) %>", //will cause trouble?
//             type: "PUT",
//             data: formData,
//             dataType: "json",
//             success: function (response) {
//               console.log($profileField);
//               console.log($that);
//               console.log(response);
//
//               $profileField.html("<span class=\"editable\" name=\"" + $that.attr("name") + "\">" + $that.val() + "</span>");
//             },
//             error: function(response) {
//               console.log("error");
//             }
//           });
//   });
// });
//
// <---/script>
<div class="profile-field modifying">
  <span class="owner-can-modify" id="big-pic">
    Change big picture
  </span>

  <input type="file" class="form-input" name="profile[big_photo]">
</div>


<div class="profile-field">
  <span class="owner-can-modify" id="age">
    <%= age(@profile.birthday) %>
  </span>
  <input type="date"
    class="form-input"
      name="profile[birthday]"
        value="<%= @profile.birthday %>">
</div>

Change big photo: <input type="file" name="profile[big_photo]">


    Birthday: <input name="profile[birthday]" type="date" value="<%= @profile.birthday %>"> <%= age(@profile.birthday) %>


    <div class="profile-field">
      <span class="owner-can-modify" name="profile[description]">
        <%= @profile.description %>
      </span>
      <textarea class="form-input" name="profile[description]"></textarea>
    </div>


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
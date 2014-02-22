<script>
$(document).ready(function() {
  $('.profile-field').on('click', '.owner-can-modify', function(e) {
    var $profileText = $(this);
    var $profileField = $(this).closest('.profile-field');
    var $input = $profileField.closest('.form-input')

    if ($input.is('textarea')) {
      $input.html($(this).html());
    };
    //regular text input too.
    $profileField.addClass('modifying');
  });
  //set name in there!
  $('.profile-field').on('blur', '.modifying', function(e) {
    var $input = $(this);
    var $profileField = $input.closest('.profile-field');
    var $profileText = $profileField.find('.owner-can-modify');
    var formData = $(this).serializeJSON();

    var newValue;
    if ($input.is('select')) {
      newValue = this.options[e.target.selectedIndex].text;
    } else {
      newValue = $input.val();
    };
    // var newValue = $(this).;

    //if its not a select with text Choose New
    $.ajax({
            url: "<%= profile_url(@profile.id) %>",
            type: "PUT",
            data: formData,
            dataType: "json",
            success: function(r) {
              alert("Great!");
              $profileText.html(newValue);
              $profileField.removeClass('modifying');
            },
            error: function(r) {
              alert("Error");
            }
  });


});



//when doing feedback ,if the textarea hasnt changed since the text. dont do shit!
</script>
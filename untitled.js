<form action="<%= user_url(current_user) %>" method="post" data-remote="true">
<input type="hidden" name="_method" value="PUT">
<%= auth_token_input %>

Username: <%= current_user.username %>
<br>
Password: <input type="password" name="user[password]">
Email:  <input type="email" name="user[email]" value="<%= user.email %>">

<input type="submit" value="Update">
</form>

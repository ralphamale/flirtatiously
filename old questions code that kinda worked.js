<% if @is_current_user_profile %>
  Need to do for current user!!

<% else %>

<%= "This person has not answered any questions." if @other_user_responses.length == 0 %>

<% @other_user_responses.each do |other_response| %>
<p>
<%= other_response.question_text %><br>
<% debugger %>
<% current_user_response = find_response(other_response.question_id, @current_user_responses) %>

<% if current_user_response.nil? %>

Answer question <%= other_response.question_id %> to see their answer.

<% else %>


<%= (@profile["sex"] == "Male") ? "His" : "Her" %> response: <span class="<%= "unacceptable-resp" if is_unacceptable?(other_response, @current_user_acceptables) %>"><%= other_response.answer_text%> </span>
<br>
Your response:

<span class="<%= "unacceptable-resp" if is_unacceptable?(current_user_response, @other_user_acceptables) %>"><%= current_user_response.answer_text %></span>

<% end %>

<% end %>

<% end %>
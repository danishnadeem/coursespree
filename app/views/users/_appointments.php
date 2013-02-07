<%if youaretutor.count > 0 || youarestudent.count > 0%>
  <div class="title">Reminder</div>
  <%else%>
    Your don't have any active schedule
<%end%>
<% if @user.usertype =='tutor' && @user.id.to_s == session[:user_id].to_s %>
  <div>
    <%if youaretutor.count > 0%>
     <b>You will be hosting the following sessions:</b>
    <%end%>
    <% youaretutor.each do |m| %>
      <div>
        <%= link_to m.name, m%>
        On <!--m.start_time.strftime('%m/%d/%y')-->
        Student: <%= m.user.fullname%>
      </div>
    <%end%>
  </div>
    <br />
<% end%>


<% if @user.id.to_s == session[:user_id].to_s %>
  <div>
    <%if youarestudent.count > 0%>
     <b>You will be attending the following sessions:</b>
     <%end%>
    <% youarestudent.each do |m| %>
      <div>
        <%= link_to m.name, m%>
        On start time
        Tutor: <%= m.tutor.user.fullname%>
      </div>
    <%end%>
  </div>
    <br />
<% end%>

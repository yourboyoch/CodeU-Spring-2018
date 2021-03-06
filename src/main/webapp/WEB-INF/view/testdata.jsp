<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>

<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.User" %>


<!DOCTYPE html>
<html>
<head>
  <title>Load Test Data</title>
  <link rel="stylesheet" href="/css/main.css">
</head>

<body>
  
    <nav>
        <style type="text/css">
          a {transition-duration: 0.5s; text-decoration: none;}
          a:hover {opacity: 0.5;}
        </style>
        <a id="navTitle" href="/">
          <span id = "C_E">C</span><span id = "O">o</span><span id = "D">d</span><span id = "C_E">e</span><span id = "U">U</span>
        </a>
        <a href="/about.jsp">About</a>
        <div style="float: right; text-align: right;">
        <a href="/conversations">Conversations</a>
        <% if(request.getSession().getAttribute("user") != null){ %>
          <a href="/users/<%=request.getSession().getAttribute("user")%>">Hello <%= request.getSession().getAttribute("user") %>!</a>
        <% } else{ %>
          <a href="/login">Login</a>
          <a href="/register">Register</a>
        <% } %>
      <% if(request.getSession().getAttribute("user") != null){ %>
      <% if(UserStore.getInstance().getUser((String)request.getSession().getAttribute("user")).isAdmin()){%>
        <a href="/testdata">Administration</a>
      <% } else if(request.getSession().getAttribute("user") !=  null) {%>
        <a href="/testdata">App Statistics</a>
      <%}%>
      <% } %>
      </div>
      </nav>

  

  <div id="container">
    <h1 style="font-size: 175%">Administration</h1>
    <hr>
    <p> <strong>Users:</strong> <%=UserStore.getInstance().numUsers() %> </p>
    <p> <strong>Conversations:</strong> <%=ConversationStore.getInstance().numConversations()%> </p>
    <p> <strong>Messages:</strong> <%=MessageStore.getInstance().numMessages() %> </p>
    <p> <strong>Average Number of Messages per Conversation:</strong> <%=ConversationStore.getInstance().avgMessagesPerConvo() %></p>
    <%if (UserStore.getInstance().newestUser() != null) { %>
    	<p> <strong>Newest User:</strong> <%=UserStore.getInstance().newestUser().getName() %>, created at <%=UserStore.getInstance().newestUser().getReadableCreationTime() %></p>
    <% } %>
    <%if(UserStore.getInstance().mostActiveUser() != null) { %>
    	<p> <strong>Most active user:</strong> <%=UserStore.getInstance().mostActiveUser().getName() %></p>
    <% } %>
    <%if (UserStore.getInstance().wordiestUser() != null) { %>
    	<p> <strong>Wordiest User:</strong> <%=UserStore.getInstance().wordiestUser().getName() %></p>
    <% } %>
    <hr>
	<% if(request.getSession().getAttribute("user") != null){ %>
		<% if(UserStore.getInstance().getUser((String)request.getSession().getAttribute("user")).isAdmin()){%>
		<p>This will load a number of users, conversations, and messages for testing
        purposes.</p>
		<form action="/testdata" method="POST">
		  <button type="submit" value="confirm" name="confirm">Confirm</button>
		  <button type="submit" value="cancel" name="cancel">Do Nothing</button>
		</form>
		<%}%>
	<%}%>
  </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    	<meta charset="UTF-8">
    	<title>👻 Blueteen Chat!</title>
    </head>
    <body>
        <%@page import="blueteenchat.DataHandler"%>
        <%@page import="java.sql.ResultSet"%>
        <%
                    // We instantiate the data handler here, and get the message parameters
                    final DataHandler handler = new DataHandler();
                    try{
                    String name = request.getParameter("name");
                    String password = request.getParameter("password");
                    String message = request.getParameter("message");

                    //No-op if the user hasn't filled out all fields.
                    if (!(name.equals("") || password.equals("") || message.equals(""))) {
                        boolean success = handler.addMessage(name, password, message);
                    }
                    } catch (Exception e){
                    	//do nothing, not posting
                    }
        %>

        <!-- The table for displaying all messages -->
        <table>
            <%
            	final ResultSet cs = handler.getAllMessages();
                            while(cs.next()) {
                                out.println("<b>"+cs.getString("name")+"</b>: "+cs.getString("message")+"<br>");
                           }
            %>
          </table>
          <form action="index.jsp">
                   Name: <input type=text name=name>
                   Password: <input type=password name=password>
                   Message: <input type=text name=message>
                   <input type=submit value=Enter>
       	 </form>
        <form action="index.jsp" id="refresh">
                   <input type=submit value=refresh>
        </form>
    </body>
</html>

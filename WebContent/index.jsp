<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
        <title>👻</title>
    </head>
    <body>
        <%@page import="blueteenchat.DataHandler"%>
        <%@page import="java.sql.ResultSet"%>
        <%
                    // We instantiate the data handler here, and get all the movies from the database
                    final DataHandler handler = new DataHandler();
                    try{
                    String name = request.getParameter("name");
                    String address = request.getParameter("address");
                    String category = request.getParameter("category");

                    /*
                     * If the user hasn't filled out all the time, movie name and duration. This is very simple checking.
                     */
                    if (!(name.equals("") || address.equals("") || category.equals(""))) {
                        boolean success = handler.addCustomer(name, address, category);
                    }
                    } catch (Exception e){
                    	//do nothing, not posting
                    }
        %>

        <!-- The table for displaying all the movie records -->
        <table>
            <%
            	final ResultSet cs = handler.getAllCustomers();
                while(cs.next()) {
                    out.println("<tr><td>"+cs.getString("name")+": "+cs.getString("message")+"</td></tr>");
               }
            %>
          </table>
          <form action="index.jsp">
                   Name: <input type=text name=name>
                   Password: <input type=password name=address>
                   Message: <input type=text name=category>
                   <input type=submit value=Enter>
       	 </form>
        <form action="index.jsp" id="refresh">
                   <input type=submit value=refresh>
        </form>
    </body>
</html>

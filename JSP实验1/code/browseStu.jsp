<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"
%><%
	request.setCharacterEncoding("utf-8");
	String msg ="";
	int pgno = 0, pgcnt = 4;
	String tmp = request.getParameter("pgno");
	if (tmp	!= null && !tmp.isEmpty()) pgno = Integer.parseInt(tmp);
	tmp = request.getParameter("pgcnt");
	if (tmp != null && !tmp.isEmpty()) pgcnt = Integer.parseInt(tmp);
	int pgprev = (pgno > 0) ? pgno - 1 : 0;
	int pgnext = pgno + 1;
	String connectString = "jdbc:mysql://172.18.187.6:3306/teaching"
					+ "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8"; 
  StringBuilder table=new StringBuilder("");
	table.append("<table>");
	table.append("<tr><th>id</th><th>ѧ��</th><th>����</th><th>-</th></tr></tr>");
	try{
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con=DriverManager.getConnection(connectString, 
	                 "user", "123");
	  Statement stmt=con.createStatement();
	  ResultSet rs=stmt.executeQuery(String.format("select * from stu limit %d, %d", pgno * pgcnt, pgcnt));
		int cnt = 0;
		while(rs.next()) {
			cnt++;
			table.append("<tr>");
			table.append("<td>" + rs.getString("id") + "</td>");
			table.append("<td>" + rs.getString("num") + "</td>");
			table.append("<td>" + rs.getString("name") + "</td>");
			table.append("<td>" + "<a href='updateStu.jsp?pid=" + rs.getString("id") + "'>�޸�</a> " + "<a href='deleteStu.jsp?pid=" + rs.getString("id") + "'>ɾ��</a></td>");
			table.append("</tr>");
		}
		if (cnt < 4) {
			pgprev = (pgno > 0) ? pgno - 1 : 0;
			pgnext = pgno;
		}
	  rs.close();
	  stmt.close();
	  con.close();
	}
	catch (Exception e){
	  msg = e.getMessage();
		table.append(msg);
	}
	table.append("</table>");
%>
<!DOCTYPE HTML>
<html>
<head>
<style>
	td, th {
		border: solid 1px black;
		width: 15rem;
		height: 2rem;
	}
	a:link, a:visited {
		color: blue;
	}
	.container {
		margin: auto;
		width: 500px;
		text-align: center;
	}
	table {
		border-collapse: collapse;
	}
</style>
<title>���ѧ������</title>
</head>
<body>
  <div class="container">
	  <h1>���ѧ������</h1>  
	  <div><%=table%></div><br><br>  
		<div style="float:left">
			<a href="addStu.jsp">����</a>
		</div>
		<div style="float:right">
			<a href="browseStu.jsp?pgno=<%=pgprev%>&pgcnt=<%=pgcnt%>">��һҳ</a>
			<a href="browseStu.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>">��һҳ</a>
		</div>
  </div>
</body>
</html>

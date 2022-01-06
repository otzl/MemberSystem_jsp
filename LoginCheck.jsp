<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.net.ConnectException"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
		// login.html에서 입력된 id, pw값을 변수에 저장
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		// JDBC 연결을 통해서 로그인 기능 구현
		// JDBC(연결과정)
		// 1. OracleDriver 연결
		// 2. DB연결(Connection)
		// 3. 쿼리문 작성 & 실행
		// 4. DB연결종료 
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "hr";
		String password = "hr";

		Connection conn = DriverManager.getConnection(url, user, password);
		
		String sql = "select * from s_member where m_id=? and m_pw=?";
		
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		psmt.setString(2, pw);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			String nick = rs.getString("m_nick");// 또는 3(위치한 컬럼)
			
		      // URL주소창에 한글데이터 전달할 떄는
		      // URLEndcoder.encode(문자열데이터, 인코딩방식);
			
			response.sendRedirect("loginTrue.jsp?nick="+URLEncoder.encode(nick,"UTF-8"));
		}else{
			response.sendRedirect("loginFalse.jsp");
		}
		
		rs.close();
		psmt.close();
		conn.close();
		
		// if(conn == null) out.print("DB연결실패");
		// else out.print("DB연결성공");
		
	
		/* if(id.equals("smhrd") && pw.equals("1234")){
			response.sendRedirect("loginTrue.jsp?id="+id);
		}else{
			response.sendRedirect("loginFalse.jsp");
		} */
		
		
	%>
	
	
	
	
</body>
</html>
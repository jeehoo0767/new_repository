<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="User.userDAO" %> 
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트문을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 모든 데이터를 UTF-8로 받음 -->
<jsp:useBean id="User" class="User.User" scope="page" /> 
<!-- id="빈이름", class="패키지.클래스명", scope="유효범위" page = 현재의 페이지에서만 사용 -->

<jsp:setProperty name="User" property="userID" />
<!-- name="빈이름", property="필드명", value="값" -->

<jsp:setProperty name="User" property="userPassword" />
<!-- joinAction페이지는 아이뒤, 비밀번호 외에도 이름, 성별, 이메일을 입력받아야 하므로 추가한다.  -->

<jsp:setProperty name="User" property="userName" />
<jsp:setProperty name="User" property="userGender" />
<jsp:setProperty name="User" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판!!</title>
</head>
<body>

	
	<%
		if(User.getUserID() == null || User.getUserPassword() == null || User.getUserGender() == null  || User.getUserName() == null || User.getUserEmail() == null)
		{
		 PrintWriter script = response.getWriter();
		 script.println("<script>");
		 script.println("alert('Check The list!!!')");
		 script.println("history.back()"); 
		 script.println("</script>");
		}
		else
		{
			
		userDAO userDAO = new userDAO();
		int result = userDAO.join(User); //6~13라인에서의 각각의 값을 입력받은 user라는 인스턴스가 join 함수를 수행하도록 매개변수가 됨
		
		 if(result == -1)
		 {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('아이디가 이미 존재하네요~')");
			 script.println("history.back()"); //이전 페이지로 돌려보냄(join 페이지)
			 script.println("</script>"); 
		 }
		//DB를 생성할때 PRIMARY값으로 userID를 주었기 때문에, 동일한 아이뒤는 생성불가
		 
		 else 
		 {
			 session.setAttribute("userID", User.getUserID());
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("location.href = 'main.jsp'"); //회원가입이 된경우 => main.jsp 페이지로 이동
			 script.println("</script>");
		 }
		}
	%>
</body>
</html>
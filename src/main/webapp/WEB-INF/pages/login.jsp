<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/main.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <title>Форум</title>
</head>
<body>

<c:url value="/j_spring_security_check" var="loginUrl"/>

<div class="container">

    <form method="POST" action="${loginUrl}" class="form-signin">
        <h2 class="form-heading text-center">Войдите в свою учетную запись</h2>

        <div class="form-group ${error != null ? 'has-error' : ''}">
            <span>${message}</span>
            <input name="j_login" type="text" class="form-control" placeholder="Логин"
                   autofocus="true"/>
            <input name="j_password" type="password" class="form-control" placeholder="Пароль"/>
            <span>${error}</span>

            <button class="btn btn-lg btn-block btn-custom-purp" type="submit">Войти</button>
            <h4 class="text-center"><a href="/registration">Зарегистрироваться</a></h4>
        </div>

    </form>

</div>
<!-- /container -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>

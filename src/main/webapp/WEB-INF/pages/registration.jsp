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

<div class="container">

    <form:form method="POST" modelAttribute="userForm" cssClass="form-signin" >
        <h2 class="form-signin-heading text-center">Создайте вашу учетную запись</h2>
        <spring:bind path="login">
            <div class="form-group ${status.error ? 'has-error':''}">
                <form:input path="login" type="text" cssClass="form-control"  placeholder="Логин"
                            autofocus="true"></form:input>
                <form:errors path="login"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="password">
            <div class="form-group ${status.error ? 'has-error':''}">
                <form:input path="password" type="password" class="form-control" placeholder="Пароль" ></form:input>
                <form:errors path="password"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="confirmPassword">
            <div class="form-group ${status.error ? 'has-error':''}">
                <form:input path="confirmPassword" type="password" class="form-control"
                            placeholder="Подтвердите Ваш пароль"></form:input>
                <form:errors path="confirmPassword"></form:errors>
            </div>
        </spring:bind>
        <button class="btn btn-lg btn-block btn-custom-purp" type="submit">Зарегистрироваться</button>
        <h4 class="text-center"><a href="/login">Войти в уже созданную учетную запись</a></h4>
    </form:form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>

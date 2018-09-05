<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<security:authentication var="principal" property="principal"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/main.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/nav.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/header.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/footer.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <title>Форум</title>
</head>
<body>
<%@include file="/WEB-INF/pages/nav.jsp" %>
<%@include file="/WEB-INF/pages/header.jsp" %>

<div class="container">
<div class="col-lg-9">
    <form:form method="POST" modelAttribute="userForm" cssClass="form-group" >
        <h2 class="form-signin-heading">Обновите ваш пароль</h2>

        <spring:bind path="password">
            <div class="form-group ${status.error ? 'has-error':''} col-lg-4">
                <form:errors path="login"></form:errors>
                <form:input path="password" type="password" class="form-control" placeholder="Пароль" ></form:input>
                <form:errors path="password"></form:errors>

            </div>
        </spring:bind>

        <spring:bind path="confirmPassword">
            <div class="form-group ${status.error ? 'has-error':''} col-lg-4">
                <form:input path="confirmPassword" type="password" class="form-control"
                            placeholder="Подтвердите Ваш пароль"></form:input>
                <form:errors path="confirmPassword"></form:errors>
            </div>
        </spring:bind>
        <div class="col-sm-2">
        <button class="btn btn-block btn-custom-purp" type="submit">Обновить</button>
        </div>
    </form:form>
</div>
</div>


<%@include file="/WEB-INF/pages/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>


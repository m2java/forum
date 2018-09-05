<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
    <div class="row">
        <h2>Создайте новый раздел</h2>
    </div>
    <form:form method="POST" action="/newsection" modelAttribute="sectionForm" cssClass="form-horizontal">
        <spring:bind path="name">
            <div class="form-group ${status.error ? 'has-error':''}">
                <label class="col-sm-2 control-label" for="formGroupInputSection">Название раздела</label>
                <div class="col-sm-10">
                    <form:input path="name" type="text" class="form-control" id="formGroupInputSection"
                                plaseholder="Название раздела" autofocus="true"></form:input>
                    <form:errors path="name"></form:errors>
                </div>
            </div>
        </spring:bind>
        <div class="col-sm-10 col-sm-offset-2">
            <button type="submit" class="btn btn-custom-purp">Создать</button>
        </div>
    </form:form>
</div>

<%@include file="/WEB-INF/pages/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>

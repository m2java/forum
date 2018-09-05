<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <h2>Создайте новую тему</h2>
    </div>

    <form class="form-horizontal" action="/newtopic" method="POST">
        <div class="form-group">
            <label class="col-sm-2 control-label" for="formGroupInputSection">Выберете раздел</label>
            <div class="col-sm-2">
            <select class="form-control" name="sectionname" id="formGroupInputSection">
                <option disabled>Выберите раздел</option>
                <c:forEach items="${sections}" var="section">
                    <option value=${section.id}><c:out value="${section.name}"/></option>
                </c:forEach>
            </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="formGroupInputTopic">Название темы</label>
            <div class="col-sm-10">
                <input class="form-control" name="topicname" id="formGroupInputTopic" placeholder="Название темы">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="formGroupInputText">Текст темы</label>
            <div class="col-sm-10">
                <textarea name="text" class="form-control textarea" rows="20" id="formGroupInputText"></textarea>
            </div>
        </div>
        <div class="col-sm-10 col-sm-offset-2">
            <button type="submit" class="btn btn-custom-purp">Создать</button>
            <button type="reset" class="btn btn-custom-purp">Очистить</button>
        </div>
    </form>
</div>

<%@include file="/WEB-INF/pages/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>

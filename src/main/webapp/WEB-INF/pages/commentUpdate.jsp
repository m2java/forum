<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="commentsSize" value="${fn:length(comments)}"/>
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
    <div class="col-lg-9 article">
        <div class="article-info">
            <span><a href="/section/${topic.section.id}"><c:out value="${topic.section.name}"/></a></span>
            <span><fmt:formatDate value="${topic.dateTime}" pattern="dd/MM/yyy HH:mm"/></span>
            <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
            <span><c:out value="${topic.views}"/></span>
            <a href="/users/${topic.author.login}">
                <img alt="Person" src="https://www.gravatar.com/avatar/${topic.author.avatarHash}?s=40&d=identicon">
                <c:out value="${topic.author.login}"/>
            </a>
        </div>
        <div class="article-header">
            <h2><c:out value="${topic.name}"/></h2>
        </div>
        <div class="article-text">
            ${topic.text}
        </div>

        <div class="comments">
            <h3>Комментарии <span class="glyphicon glyphicon-comment" aria-hidden="true"></span> ${commentsSize}</h3>
            <hr/>
                <form action="/topic/${topic.id}/comment/${comment.id}/update" method="post" class="form-horizontal">
                    <textarea name="text" class="form-control" rows="3" style="margin:5px">${comment.text}</textarea>
                    <button class="btn btn-lg btn-custom-org">Оставить комментарий</button>
                </form>
        </div>
        <div>
            <c:forEach items="${comments}" var="comment">
                <div class="comment-info">
                    <a href="/users/${comment.author.login}">
                        <img alt="Person" src=https://www.gravatar.com/avatar/${topic.author.avatarHash}?s=40&d=identicon">
                        <c:out value="${comment.author.login}"/>
                    </a>
                    <span><fmt:formatDate value="${comment.dateTime}" pattern="dd/MM/yyy HH:mm"/></span>
                </div>
                <div class="comment-text">
                        ${comment.text}
                </div>
            </c:forEach>
        </div>
    </div>
    <%@include file="/WEB-INF/pages/sidebar.jsp" %>
</div>

<%@include file="/WEB-INF/pages/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>


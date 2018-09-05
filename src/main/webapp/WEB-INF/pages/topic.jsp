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
    <link href="${contextPath}/resources/css/topic.css" rel="stylesheet">
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
                <img alt="Person" src="https://www.gravatar.com/avatar/${topic.author.avatarHash}?s=20&d=identicon">
                <c:out value="${topic.author.login}"/>
            </a>
        </div>
        <div class="article-header">
            <b><c:out value="${topic.name}"/></b>
        </div>
        <br/>
        <div align="justify" class="article-text">
            ${topic.text}
        </div>
        <hr/>
        <div class="comments">
            <h4>Комментарии <span class="glyphicon glyphicon-comment" aria-hidden="true"></span> ${page.content.size()}</h4>

            <security:authorize access="isAuthenticated()">
                <form action="/topic/${topic.id}/comments" method="post" class="form-horizontal">
                    <textarea name="text" class="form-control" rows="3" style="margin:5px"></textarea>
                    <button class="btn btn-lg btn-custom-org">Оставить комментарий</button>
                </form>
            </security:authorize>
        </div>

        <div id="com">
            <c:forEach items="${page.content}" var="comment">
                <div id=${comment.id} class="comment-info">
                    <a href="/users/${comment.author.login}">
                        <img alt="Person" src="https://www.gravatar.com/avatar/${comment.author.avatarHash}?s=40&d=identicon">
                        <c:out value="${comment.author.login}"/>
                    </a>
                    <span class="pull-right date"><fmt:formatDate value="${comment.dateTime}" pattern="dd/MM/yyy HH:mm"/></span>
                </div>
                <div class="comment-text">
                   ${comment.text}
                </div>
            </c:forEach>
        </div>
        <!-- .pagination-->
        <c:if test="${page.totalPages>1}">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item ${page.number==0 ? 'disabled' : ''}">
                        <a class="page-link" href="/topic/${topic.id}/?page=0#com" role="button">&lt;&lt;</a></li>
                    <li class="page-item ${page.hasPrevious() ? '' : 'disabled'}">
                        <a class="page-link" href="/topic/${topic.id}/?page=${page.number-1}#com">&lt;</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${page.totalPages}">
                        <li class="page-item ${page.number==i-1 ? 'active' : ''}">
                            <a href="/topic/${topic.id}/?page=${i - 1}#com"> <c:out value="${i}"/></a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${page.hasNext() ? '' : 'disabled'}">
                        <a class="page-link" href="/topic/${topic.id}/?page=${page.number+1}#com">&gt;</a>
                    </li>
                    <li class="page-item ${page.number!=page.totalPages-1 ? '' : 'disabled'}">
                        <a class="page-link" href="/topic/${topic.id}/?page=${page.totalPages-1}#com">&gt;&gt;</a>
                    </li>
                </ul>
            </nav>
        </c:if>
        <!--/ .pagination-->
    </div>
    <%@include file="/WEB-INF/pages/sidebar.jsp" %>
</div>

<%@include file="/WEB-INF/pages/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>

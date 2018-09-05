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
    <link href="${contextPath}/resources/css/index.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/nav.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/footer.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/header.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <link rel="icon" href="${contextPath}/resources/img/icon.ico">
    <title>Форум</title>
</head>
<body>
<%@include file="/WEB-INF/pages/nav.jsp" %>
<%@include file="/WEB-INF/pages/header.jsp" %>
<div class="container">

    <div class="row">

        <div class="col-lg-6 main">
            <div class="dropup">
                <button class="btn btn-sm btn-custom-purp dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                    Все разделы форума
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                    <li><a href="/">Все разделы</a></li>
                    <c:forEach items="${sections}" var="section">
                        <li><a href="/section/${section.id}"><c:out value="${section.name}"/></a></li>
                    </c:forEach>
                </ul>
            </div>
            <c:forEach items="${page.content}" var="topic">
                <div class="article">
                    <div class="info">
                        <a href="/users/${topic.author.login}">
                            <c:out value="${topic.author.login}"/>
                            <img alt="Person"
                                 src="https://www.gravatar.com/avatar/${topic.author.avatarHash}?s=40&d=identicon">
                        </a>
                    </div>
                    <div class="article-name">
                        <a href="/topic/${topic.id}"><c:out value="${topic.name}"/></a>
                    </div>
                    <div class="more">
                        <a href="/section/${topic.section.id}"> <c:out value="${topic.section.name}"/></a>
                        <fmt:formatDate value="${topic.dateTime}" pattern="dd/MM/yyyy HH:mm"/>
                        <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
                        <c:out value="${topic.views}"/>
                    </div>
                </div>
                <!-- /.article -->
            </c:forEach>
            <!-- .pagination-->
            <c:if test="${page.totalPages>1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li class="page-item ${page.number==0 ? 'disabled' : ''}"><a class="page-link" href="/?page=0"
                                                                                     role="button">&lt;&lt;</a></li>
                        <li class="page-item ${page.hasPrevious() ? '' : 'disabled'}"><a class="page-link"
                                                                                         href="/?page=${page.number-1}">&lt;</a>
                        </li>
                        <c:forEach var="i" begin="1" end="${page.totalPages}">
                            <li class="page-item ${page.number==i-1 ? 'active' : ''}"><a
                                    href="/?page=<c:out value="${i - 1}"/>"><c:out
                                    value="${i}"/></a></li>
                        </c:forEach>
                        <li class="page-item ${page.hasNext() ? '' : 'disabled'}"><a class="page-link"
                                                                                     href="/?page=${page.number+1}">&gt;</a>
                        </li>
                        <li class="page-item ${page.number!=page.totalPages-1 ? '' : 'disabled'}"><a class="page-link"
                                                                                                     href="/?page=${page.totalPages-1}">&gt;&gt;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
            <!--/ .pagination-->
        </div><!-- /.main -->

        <div class="col-lg-3 first-sidebar">
            <div class="sidebar-header">
                <b>Комментарии</b>
            </div>
            <div class="sidebar-comments">
                <c:forEach items="${comments}" var="comment">
                    <div class="talk-bubble tri-right round btm-left">
                        <div class="talktext">
                            <a href="/topic/${comment.topic.id}#${comment.id}">
                                    ${comment.text}
                            </a>
                        </div>
                    </div>
                    <div class="date-a">
                        <a href="/users/${comment.author.login}">
                            <img alt="Person" src="https://www.gravatar.com/avatar/${comment.author.avatarHash}?s=10&d=identicon">  ${comment.author.login}
                        </a>
                        <fmt:formatDate value="${comment.dateTime}" pattern="dd/MM/yyyy HH:mm"/>
                    </div>
                </c:forEach>
            </div>
        </div><!-- /.first-sidebar -->

        <%@include file="/WEB-INF/pages/sidebar.jsp" %>

    </div><!-- /.row -->

</div><!-- /.container -->

<%@include file="/WEB-INF/pages/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $(".pagination li.disabled a").click(function () {
            return false;
        });
    });</script>
</body>
</html>

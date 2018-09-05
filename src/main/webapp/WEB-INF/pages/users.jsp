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
    <link href="${contextPath}/resources/css/userinfo.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/nav.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/footer.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/header.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <title>Форум</title>
</head>
<body>
<%@include file="/WEB-INF/pages/nav.jsp" %>
<%@include file="/WEB-INF/pages/header.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-lg-9">
            <c:forEach items="${page.content}" var="user">
                <div class="user-info">
                    <a href="/users/${user.login}">
                        <img alt="Person" src="https://www.gravatar.com/avatar/${user.avatarHash}?s=40&d=identicon">
                        <c:out value="${user.login}"/>
                    </a>
                </div>

            </c:forEach>
            <!-- .pagination-->
            <c:if test="${page.totalPages>1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li class="page-item ${page.number==0 ? 'disabled' : ''}">
                            <a class="page-link" href="/users?page=0" role="button">&lt;&lt;</a></li>
                        <li class="page-item ${page.hasPrevious() ? '' : 'disabled'}">
                            <a class="page-link" href="/users?page=${page.number-1}">&lt;</a>
                        </li>
                        <c:forEach var="i" begin="1" end="${page.totalPages}">
                            <li class="page-item ${page.number==i-1 ? 'active' : ''}">
                                <a href="/users?page=${i - 1}"> <c:out value="${i}"/></a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${page.hasNext() ? '' : 'disabled'}">
                            <a class="page-link" href="/users?page=${page.number+1}">&gt;</a>
                        </li>
                        <li class="page-item ${page.number!=page.totalPages-1 ? '' : 'disabled'}">
                            <a class="page-link" href="/users?page=${page.totalPages-1}">&gt;&gt;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
            <!--/ .pagination-->
        </div><!-- /.main -->
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


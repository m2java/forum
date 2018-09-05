<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
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
    <link href="${contextPath}/resources/css/profile.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/footer.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <title>Форум</title>
</head>
<body>
<%@include file="/WEB-INF/pages/nav.jsp" %>
<%@include file="/WEB-INF/pages/header.jsp" %>
<div class="container">
    <h2>Изменение роли пользователей</h2>
    <p>Выберете роль для пользователя</p>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Логин</th>
            <th>Роль</th>
            <th>Изменить роль</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.content}" var="user">
        <tr>
            <td>${user.login}</td>
            <td>
                <c:if test="${user.role=='ADMIN'}">Админ</c:if>
                <c:if test="${user.role=='MODERATOR'}">Модератор</c:if>
                <c:if test="${user.role=='USER'}">Пользователь</c:if>
            </td>
            <td>
                <form action="/admin/update/${user.login}" method="POST">
                    <div class="form-group col-lg-6">
                        <select class="form-control" name="role">
                            <option value="admin">Админ</option>
                            <option value="moderator">Модератор</option>
                            <option value="user">Пользователь</option>
                        </select>
                    </div>
                    <button class="btn btn btn-custom-org"><i
                            class="glyphicon glyphicon-knight"></i></button>
                </form>
            </td>
        </tr>
        </c:forEach>
    </table>
    <!-- .pagination-->
    <c:if test="${page.totalPages>1}">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li class="page-item ${page.number==0 ? 'disabled' : ''}">
                    <a class="page-link" href="/admin?page=0" role="button">&lt;&lt;</a></li>
                <li class="page-item ${page.hasPrevious() ? '' : 'disabled'}">
                    <a class="page-link" href="/admin?page=${page.number-1}">&lt;</a>
                </li>
                <c:forEach var="i" begin="1" end="${page.totalPages}">
                    <li class="page-item ${page.number==i-1 ? 'active' : ''}">
                        <a href="/admin?page=${i - 1}"> <c:out value="${i}"/></a>
                    </li>
                </c:forEach>
                <li class="page-item ${page.hasNext() ? '' : 'disabled'}">
                    <a class="page-link" href="/admin?page=${page.number+1}">&gt;</a>
                </li>
                <li class="page-item ${page.number!=page.totalPages-1 ? '' : 'disabled'}">
                    <a class="page-link" href="/admin?page=${page.totalPages-1}">&gt;&gt;</a>
                </li>
            </ul>
        </nav>
    </c:if>
    <!--/ .pagination-->
</div>

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

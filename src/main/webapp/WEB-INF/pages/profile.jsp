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
    <div class="row">
        <div class="col-md-5  toppad  pull-right col-md-offset-3 ">
        </div>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad">
            <div class="panel panel-info">
                <div class="panel-heading panel-heading-height">
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3 col-lg-3 " align="center">
                            <img alt="User Pic"
                                 src="https://www.gravatar.com/avatar/${principal.avatarHash}?s=40&d=identicon"
                                 class="img-responsive"></div>
                        <div class=" col-md-9 col-lg-9 ">
                            <table class="table table-user-information">
                                <tbody>
                                <tr>
                                    <td>Логин:</td>
                                    <td><c:out value="${user.login}"/></td>
                                </tr>
                                <tr>
                                    <td>Звание:</td>
                                    <td><c:out value="${title}"/></td>
                                </tr>
                                </tbody>
                            </table>
                            <a href="${user.login}/topics" class="btn btn-custom-purp">Мои темы</a>
                            <a href="${user.login}/comments" class="btn btn-custom-purp">Мои коментарии</a>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <%--<a type="button" class="btn btn-sm btn-custom-purp"><i class="glyphicon glyphicon-envelope"></i></a>--%>

                    <form id="panel-footer-form" action="/users/${user.login}/delete" method="POST">
                        <a type="button" class="btn btn-sm btn-custom-org" href="/users/${user.login}/update"><i
                                class="glyphicon glyphicon-edit"></i></a>
                        <button class="btn btn-sm btn-danger pull-right"><i
                                class="glyphicon glyphicon-remove"></i></button>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/pages/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>

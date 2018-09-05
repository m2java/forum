<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<security:authentication var="principal" property="principal"/>
<nav class="navbar navbar-fixed-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand " href="/">
                <img class="img-responsive" alt="Forum" src="../../resources/img/canva-photo-editor.png">
            </a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <security:authorize access="hasAnyRole('ADMIN', 'MODERATOR')">
                    <li><a href="/newsection">Создать раздел</a></li>
                </security:authorize>
                <li><a href="/newtopic">Создать тему</a></li>
                <li><a href="/comments">Последнии комментарии</a></li>
                <security:authorize access="hasRole('ADMIN')" var="isAdmin" />
                <c:choose>
                    <c:when test="${isAdmin}">
                        <li><a href="/admin">Роли пользователей</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/users">Пользователи</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <security:authorize access="isAuthenticated()">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle navbar-avatar" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false">
                            <img  alt="person" src="https://www.gravatar.com/avatar/${principal.avatarHash}?s=30&d=identicon">
                            <span class="caret"></span></a>
                        </a>
                        <ul class="dropdown-menu">
                            <li role="presentation" class="dropdown-header">Вы вошли как ${principal.username}</li>
                            <li><a href="/users/${principal.username}">Детали учетной записи</a></li>
                            <li><a href="/users/${principal.username}/update">Редактировать учетную запись</a></li>
                            <li class="divider"></li>
                            <li>
                                <div class="text-center">
                                <button type="button" class="btn btn-custom-org"
                                        onclick="window.location.href='/logout'">Выйти
                                </button>
                                </div>
                            </li>
                        </ul>
                    </li>
                </security:authorize>
                <security:authorize access="isAnonymous()">
                    <li>
                        <button type="button" class="btn navbar-btn btn-custom-org"
                                onclick="window.location.href='/registration'">Регистрация
                        </button>
                    </li>
                    <li>
                        <button type="button" class="btn navbar-btn btn-custom-org"
                                onclick="window.location.href='/login'">Вход
                        </button>
                    </li>
                </security:authorize>
            </ul>
            <form class="navbar-form navbar-right" action="/search" method="GET">
                <div class="form-group">
                    <input type="text" class="form-control" name="text" placeholder="Поиск">
                </div>
                <button type="submit" class="btn btn-default">Поиск</button>
            </form>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

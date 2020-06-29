<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>testKim</title>
    <!-- Bootstrap 4 -->
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-sm bg-light navbar-light shadow">
        <form:form action="/nobody-can-quit/testKim/addressSearch.do" modelAttribute="addressInputCommand" 
        class="form-inline">
            <form:select path="city" onChange="this.form.submit()" class="form-control mr-sm-3">
                <option value=""><spring:message code="search.addressLevel1.title"/></option>
                <form:options items="${cityList.cityName}" />
            </form:select>
            <form:select path="gu" onChange="this.form.submit()" class="form-control mr-sm-3">
                <option value=""><spring:message code="search.addressLevel2.title"/></option>
                <c:if test="${! empty addressCommand.resultList}">
                    <form:options items="${addressCommand.resultList}" itemLabel="name" itemValue="code" />
                </c:if>
            </form:select>
            <form:select path="dong"  class="form-control mr-sm-3">
                <option value=""><spring:message code="search.addressLevel3.title"/></option>
                <c:if test="${! empty addressForDongCommand.resultList}">
                    <form:options items="${addressForDongCommand.resultList}" itemLabel="name" itemValue="code" />
                </c:if>
            </form:select>
            <button class="btn btn-success" type="submit"><spring:message code="common.search.title"/></button>
            <c:if test="${! empty addressInputCommand.dong}">
                <h4>${addressInputCommand.dong}</h4>
            </c:if>
            <c:if test="${! empty test}">
                <h4>${test}</h4>
            </c:if>
        </form:form>
    </nav>

    <!-- 시군구별 실시간 평균정보 조회 조회	 -->
    <h3>미세먼지 일평균 일주일</h3>
    <br />
    시/군/구 이름:${dustAreaAddr.dustArea[0].cityName}
    <br />
    지역이름:${dustAreaAddr.dustArea[0].sidoName}
    <br />
    pm10미세먼지:${dustAreaAddr.dustArea[0].pm10Value}
    <br />

    <!-- MainController 알고리즘 -->
    <h4>BackEnd</h4>
    sidoName:${sidoName} cityName:${cityName} pm10:${pm10}

    <h5>검색결과</h5>
    <c:forEach items="${dustAreaAddr.dustArea}" var= "dustArea" varStatus="status">
        ${status.count}.시/군/구 이름:${dustArea.cityName}
        <c:if test="${! empty dustArea.cityName}">
        <!-- 사용자 구 검색 결과  -->
            <h5>
                인덱스 : ${status.count}
                미세먼지 : ${dustArea.pm10Value}
            </h5>
        </c:if>
        <br />
    </c:forEach>

</body>
</html>
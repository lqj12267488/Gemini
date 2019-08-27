<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/9/1
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <input id="year" name="year" type="hidden" value="${year}">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <table class="table table-bordered table-striped table-hover text-center" style="width: 90%;margin: auto;">
                                <caption><h2><strong>历年招生统计</strong></h2></caption>
                                <tbody>

                                <tr>
                                    <td>专业/年份</td>
                                    <c:forEach items="${yearList}" var="y">
                                        <c:if test="${y.dicname<=year}">
                                            <td>${y.dicname}</td>
                                        </c:if>


                                    </c:forEach>

                                </tr>

                                <%--<c:if test="${list== null || fn:length(list) == 0}">
                                </c:if>--%>
                                <c:forEach items="${list}" var="t">
                                    <tr>
                                        <td>${t.majorShow}</td>
                                        <!--2020-->
                                        <c:if test="${t.twentyNumber!= null}">
                                            <td>${t.twentyNumber}</td>
                                        </c:if>
                                        <!--2019-->
                                        <c:if test="${t.nineteenNumber!= null}">
                                            <td>${t.nineteenNumber}</td>
                                        </c:if>
                                        <!--2018-->
                                        <c:if test="${t.eigthteenNumber!= null}">
                                            <td>${t.eigthteenNumber}</td>
                                        </c:if>
                                        <!--2017-->
                                        <c:if test="${t.seventeenNumber!= null}">
                                            <td>${t.seventeenNumber}</td>
                                        </c:if>
                                        <!--2016-->
                                        <c:if test="${t.sixteenNumber!= null}">
                                            <td>${t.sixteenNumber}</td>
                                        </c:if>
                                        <!--2015-->
                                        <c:if test="${t.fiveteenNumber!= null}">
                                            <td>${t.fiveteenNumber}</td>
                                        </c:if>
                                        <!--2014-->
                                        <c:if test="${t.fourteenNumber!= null}">
                                            <td>${t.fourteenNumber}</td>
                                        </c:if>

                                    </tr>

                                </c:forEach>


                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
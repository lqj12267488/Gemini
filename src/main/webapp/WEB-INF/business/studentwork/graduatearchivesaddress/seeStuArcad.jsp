<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/8/30
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
                <div class="form-row">
                    <div class="col-md-12">
                        <span>档案地址： ${addr}</span>
                    </div>
                </div>
            <c:if test='${stuArcadList.get(0).studentName != null}'>
                <ul class="list-group">
                    <c:forEach items="${stuArcadList}" var="index">
                    <li class="list-group-item">${index.studentName}</li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

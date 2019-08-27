<%--新闻稿发布管理办理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/20
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/newsDraft/printNewsDraft?id=${newsDraft.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        拟稿部门
    </div>
    <div class="col-md-9">
        <input id="n_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${newsDraft.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        拟稿人
    </div>
    <div class="col-md-9">
        <input id="n_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${newsDraft.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        拟稿时间
    </div>
    <div class="col-md-9">
        <input id="n_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${newsDraft.requestDate}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        标题
    </div>
    <div class="col-md-9">
        <input id="n_newsTitle" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${newsDraft.newsTitle}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        内容
    </div>
    <div class="col-md-9">
        <input id="n_newsContent" type="text" style="height: 300px"
               class="validate[required,maxSize[1000]] form-control"
               value="${newsDraft.newsContent}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        核稿人
    </div>
    <div class="col-md-9">
        <select  id="n_auditor" disabled="disabled"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        新闻稿类型
    </div>
    <div class="col-md-9">
        <select  id="n_newsType" disabled="disabled"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="n_remark"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${newsDraft.remark}</textarea>
    </div>
</div>
<input id="n_id" hidden value="${newsDraft.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/newsDraft/getDeptPerson", function (data) {
            addOption(data, 'n_auditor','${newsDraft.auditor}');
    });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XWGLX", function (data) {
            addOption(data, 'n_newsType','${newsDraft.newsType}');
    });
})
</script>

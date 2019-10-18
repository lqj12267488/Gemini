
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="h_id" hidden value="${reportManagement.id}">

<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requestEr" type="text" class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row" id="s_dept">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row" id="classSel" hidden>
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <input id="reClass" type="text" class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="text" class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.requestDate}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申诉内容
    </div>
    <div class="col-md-9">
        <input id="rcProjectName" type="text" class="validate[required,maxSize[100]] form-control"
               value="${reportManagement.reportContent}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申诉类型
    </div>
    <div class="col-md-9">
        <select id="l_request" disabled="disabled"/>
    </div>
</div>



<input id="printFunds" hidden value="<%=request.getContextPath()%>/reportManagement/print?id=${reportManagement.id}">

<script>

    $(document).ready(function () {

        if ('${reportManagement.studentTeacherType}' == '0') {
            $("#classSel").show();
            $("#s_dept").hide();
        }else{
            $("#s_dept").show();
            $("#classSel").hide();
        }

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SSLX", function (data) {
            addOption(data, 'l_request','${reportManagement.reportType}');
        });
        /*隐藏首页代办已办中打印按钮*/
        //$("#dayin").show();
      /*  if ($("#l_request").val() == '普通'){
            $("#nameSel").show();
            $("#nameSel1").hide();
        } else {
            $("#nameSel").hide();
            $("#nameSel1").show();
        }*/
    })

</script>

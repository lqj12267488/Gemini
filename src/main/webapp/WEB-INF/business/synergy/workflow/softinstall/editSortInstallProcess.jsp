<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input type="hidden" id="softid" value="${softinstall.id}">
<div class="controls">
    <div class="form-row">
        <div class="col-md-3 tar">
            软件名称
        </div>
        <div class="col-md-9">
            <input id="softName" type="text"
                   class="validate[required,maxSize[20]] form-control"
                   value="${softinstall.softName}" readonly="readonly"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            申请人
        </div>
        <div class="col-md-9">
            <input id="f_requestEr" type="text"
                   class="validate[required,maxSize[100]] form-control"
                   value="${softinstall.requester}" readonly="readonly"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            申请部门
        </div>
        <div class="col-md-9">
            <input id="f_requestDept" type="text"
                   class="validate[required,maxSize[100]] form-control"
                   value="${softinstall.requestDept}" readonly="readonly"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            申请日期
        </div>
        <div class="col-md-9">
            <input id="f_requestDate" type="datetime-local"
                   class="validate[required,maxSize[100]] form-control"
                   value="${softinstall.requestDate}" readonly="readonly"/>
        </div>
    </div>
    <div class="form-row">
        <div class="col-md-3 tar">
            安装机房及原因
        </div>
        <div class="col-md-9">
                        <textarea id="f_reason" readonly="readonly"
                                  class="validate[required,maxSize[100]] form-control"
                                  style="height: 100px"
                                  value="${softinstall.reason}">${softinstall.reason}</textarea>
        </div>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/softInstall/printSoftInstall?id=${softinstall.id}">

<script>
    function save() {
        if ($("#softName").val() == "" || $("#softName").val() == "0" || $("#softName").val() == undefined) {
            swal({
                title: "请填写软件名称",
                type: "info"
            });
            //alert("请填写软件名称");
            return;
        }
        /*if ($("#f_requestEr").val() == "" || $("#f_requestEr").val() == "0" || $("#f_requestEr").val() == undefined) {
            swal({
                title: "请填写申请人",
                type: "info"
            });
            //alert("请填写申请人");
            return;
        }
        if ($("#f_requestDept").val() == "" || $("#f_requestDept").val() == "0" || $("#f_requestDept").val() == undefined) {
            swal({
                title: "请填写申请部门",
                type: "info"
            });
            //alert("请填写申请部门");
            return;
        }*/
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            swal({
                title: "请填写申请日期",
                type: "info"
            });
            //alert("请填写申请日期");
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            swal({
                title: "请填写安装机房及原因",
                type: "info"
            });
            //alert("请填写申请理由");
            return;
        }
        var c_requestDate = $("#f_requestDate").val().replace('T', ' ');
        $.post("<%=request.getContextPath()%>/softInstall/updateSoftById", {
            id: $("#softid").val(),
            softName: $("#softName").val(),
            requester: $("#f_requestEr").val(),
            requestDept: $("#f_requestDept").val(),
            requestDate: c_requestDate,
            reason: $("#f_reason").val()

        })
    }

</script>

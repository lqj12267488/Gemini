<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请部门
    </div>
    <div class="col-md-9">
        <input id="n_createDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${notice.createDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请人
    </div>
    <div class="col-md-9">
        <input id="n_creator"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${notice.creator}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请日期
    </div>
    <div class="col-md-9">
        <input id="n_publicTime" type="text"
               class="validate[required,maxSize[100]] form-control"
               readonly="readonly"
               value="${notice.publicTime}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        标题
    </div>
    <div class="col-md-9">
        <input id="n_title" type="text"
               class="validate[required,maxSize[100]] form-control"
               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
               maxlength="30" placeholder="最多输入30个字"
               value="${notice.title}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        类型
    </div>
    <div class="col-md-9">
        <select id="n_type"/>
        <%--<input
               class="validate[required,maxSize[100]] form-control"
               value="${notice.typeShow}"/>--%>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        内容
    </div>
    <div class="col-md-9">
        <input id="n_content" type="text"
               class="validate[required,maxSize[100]] form-control" maxlength="665" placeholder="最多输入665个字"
               value="${notice.content}"/>
    </div>
</div>
<input id="n_Id" hidden value="${notice.id}"/>
<input id="workflowCode" hidden value="T_SYS_NOTICE_WF">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/notice/printNotice?id=${notice.id}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GGLX", function (data) {
            addOption(data, "n_type","${notice.type}");
        })
    })
    function save() {
        var title = $("#n_title").val();
        var type = $("#n_type option:selected").val();
        //var publicTime = $ ("# publicTime").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var content = $("#n_content").val();
        if (!title == '' || !title == undefined || !title == null) {
            if (title.indexOf(" ") !=-1 || title.indexOf("/")!=-1 || title.indexOf("@")!=-1){
                swal({
                    title: "标题中不可包含特殊符号。例如[空格]、[/]、[@]等！",
                    type: "info"
                });
                //alert("标题中不可包含特殊符号。例如[空格]、[/]、[@]等！");
                return;
            }

        }else{
            swal({
                title: "请填写标题",
                type: "info"
            });
            //alert("请填写标题！");
            return;
        }
        if (type == '' || type == undefined || type == null) {
            swal({
                title: "请选择类型",
                type: "info"
            });
            //alert("请选择类型！");
            return;
        }
        if ($("#n_content").val() == '' || $("#n_content").val() == undefined || $("#n_content").val() == null) {
            swal({
                title: "请填写内容",
                type: "info"
            });
            //alert("请选择类型！");
            return ;
        }
        $.post("<%=request.getContextPath()%>/saveNotice",{
            id: $("#n_Id").val(),
            title: title,
            type: type,
            content:content
        }, function (msg) {
            if (msg.status == 1) {
                /*swal({
                    title: msg.msg,
                    type: "success"
                });*/
                //alert(msg.msg)
                $("#dialog").modal("hide");
                noticeTable.ajax.reload();

            }
        })
        return true;
    }
</script>



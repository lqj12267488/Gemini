<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/28
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<div class="modal-dialog" style="width: 60%">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeToProcess()">
                &times;
            </button>
            <span style="font-size: 14px">礼堂使用规范</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        使用规范名称：
                    </div>
                    <div class="col-md-9">
                        <input id="standardName" type="text" readonly="readonly"
                               class="validate[required,maxSize[50]] form-control"
                               value="礼堂使用规范"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        使用规范内容：
                    </div>
                    <div class="col-md-9">
                        <textarea id="standardContent" style="height: 500px"
                                  maxlength="1330" placeholder="最多输入1330个字"
                                  class="validate[required,maxSize[2000]] form-control">${standard.standardContent}</textarea>
                    </div>
                </div>

                <%--<div class="form-row">--%>
                <%--<div class="col-md-3 tar">--%>
                <%--撰写人：--%>
                <%--</div>--%>
                <%--<div class="col-md-9">--%>
                <%--<input id="changer" type="text"--%>
                <%--class="validate[required,maxSize[100]] form-control"--%>
                <%--value="${standard.changer}" readonly="readonly"/>--%>
                <%--</div>--%>
                <%--</div>--%>

                <%--<div class="form-row">--%>
                <%--<div class="col-md-3 tar">--%>
                <%--撰写部门：--%>
                <%--</div>--%>
                <%--<div class="col-md-9">--%>
                <%--<input id="changeDept" type="text"--%>
                <%--class="validate[required,maxSize[100]] form-control"--%>
                <%--value="${standard.changeDept}" readonly="readonly"/>--%>
                <%--</div>--%>
                <%--</div>--%>

                <%--<div class="form-row">--%>
                <%--<div class="col-md-3 tar">--%>
                <%--撰写时间：--%>
                <%--</div>--%>
                <%--<div class="col-md-9">--%>
                <%--<input id="changeTime" type="datetime-local"--%>
                <%--class="validate[required,maxSize[100]] form-control"--%>
                <%--value="${standard.changeTime}" readonly/>--%>
                <%--</div>--%>
                <%--</div>--%>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">
                保存</button>
            <button type="button" class="btn btn-default btn-clean" onclick="clearContent()">
                清空</button>
        </div>
    </div>
</div>
<input id="id" hidden value="${standard.id}">
<input id="standardType" hidden value="${standard.standardType}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    function save(){
        $.post("<%=request.getContextPath()%>/hallUse/standardSave", {
            id:$("#id").val(),
            standardType:"1",
            standardName:$("#standardName").val(),
            standardContent:$("#standardContent").val(),
        }, function (msg) {
            hideSaveLoading();
//          保存后刷新页面数据表
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#right").load("<%=request.getContextPath()%>/hallUse/standardEdit");
            }
        })
        showSaveLoading();
    }
    function clearContent(){
        //if (confirm("确认是否清空当前使用规范？")) {
        swal({
            title: "确认是否清空当前使用规范？",
            //text: "评教方案名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "清空",
            closeOnConfirm: false
        })
            $("#standardContent").val("");
    }
    function closeToProcess() {
        swal({
            title: "确认关闭并跳转至待办事项？",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: true
        },function () {
            $("#right").load("<%=request.getContextPath()%>/hallUse/process");
        })
    }
</script>
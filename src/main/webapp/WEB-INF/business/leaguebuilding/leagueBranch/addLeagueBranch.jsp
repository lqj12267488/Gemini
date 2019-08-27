<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="id" hidden value="${id}">
<input id="pId" hidden value="${pId}">
<div class="col-md-12">
    <div class="block block-drop-shadow">
        <div class="header">
            <span style="font-size: 14px">${name}</span>
        </div>
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
        <div class="content controls" style="height: 80%">
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span> 团组织名称
                </div>
                <div class="col-md-9">
                    <input id="branchName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="10" placeholder="最多输入10个字"
                           class="validate[required,maxSize[8]] form-control"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    备注
                </div>
                <div class="col-md-9">
                    <textarea id="remark" class="validate[required,maxSize[8]] form-control"> </textarea>
                </div>
            </div>
            <div class="form-row">
                <div style="text-align: center">
                    <button class="btn btn-default btn-clean" onclick="saveLeagueBranch()">保存</button>
                    <button class="btn btn-default btn-clean" onclick="deptObjhide()">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function saveLeagueBranch() {
        if ($("#branchName").val() == ""  || $("#branchName").val() == null) {
            swal({
                title: "请填写团组织名称！",
                type: "info"
            });
            return;
        }
        if ($("#branchName").val().length>10) {
            swal({
                title: "团组织名称过长！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/league/saveLeagueBranch", {
            id: $("#id").val(),
            branchName: $("#branchName").val(),
            remark: $("#remark").val(),
            pId:$("#pId").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                var treeObj = $.fn.zTree.getZTreeObj("deptTree");
                refreDeptTree();
            }
        })
    }
</script>
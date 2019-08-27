<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                    <span class="iconBtx">*</span>
                    物品名称
                </div>
                <div class="col-md-9">
                    <input id="deptName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                           maxlength="15" placeholder="最多输入15个字"
                           class="validate[required,maxSize[8]] form-control"/>
                </div>
            </div>
            <div class="form-row">
                <div style="text-align: center">
                    <button class="btn btn-default btn-clean" id="saveBtn" onclick="saveDept()">保存</button>
                    <button class="btn btn-default btn-clean" onclick="deptObjhide()">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="pId" hidden value="${pId}">
<input id="pname" hidden value="${name}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var dicType='${dicType}';
    function saveDept() {
        if ($("#deptName").val() == "" || $("#deptName").val() == null) {
            swal({
                title: "请填写名称",
                type: "info"
            });
            return;
        }
        if ($("#deptName").val().length > 50) {
            swal({
                title: "名称过长，重新填写",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/repair/checkName", {
            dictype: dicType,
            dicname: $("#deptName").val(),
            parentDicId: $("#pId").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: "名称重复，请重新填写！", type: "error"});
            }
            else {
                $.post("<%=request.getContextPath()%>/repair/saveRepairGoods", {
                    dicname: $("#deptName").val(),
                    parentDicId: $("#pId").val(),
                    name: $("#pname").val(),
                    dictype: dicType
                }, function (msg) {
                    hideSaveLoading();
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        var treeObj = $.fn.zTree.getZTreeObj("deptTree");
                        refreDeptTree();
                    }
                })
                showSaveLoading();
            }
        })
    }
</script>
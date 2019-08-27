    <%--
      Created by IntelliJ IDEA.
      User: Admin
      Date: 2017/4/14
      Time: 15:39
      To change this template use File | Settings | File Templates.
    --%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <input id="resourceid" hidden value="${menu.resourceid}">
        <input id="parentresourceid" hidden value="${menu.parentresourceid}">
        <div class="col-md-12">
        <div class="block block-drop-shadow">
        <div class="header">
        <span style="font-size: 14px">${head}</span>
        </div>
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align:
        center"></div>
        <div class="content controls" style="height: 80%">
        <div class="form-row">
        <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        菜单名称
        </div>
        <div class="col-md-9">
        <input id="resourcename" type="text"
        onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
        maxlength="15" placeholder="最多输入15个字"
        value="${menu.resourcename}"/>
        </div>
        </div>
        <div class="form-row">
        <div class="col-md-3 tar">
        菜单路径
        </div>
        <div class="col-md-9">
        <input id="resourceurl" type="text"
        onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
        maxlength="100" placeholder="最多输入100个字母或数字"
        value="${menu.resourceurl}"/>
        </div>
        </div>
        <div class="form-row">
        <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        菜单排序
        </div>
        <div class="col-md-9">
        <input id="resourceorder" type="number" value="${menu.resourceorder}"/>
        </div>
        </div>
        <div class="form-row">
        <div class="col-md-3 tar">
        <%--<span class="iconBtx">*</span>--%>
        菜单备注
        </div>
        <div class="col-md-9">
        <input id="remark" type="text" value="${menu.remark}"
        onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
        maxlength="10" placeholder="最多输入10个字"/>
        </div>
        </div>
        <div class="form-row">
        <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        菜单类型
        </div>
        <div class="col-md-9">
        <select id="resourceType"/>
        </div>
        </div>
        <div class="form-row">
        <div style="text-align: center">
        <button id="saveBtn" class="btn btn-default btn-clean" onclick="saveDept()">保存</button>
        <button class="btn btn-default btn-clean" onclick="menuObjhide()">取消</button>
        </div>
        </div>
        </div>
        </div>
        </div>
        <script>
        $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYLX", function (data) {
        addOption(data, 'resourceType', '${menu.resourcetype}');
        })
        })
        $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

        function saveDept() {
        if ($("#resourcename").val() == "") {
        swal({
        title: "请填写菜单名称！",
        type: "info"
        });
        return;
        }
        if ($("#resourceorder").val() == "" || $("#resourceorder").val() == "0") {
        swal({
        title: "请填写菜单排序！",
        type: "info"
        });
        return;
        }
        /*
        if ($("#remark").val() == "") {
        swal({
        title: "请填写菜单备注！",
        type: "info"
        });
        return;
        }
        */
        if ($("#resourceType").val() == "") {
        swal({
        title: "请填选择菜单类型！",
        type: "info"
        });
        return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/updateMenu", {
        resourceid: $("#resourceid").val(),
        parentresourceid: $("#parentresourceid").val(),
        resourcename: $("#resourcename").val(),
        resourceurl: $("#resourceurl").val(),
        resourceorder: $("#resourceorder").val(),
        resourcetype: $("#resourceType").val(),
        remark: $("#remark").val()
        }, function (msg) {
        hideSaveLoading();
        if (msg.status == 1) {
        swal({title: msg.msg, type: "success"});
        // refreMenuTree();
        $.get("<%=request.getContextPath()%>/getSystemMenuTree", function (data) {
        deptTree = $.fn.zTree.init($("#treeDemo"), setting, data);
        var nodes = deptTree.getNodes()[0].children;
        for (var i = 0; i < nodes.length; i++) { //设置节点展开
        deptTree.expandNode(nodes[i], true, false, true);
        }
        })
        }
        })
        }

        </script>
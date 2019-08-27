<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">修改</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" style="overflow-y:auto;">
                <div>
                    <ul id="changeDeptTree1" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean"  id="saveBtn" onclick="updateEmpDept()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input hidden id="personId" value="${personId}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var changeDeptTree1;
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: {"Y": "s", "N": "ps"}
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: "root"
            }
        },
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/getChangeDeptTree?personId=${personId}", function (data) {
            changeDeptTree1 = $.fn.zTree.init($("#changeDeptTree1"), setting, data);
        });
    });

    function updateEmpDept() {
        var nodes = changeDeptTree1.getCheckedNodes();
        var deptIds = '';
        for (var i = 0; i < nodes.length; i++) {
            deptIds += nodes[i].id + ','
        }
        if(deptIds ==''){
            swal({
                title: "请选择部门",
                type: "info"
            });
            //alert("请选择部门!");
            return;
        }
        deptIds = deptIds.substr(0, deptIds.length - 1)
//        console.log(deptIds)
        showSaveLoading()
        $.post('<%=request.getContextPath()%>/empChangeLog/updateEmpDept', {
            personId: $('#personId').val(),
            deptIds: deptIds
        }, function (msg) {
            hideSaveLoading()
            swal({
                title: msg.msg,
                type: "success"
            });
            //alert(msg.msg);
            $("#dialog").modal("hide");
            deptTable1.ajax.reload();
        })
    }
</script>
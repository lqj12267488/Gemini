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
            <h4 class="modal-title">设置默认部门</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="content">
                    <table id="changeDeptList" cellpadding="0" cellspacing="0"
                           width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    var deptTable;
    $(document).ready(function () {
        deptTable = $("#changeDeptList").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/getChangeDeptList'
            },
            "destroy": true,
            "columns": [
                {"data": "deptId", "visible": false},
                {"data": "deptName", "title": "部门名称","width":"20%"},
                {"data": "deptDescription", "title": "部门全称","width":"60%" ,"visible": false},
                {
                    "title": "操作",
                    "render": function () {
                        return "<span id='changeDept' class='icon-edit' title='切换部门'></span>&ensp;";
                    },"width":"20%"
                }
            ],
            "dom": 't',
            "language": language
        });
        deptTable.on('click', 'tr span', function () {
            var data = deptTable.row($(this).parent()).data();
            var deptId = data.deptId;
            if (this.id == "changeDept") {
                //if (confirm("确定要将" + data.deptName + "设为默认部门？")) {
                swal({
                    title: "确定要将" + data.deptName + "设为默认部门？",
                    //text: "评教方案名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "确认",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/switchRole?deptId=" + deptId, function (msg) {
                        if (msg.status == 1) {
                            window.location.href = "<%=request.getContextPath()%>/index?system=GLPT&id=001";
                        }
                    })
                })
            }
        });
    })
</script>
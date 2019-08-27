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
            <h4 class="modal-title">设置默认查看学生</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="content">
                    <table id="studentTable" cellpadding="0" cellspacing="0"
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
    var studentTable;
    $(document).ready(function () {
        studentTable = $("#studentTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/core/parent/getClassByPersonId'
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"data": "studentName", "title": "学生姓名","width":"40%"},
                {"data": "relationShow", "title": "关系","width":"20%"},
                {
                    "title": "操作",
                    "render": function () {
                        return "<span id='changeClass' class='icon-edit' title='切换学生'></span>&ensp;";
                    },"width":"20%"
                }
            ],
            "dom": 't',
            "language": language
        });
        studentTable.on('click', 'tr span', function () {
            var data = studentTable.row($(this).parent()).data();
            var studentId = data.studentId;
            var  studentName= data.studentName;
            if (this.id == "changeClass") {
                swal({
                    title: "您确定要把当前数据设置为默认班级?",
                    text: "班级名称："+studentName+"\n\n",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/switchRole?deptId=" + studentId, function (msg) {
                        if (msg.status == 1) {
                            window.location.href = "<%=request.getContextPath()%>/index"
                        }
                    })

                });
               /* if (confirm("确定要将" + data.className + "设为默认班级？")) {
                    $.get("/switchRole?deptId=" + classId, function (msg) {
                        if (msg.status == 1) {
                            window.location.href = "/index"
                        }
                    })
                }*/
            }
        });
    })
</script>
<%--suppress ALL --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">新增</span>
            <input id="arrayclassId" value="${arrayclassId}" hidden>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        新增学生
                    </div>
                    <div class="col-md-5" >
                        <input id="studentadd" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean"
                    onclick="add()">新增
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
            $("#studentadd").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#studentadd").val(ui.item.label);
                    $("#studentadd").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    })

        function add() {
        var studentId = $("#studentadd").attr("keycode");
        if(studentId =="" || studentId==null ){
            swal({
                title: "请填写新增学生！",
                type: "info"
            });
            return;
        }
        var studentList = studentId.split(",");

        $.get('<%=request.getContextPath()%>/arrayClass/student/addClassTeacher?arrayclassId='+ $("#arrayclassId").val()+
            "&studentId="+studentList[1]+ "&classId="+studentList[0], function (msg) {
            if(msg.status == 1){
                swal({title: msg.msg, type: "success"});
                $('#classStudentGrid').DataTable().ajax.reload();
                $("#dialog").modal("hide");
            }
            if(msg.status == 0){
                swal({title: msg.msg, type: "success"});
                $("#studentadd").attr("keycode","");
                $("#studentadd").val("");
            }
        })
    }

</script>



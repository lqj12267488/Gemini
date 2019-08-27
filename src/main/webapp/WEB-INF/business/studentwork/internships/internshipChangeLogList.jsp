<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/3
  Time: 21:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<input id="internshipId" hidden value="${internshipManage.internshipId}">
<div class="container" id="fuye">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${studentIdShow} > 查看变更记录</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="internshipManageid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>

    var roleTable;

    $(document).ready(function () {
        roleTable = $("#internshipManageid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/internshipManage/selectInternshipManage',
                "data": {
                    internshipId: $("#internshipId").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "createTime", "visible": false},
                {"width": "12%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "12%", "data": "majorCodeShow", "title": "专业"},
                {"width": "10%", "data": "studentIdShow", "title": "学生"},
                {"width": "10%", "data": "classIdShow", "title": "班级"},
                {"width": "16%", "data": "oldInternshipUnitIdShow", "title": "原实习单位"},
                {"width": "16%", "data": "newInternshipUnitIdShow", "title": "新实习单位"},
                {"width": "12%", "data": "reason","title":"变动原因"},
                {"width": "12%", "data": "alertTime","title":"变动时间"},

            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    })
    function back(){
        $("#right").load("<%=request.getContextPath()%>/internshipChangeLog/internshipsList1");
    }
</script>

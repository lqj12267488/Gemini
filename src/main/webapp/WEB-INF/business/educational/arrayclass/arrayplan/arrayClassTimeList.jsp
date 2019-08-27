<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${name} > 设置学时时间</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="back()">返回
                            </button>
                            <br>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="arrayClassTimeGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var arrayClassTime;
    $(document).ready(function () {
        arrayClassTime = $("#arrayClassTimeGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/getArrayClassTimeList?arrayClassId=${arrayClassId}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "hoursCode", "visible": false},
                {"width": "22%", "data": "hoursType", "title": "学时类型"},
                {"width": "22%", "data": "hoursName", "title": "学时名称"},
                {"width": "22%", "data": "startTime", "title": "开始时间"},
                {"width": "22%", "data": "endTime", "title": "结束时间"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editTime' class='icon-time' title='修改'></a>";
                    }
                }
            ],
            'order': [[1, 'asc']],
            "dom": 'rtlip',
            language: language
        });
        arrayClassTime.on('click', 'tr a', function () {
            var data = arrayClassTime.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editTime") {
                $("#dialog").load("<%=request.getContextPath()%>/arrayClass/addArrayClassTime?id=" + id + "&arrayClassId=${arrayClassId}");
                $("#dialog").modal("show");
            }
        });
    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClass/request");
    }
</script>
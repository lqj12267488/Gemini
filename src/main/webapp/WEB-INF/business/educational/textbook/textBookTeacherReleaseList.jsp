<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/26
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                         <div class="form-row">
                                <div class="col-md-1 tar">
                                    教材名称
                                </div>
                                <div class="col-md-2">
                                    <input id="t_textbookName" type="text"
                                           class="validate[required,maxSize[100]] form-control"/>
                                </div>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchTextBookStatistics()">
                                    查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="block block-drop-shadow content">
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        </div>
                        <div class="form-row block" style="overflow-y:auto;">
                            <table id="textBookGrid" cellpadding="0" cellspacing="0" width="100%"
                                   style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
            </div>
        </div>
    </div>
</div>
<input id="f_textbookId" value="${textbookId}" hidden>
<script>
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        if ('${data.majorCode}' != "") {
            var deptId = '${data.departmentsId}';
            $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorCode', '${data.majorCode},${data.trainingLevel}');
            });
        } else {
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }

        if ('${data.majorCode}' != "") {
            var majorCode = '${data.majorCode}';
            var trainingLevel = '${data.trainingLevel}';
            var majorDirection = '${data.majorDirection}';
            $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + majorCode + "&trainingLevel=" +
                trainingLevel, function (data) {
                addOption(data, 'classId', '${data.classId}');
            });
        } else {
            $("#classId").append("<option value='' selected>请选择</option>")
        }
        exportMajorTextBook();
        searchTextBookStatistics();
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editTextBookStatistics") {
                $("#dialog").load("<%=request.getContextPath()%>/textbook/editTextBookStatistics?id=" + id);
                $("#dialog").modal("show");
            }
        });
    });

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCode');
        });
    }

    function changeClass() {
        var majorCode = $("#majorCode").val();
        var arr = majorCode.split(",");
        $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + arr[0] + "&trainingLevel=" + arr[1], function (data) {
            addOption(data, 'classId');
        });
    }

    function searchClear() {
        $("#t_textbookName").val("");
        $("#departmentsId").val("");
        $("#majorCode").val("");
        $("#classId").val("");
        searchTextBookStatistics();
    }

    function searchTextBookStatistics() {
        var textbookName = $("#t_textbookName").val();
        if (textbookName != "")
            textbookName = '%' + textbookName + '%';
        var departmentsId = $("#departmentsId").val();
        var majorCode = $("#majorCode").val();
        var classId = $("#classId").val();
        table = $("#textBookGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/textbook/getTextBookStatisticsList?textbookId='+$("#f_textbookId").val(),
                "data": {
                    textbookName: textbookName,
                    personType: '${personType}',
                    departmentsId: departmentsId,
                    majorId: majorCode,
                    classId: classId,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "textbookId", "visible": false},
                {"data": "declareId", "visible": false},
                {"width": "10%", "data": "textbookName", "title": "教材名称"},
                {"width": "10%", "data": "price", "title": "单价"},
                {"width": "10%", "data": "declareNum", "title": "预定数量"},
                {"width": "10%", "data": "textbookNumIn", "title": "库存数量"},
                {"width": "10%", "data": "actualNum", "title": "实订数"},
                {"width": "10%", "data": "discount", "title": "折扣"},
                {"width": "10%", "data": "total", "title": "折后总金额"},
                {
                    "width": "10%", "title": "操作", "render": function (data, type, row) {
                        return "<a onclick='releaseTextbook(\"" + row.declareId + "\")' class='icon-indent-right' title='教材发放'></a>&nbsp;&nbsp;&nbsp;"
                            + "<a onclick='updataTextbook(\"" + row.id + "\",\"" + row.textbookId + "\",\"" + row.actualNum + "\",\"" + row.discount + "\",\"" + row.declareId + "\")' class='icon-edit' title='实订数和折扣修改'></a>&nbsp;&nbsp;&nbsp;"
                            + "<a onclick='releaseSearchTextbook(\"" + row.declareId + "\")' class='icon-search' title='详情'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order': [5, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

    function exportMajorTextBook() {
        var departmentsId = $("#departmentsId").val();
        var majorId = $("#majorCode").val();
        var classId = $("#classId").val();
        if (departmentsId == null) {
            departmentsId = "";
        }


        var href = "<%=request.getContextPath()%>/textbook/exportTextBookTeacherRelease?departmentsId=" + departmentsId + "&majorId=" + majorId + "&classId=" + classId;
        $("#exportData").attr("href", href);
    }
    function releaseTextbook(id) {
        $("#dialog").load("<%=request.getContextPath()%>/textbook/releaseTextbookById?declareId=" + id + "&personType=${personType}");
        $("#dialog").modal("show");
    }
    function releaseSearchTextbook(id) {
        $("#dialog").load("<%=request.getContextPath()%>/textbook/releaseSearchTextbookById?declareId=" + id + "&personType=${personType}");
        $("#dialog").modal("show");
    }
    function updataTextbook(id,textbookId,actualNum,discount,declareId) {
        $("#dialog").load("<%=request.getContextPath()%>/textbook/updateTextbookDeclare?id=" + id + "&textbookId="+textbookId+"&actualNum="+actualNum+"&discount="+discount+"&declareId="+declareId);
        $("#dialog").modal("show");
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/textbook/textBookTeacherGrantStatisticsList");
        $("#right").modal("show");
    }
</script>

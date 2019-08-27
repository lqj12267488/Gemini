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
                                    课程名称
                                </div>
                                <div class="col-md-2">
                                    <input id="t_courseId" type="text"
                                           class="validate[required,maxSize[100]] form-control"/>
                                </div>
                                <div class="col-md-1 tar">
                                    教材名称
                                </div>
                                <div class="col-md-2">
                                    <input id="t_textbookName" type="text"
                                           class="validate[required,maxSize[100]] form-control"/>
                                </div>
                                <div class="col-md-1 tar">
                                    出版社
                                </div>
                                <div class="col-md-2">
                                    <input id="t_publishingHouse" type="text"
                                           class="validate[required,maxSize[100]] form-control"/>
                                </div>
                                <div class="col-md-2">
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
                    </div>

                    <div class="block block-drop-shadow content">
                        <div class="form-row">
                            <%-- <button  id="exportBookPayment"    type="button" class="btn btn-default btn-clean"
                                     onclick="exportMajorTextBook()">导出
                             </button>--%>
                           <button type="button" class="btn btn-default btn-clean" onclick="exportMajorTextBook()">
                               导出
                           </button>
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
    <script>
        var textBookGrid;
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
            searchTextBookStatistics();
            textBookGrid.on('click', 'tr a', function () {
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
            $("#t_publishingHouse").val("");
            $("#t_courseId").val("");
            searchTextBookStatistics();
        }

        function searchTextBookStatistics() {
            var textbookName = $("#t_textbookName").val();
            if (textbookName != "")
                textbookName = '%' + textbookName + '%';
            var courseId = $("#t_courseId").val();
            if (courseId != "")
                courseId = '%' + courseId + '%';

            var publishingHouse = $("#t_publishingHouse").val();
            if (publishingHouse != "")
                publishingHouse = '%' + publishingHouse + '%';
            textBookGrid = $("#textBookGrid").DataTable({
                "processing": true,
                "serverSide": true,
                "ajax": {
                    "type": "post",
                    "url": '<%=request.getContextPath()%>/textbook/getTextBookPaymentList',
                    "data": {
                        courseId:courseId,
                        textbookName:textbookName,
                        publishingHouse:publishingHouse,

                    }
                },
                "destroy": true,
                "columns": [
                    {"data": null, "targets": 0, "title": "序号"},
                    {"width": "7%", "data": "courseId", "title": "课程名称"},
                    {"width": "7%", "data": "textbookName", "title": "教材名称"},
                    {"width": "10%", "data": "editor", "title": "主编"},
                    {"width": "10%", "data": "publishingHouse", "title": "出版社"},
                    {"width": "10%", "data": "studentCount", "title": "学生用书合计"},
                    {"width": "10%", "data": "teacherCount", "title": "教师用书合计"},
                    {"width": "10%", "data": "declareNum", "title": "合计"},
                    {"width": "5%", "data": "price", "title": "每本单价"},
                    {"width": "10%", "data": "discount", "title": "折扣"},
                    {"width": "5%", "data": "total", "title": "合计实付款"},
                    {"width": "7%", "data": "remark", "title": "备注"},
                ],

                'order': [1, 'desc'],
                 paging: true,
                "dom": 'rtlip',
                "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                    $("td:first", nRow).html(iDisplayIndex + 1);//设置序号位于第一列，并顺次加一
                    return nRow;
                },
                language: language
            });

        }
        function exportMajorTextBook() {
            window.location.href = "<%=request.getContextPath()%>/textbook/exportTextBookPaymentSummary?textbookName=" + $("#t_textbookName").val()
                + "&courseId=" + $("#t_courseId").val() + "&publishingHouse=" + $("#t_publishingHouse").val();
        }


    </script>
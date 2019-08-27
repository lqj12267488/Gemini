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
                                <input id="textbookName" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchBranch()">
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
                    <%--                                <div class="form-row" id="addbutton">
                                                        <a id="expdata" class="btn btn-info btn-clean" >导出</a>
                                                    </div>--%>
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
    var table;
    $(document).ready(function () {
        table = $("#textBookGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/textbook/getTextBookReleaseList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "majorId", "title": "专业名称"},
                {"width": "8%", "data": "trainingLevel", "title": "培养层次"},
                {"width": "10%", "data": "classId", "title": "班级名称"},
                {"width": "10%", "data": "courseId", "title": "课程"},
                {"width": "10%", "data": "textbookId", "title": "教材名称"},
                {"width": "10%", "data": "declareNum", "title": "申报数量"},
                {"width": "10%", "data": "remainderNum", "title": "剩余发放数量"},
                {"width": "8%", "data": "giveState", "title": "发放状态"},
                {
                    "width": "7%", "title": "操作", "render": function () {
                        return "<a id='release' class='icon-indent-right' title='发放'></a>";
                    }
                }
            ],
            'order': [2, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "release") {
                $("#dialog").load("<%=request.getContextPath()%>/textbook/releaseTextbookById?id=" + id);
                $("#dialog").modal("show");
            }
        });
    });

    function textBookDeclare() {
        $("#dialog").load("<%=request.getContextPath()%>/textbook/addTextBookDeclare");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#textbookName").val("");
        searchBranch();
    }

    function searchBranch() {
        var textbookName = $("#textbookName").val();
        if (textbookName != "")
            textbookName = '%' + textbookName + '%';
        table = $("#textBookGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/textbook/getTextBookReleaseList',
                "data": {
                    textbookId: textbookName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "majorId", "title": "专业名称"},
                {"width": "8%", "data": "trainingLevel", "title": "培养层次"},
                {"width": "10%", "data": "classId", "title": "班级名称"},
                {"width": "10%", "data": "courseId", "title": "课程"},
                {"width": "10%", "data": "textbookId", "title": "教材名称"},
                {"width": "10%", "data": "declareNum", "title": "申报数量"},
                {"width": "10%", "data": "remainderNum", "title": "剩余发放数量"},
                {"width": "8%", "data": "giveState", "title": "发放状态"},
                {
                    "width": "7%", "title": "操作", "render": function () {
                        return "<a id='release' class='icon-indent-right' title='发放'></a>";
                    }
                }
            ],
            'order': [2, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        //exportTextBook()
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            var planName = data.planName;
            if (this.id == "editTextBookDeclare") {
                $("#dialog").load("<%=request.getContextPath()%>/editPartyBranch?id=" + id);
                $("#dialog").modal("show");
            }

            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
        });

        function exportTextBook() {
            var textbookName = $("#textbookName").val();
            if (textbookName != "")
                textbookName = '%' + textbookName + '%';
            var href = "<%=request.getContextPath()%>/textbook/exportTextbook?textbookId=" + textbookName;
            $("#textbookData").attr("href", href);
        }

    }
</script>

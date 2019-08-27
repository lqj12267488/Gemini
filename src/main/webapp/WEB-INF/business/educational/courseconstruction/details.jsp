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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
    table {
        max-width: 2000px;
        width: 2000px;
    }

    td {
        border: 1px black solid;
        text-align: center;
        width: 150px;
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content" style="overflow-x: scroll;width: 100%">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        <button type="button" class="btn btn-default btn-clean" onclick="add()">新增</button>
                        <button type="button" class="btn btn-default btn-clean" onclick="importTable()">导入</button>
                        <button type="button" class="btn btn-default btn-clean" onclick="exportTable()">导出</button>
                    </div>
                    <table id="details">
                        <tr>
                            <td colspan="${fn:length(classList) + 3}">
                                <h3>${deptShow}</h3>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="3">
                                月份
                            </td>
                            <td rowspan="3">
                                日期
                            </td>
                            <td rowspan="3">
                                周
                            </td>
                            <c:forEach var="item" items="${majorList}">
                                <td colspan="${item.NUM}">${item.MAJOR_NAME}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach var="item" items="${classList}">
                                <td>${item.CLASS_NAME}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach var="item" items="${classList}">
                                <td>${item.NUM}</td>
                            </c:forEach>
                        </tr>
                        <c:forEach var="content" items="${contentList}">
                            <tr>
                                <td rowspan="${fn:length(content.value)}">
                                        ${content.key}
                                </td>
                                <td>${content.value[0][0].date}</td>
                                <td>${content.value[0][1].week}</td>
                                <c:forEach var="details" items="${content.value[0]}" begin="2">
                                    <td id="${details.id}">${details.type}</td>
                                </c:forEach>
                            </tr>
                            <c:forEach var="row" items="${content.value}" begin="1">
                                <tr>
                                    <td>${row[0].date}</td>
                                    <td>${row[1].week}</td>
                                    <c:forEach var="details" items="${row}" begin="2">
                                        <c:if test="${!empty row}">
                                            <td id="${details.id}">${details.type}</td>
                                        </c:if>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                        <tr>
                            <td colspan="${fn:length(classList) + 3}" style="text-align: left">
                                说明：1、↑↓课堂教学 ☆校外实习 ★校内实习 ▲讲座 ◆课程设计 △入学教育 ＃新生军训 ◇复习考试 。
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="importTeble" tabindex="111" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">导入</h4>
            </div>
            <div class="modal-body clearfix">
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-12 tar">
                            <form action='<%=request.getContextPath()%>/student/importCalendar' id="importCalendar" enctype="multipart/form-data" method="post">
                                <input type="file" name="file" id="file">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a type="button" class="btn btn-default btn-clean" href="<%=request.getContextPath()%>/courseconstruction/downImportTemplate?id=${id}">下载导入模板</a>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="importCalendar()">保存</button>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<script src="<%=request.getContextPath()%>/libs/js/tableExport.min.js"></script>
<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/courseconstruction/teachingCalendar");
    }

    function importTable() {
        $("#importTeble").modal("show");
        $(".modal-backdrop").removeClass("modal-backdrop");
    }

    function importCalendar() {
        var form = new FormData(document.getElementById("importCalendar"));
        $.ajax({
            url: '<%=request.getContextPath()%>/courseconstruction/importCalendar?id=${id}',
            type: "post",
            data: form,
            processData: false,
            contentType: false,
            success: function (data) {

                if (data.status == 1) {
                    swal({
                        title: data.msg,
                        type: "success"
                    });
                    $("#importTeble").modal("hide");
                    $("#right").load("<%=request.getContextPath()%>/courseconstruction/details?id=${id}");
                }else{
                    swal({
                        title: data.msg,
                        type: "error"
                    });
                }
            }

        });
    }

    $(function () {
        $("td").bind("click", function () {
            var id = $(this).attr("id");
            if (id && id != '') {
                swal({
                    title: "您确定要删除本条信息?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/courseconstruction/deleteTeachingCalendarDetails?id=" + id, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $("#right").load("<%=request.getContextPath()%>/courseconstruction/details?id=${id}");
                    })
                });
            }
        })
    });

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/courseconstruction/editTeachingCalendarDetails?id=${id}");
        $("#dialog").modal("show")
    }

    function exportTable() {
        $('#details').tableExport({type: 'excel', formats: ["xls"], fileExtension: ".xls", fileName: "${deptShow}教学日历"});
    }
</script>
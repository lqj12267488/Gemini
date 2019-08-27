<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/16
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">${scoreExamName}  </h5>
                        </header>
                        <div class="form-row">
                            <div class="form-row">
                                <%--<div class="col-md-10" style="overflow: hidden;  margin-bottom: 10px">--%>
                                    <%--<div class="col-md-2 tar">--%>
                                        <%--学生姓名：--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2" style="width: 15%;">--%>
                                        <%--<input id="query_studentName" type="text"--%>
                                               <%--class="validate[required,maxSize[100]] form-control"/>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2 tar">--%>
                                        <%--身份证号码：--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2" style="width: 15%;">--%>
                                        <%--<input id="query_studentId" type="text"--%>
                                               <%--class="validate[required,maxSize[100]] form-control"/>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">--%>
                                    <%--<div class="col-md-2 tar">--%>
                                        <%--专业：--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2" style="width: 15%;">--%>
                                        <%--<select id="query_majorCode"></select>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2 tar">--%>
                                        <%--考核方式：--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2" style="width: 15%;">--%>
                                        <%--<select id="query_examType"></select>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<div class="col-md-10" style="overflow: hidden; margin-bottom: 10px;">--%>
                                    <%--<div class="col-md-2 tar">--%>
                                        <%--授课老师：--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2" style="width: 15%;">--%>
                                        <%--<select id="query_teacherId"></select>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2 tar">--%>
                                        <%--学号：--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2" style="width: 15%;">--%>
                                        <%--<input id="xuehao" type="text"/>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-md-2 tar"></div>--%>
                                    <%--<div class="col-md-2" style="width: 15%;">--%>
                                        <%--<button type="button" class="btn btn-default btn-clean" onclick="search()">查询--%>
                                        <%--</button>--%>
                                        <%--<button type="button" class="btn btn-default btn-clean" onclick="searchClear()">--%>
                                            <%--清空--%>
                                        <%--</button>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        <a id="expdata" class="btn btn-info btn-clean" onclick="expdata()">导出</a>
                        <%--<c:if test="${editFlag == '1' }">--%>
                            <a id="impdata" class="btn btn-info btn-clean" onclick="impdata()">导入</a>
                            <%--<a id="impdata" class="btn btn-info btn-clean" onclick="downTemplate()">下载导入模板</a>--%>
                            <button id="saveBtn" type="button" class="btn btn-default btn-clean" onclick="saveScore()">
                                暂存
                            </button>
                            <%--<button id="saveBtn" type="button" class="btn btn-default btn-clean" onclick="checkSubmit()">--%>
                                <%--成绩提交--%>
                            <%--</button>--%>
                        <%--</c:if>--%>
                        <%--<button type="button" class="btn btn-default btn-clean" onclick="batchDel()">清除</button>--%>
                        <%--<button type="button" class="btn btn-default btn-clean" onclick="exportScore()">班级成绩单导出</button>--%>
                        <%--<button type="button" class="btn btn-default btn-clean" onclick="toCheckedClass(1,2)">--%>
                            <%--期末考试不合格情况表--%>
                        <%--</button>--%>
                        <button type="button" class="btn btn-default btn-clean" onclick="changeOpenFlag()">发布成绩</button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <form id="scores">
                            <%--<input name="type" value="${type}" type="hidden"/>--%>
                            <table id="listGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="id" hidden value="${id}">
    <input id="scoreExamName" hidden value="${scoreExamName}">
    <input id="term" hidden value="${term}">
    <input id="course" hidden value="${course}">
    <input id="examName" hidden value="${examName}">
    <input id="examType" hidden value="${examType}">
    <input id="classId" hidden value="${classId}">
    <input id="examMethod" hidden value="${examMethod}">
</div>
<script>
    var listTable;

    var dataS;
    $.post("<%=request.getContextPath()%>/common/getSysDict", {
        name: 'KSZT',
        where: " dic_name not in ('补违纪','补缺考')"
    }, function (data) {
        dataS = data;
    });

    var dataScoreType;

    $.post("<%=request.getContextPath()%>/common/getSysDict", {
        name: 'CJZT',
        where: " dic_name in ('合格','不合格','违纪','缺考')"
    }, function (data) {
        dataScoreType = data;
    });

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/scoreMakeup/getQueryList?scoreExamId=${scoreExamId}", function (data) {
            if (data != null) {
                addOption(data["majorSelect"], 'query_majorCode');
                addOption(data["teacherSelect"], 'query_teacherId');
            }
        });

        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'KHFS',
            where: " dic_name in ('考试','考查')"
        }, function (data) {
            addOption(data, 'query_examType');
        });
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/updateScoreMakeup?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "toEdit") {
                $("#dialog").load("<%=request.getContextPath()%>/otherExamination/editScore?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delete") {
                swal({
                    title: "您确定要删除本条信息?",
                    //text: "关联业务："+data.text+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/otherExamination/delScore?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#listGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });

        $("#right").css("overflow", "auto");
        $(".sorting_disabled").append("<input type='checkbox' id='checkAll' onclick='check()'>");
    })

    function searchClear() {
        $("#query_studentName").val("");
        $("#query_studentId").val("");
        $("#query_majorCode").val("");
        $("#query_examType").val("");
        $("#query_teacherId").val("");
        $("#xuehao").val("");
        search();
    }

    var render =/* "<a id='toEdit' class='icon-edit' title='成绩修改申请'>&ensp;&ensp;"+*/
        "<a id='delete' class='icon-trash' title='删除'/>";

    function search() {

        // $("#checkAll").removeAttr("checked");

        // var studentName = $("#query_studentName").val();
        // var studentId = $("#query_studentId").val();
        // var majorCode = $("#query_majorCode").val();
        // var examType = $("#query_examType").val();
        // var teacherId = $("#query_teacherId").val();
        // var xuehao = $("#xuehao").val();

        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/otherExamination/getScoreImport',
                "data": {
                    scoreExamId: '${id}',
                }
            },
            "destroy": true,
            "columns": [
                // {
                //     "render": function (data, type, row) {
                //         return "<input type='checkbox' text='checkbox' value='" + row.id + "'/>";
                //     }
                // },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": null, "targets": 0, "title": "序号"},
                // {"data": "courseShow", "title": "课程"},
                // {"data": "examMethod","title": "考试方式"},
                // {"data": "classId", "title": "班级"},
                {"data": "name", "title": "学生姓名"},
                {"data": "studentNumber",  "title": "学号"},
                {"data": "idcard",  "title": "身份证号"},
                {"data": "sexShow",  "title": "性别"},
                // {"title": "系部", "data": "departmentsId"},
                {"title": "专业", "data": "majorCodeShow"},
                {"data": "classIdShow", "title": "班级"},
                {"title": "学期", "data": "termShow"},
                {"title": "考试名称", "data": "scoreExamName"},
                {"data": "courseIdShow", "title": "科目"},
                {"data": "examMethodShow", "title": "考核方式"},
                {"data": "teachingTeacherIdShow", "title": "授课教师 "},
                {
                    "title": "成绩", "data": "score",
                    "render": function (data, type, row) {
                        if (row.openFlag == '1') {
                            return row.score;
                        }
                        var scoreIn = "";
                        if (row.score != null) {
                            scoreIn = row.score;
                        }
                        var html = "<input name='score_" + row.id + "' value='" + scoreIn + "' maxlength='10'>";
                        return html;
                    }
                },
                {"data": "uploadTime", "title": "上传时间"},
                {
                    "title": "操作", "render": function () {
                        return render;
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'iDisplayLength': 100,
            'order': [1, 'desc'],
            "dom": 'rtlip',
            "fnRowCallback": function (nRow, aData, iDisplayIndex) {
                $("td:first", nRow).html(iDisplayIndex + 1);//设置序号位于第一列，并顺次加一
                return nRow;
            },
            language: language
        });
    }

    //返回
    function back() {
        $("#right").load("<%=request.getContextPath()%>/otherExamination/otherExamination");
        $("#right").modal("show");
    }

    //导出
    function expdata() {
        var href = "<%=request.getContextPath()%>/otherExamination/exportOtherExamination?scoreExamId=${id}"
        $("#expdata").attr("href", href);
    }

    //导入
    function impdata() {
        $("#dialog").load("<%=request.getContextPath()%>/otherExamination/otherExaminationImport?scoreExamId=${id}&term=${term}&course=${course}&examName=${examName}&examType=${examType}");
        $("#dialog").modal("show");
    }

    function saveScore() {
        var scores = $("#scores").serializeArray();
        $.post("<%=request.getContextPath()%>/otherExamination/saveScore", scores, function (msg) {
            swal({title: msg.msg, type: "success"});
            search();
        })
    }

    function check() {
        if ($("#checkAll").attr("checked")) {
            $("[text='checkbox']").attr("checked", "checked");
        } else {
            $("[text='checkbox']").removeAttr("checked");
        }
    }

    <%--function batchDel() {--%>
        <%--var chk_value = "'";--%>
        <%--if ($('input[text="checkbox"]:checked').length > 0) {--%>
            <%--swal({--%>
                <%--title: "确认清除所选学生的考试成绩?",--%>
                <%--text: "清除后将无法恢复，请谨慎操作！",--%>
                <%--type: "warning",--%>
                <%--showCancelButton: true,--%>
                <%--cancelButtonText: "取消",--%>
                <%--confirmButtonColor: "#DD6B55",--%>
                <%--confirmButtonText: "清除",--%>
                <%--closeOnConfirm: false--%>
            <%--}, function () {--%>
                <%--$('input[text="checkbox"]:checked').each(function () {--%>
                    <%--chk_value += $(this).val() + "','";--%>
                <%--});--%>
                <%--chk_value = chk_value.substring(0, chk_value.length - 2)--%>
                <%--$.get("<%=request.getContextPath()%>/scoreMakeup/delScoreImport?ids=" + chk_value, function (msg) {--%>
                    <%--swal({--%>
                        <%--title: msg.msg,--%>
                        <%--type: "success"--%>
                    <%--}, function () {--%>
                        <%--listTable.ajax.reload();--%>
                    <%--});--%>
                <%--});--%>
            <%--})--%>
        <%--} else {--%>
            <%--swal({--%>
                <%--title: "请选择一条或多条记录!",--%>
                <%--type: "info"--%>
            <%--});--%>
        <%--}--%>

    <%--}--%>

    function downTemplate() {
        <%--$("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/toCheckCourseForTeacher?scoreExamId=${scoreExamId}&type=${type}");--%>
        //$("#dialog").modal("show");
        $.get("<%=request.getContextPath()%>/scoreMakeup/checkExportMakeupScore?type=${type}&scoreExamId=${scoreExamId}&term=${termId}&courseId=${courseId}&classId=${classId}", function (data) {
            if (data.status == 0) {
                window.location.href = "<%=request.getContextPath()%>/scoreMakeup/exportMakeupScore/" +
                    "?type=${type}&scoreExamId=${scoreExamId}&term=${termId}&courseId=${courseId}&classId=${classId}&examMethod=${examMethod}";
            } else {
                swal({
                    title: "无数据！",
                    type: "error"
                });
            }
        });


    }

    function toCheckedClass(examTypes, scoreType) {
        $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/toCheckedClass?examTypes=" + examTypes + "&scoreType=" + scoreType + "&scoreExamId=${scoreExamId}");
        $("#dialog").modal("show");
    }

    function changeOpenFlag() {
        var id = $("#id").val();
        swal({
            title: "确认公开成绩?",
            text: "请确定成绩表已完成录入，公开后全校师生皆可查看！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/otherExamination/changeOpenFlag", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                search();
            });
        })
    }

    function exportScore() {
        window.location.href = "<%=request.getContextPath()%>/scoreMakeup/exportScoreImport?scoreExamId=${scoreExamId}";
    }

    function checkSubmit() {
        $.get("<%=request.getContextPath()%>/scoreMakeup/check?termId=${termId}&course=${courseId}&classId=${classId}", function (data) {
            if (data.status == 0) {
                swal({
                    title: "请做完试卷分析后进行提交！",
                    type: "error"
                });
            } else {
                swal({
                    title: "试卷分析已经做完！",
                    type: "info"
                });
            }
        });
    }
</script>
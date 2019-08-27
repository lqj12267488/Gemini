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
                            <h5 class="mui-title">其他成绩录入</h5>
                        </header>
                        <div class="form-row">
                            <div class="form-row">
                                <div class="form-row">
                                    <div class="col-md-1 tar" style="width:100px">
                                        学生姓名：
                                    </div>
                                    <div class="col-md-2">
                                        <input id="studentName" type="text"/>
                                    </div>


                                    <div class="col-md-1 tar" style="width:100px">
                                        学号：
                                    </div>
                                    <div class="col-md-2">
                                        <input id="selName" type="text"/>
                                    </div>


                                    <div class="col-md-2">
                                        <button type="button" class="btn btn-default btn-clean"
                                                onclick="search()">查询
                                        </button>
                                        <button type="button" class="btn btn-default btn-clean"
                                                onclick="searchClear()">清空
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        <a id="expdata" class="btn btn-info btn-clean" onclick="expdata()">导出</a>
                        <a id="impdata" class="btn btn-info btn-clean" onclick="impdata()">导入</a>
                        <button id="saveBtn" type="button" class="btn btn-default btn-clean" onclick="saveScore()">
                            保存
                        </button>
                        <button id="saveBtnSubmit" type="button" class="btn btn-default btn-clean"
                                onclick="checkSubmit()">
                            成绩提交
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <form id="scores">
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
    <input id="term" hidden value="${term}">
    <input id="curriculum" hidden value="${curriculum}">
    <input id="departmentId" hidden value="${departmentId}">
    <input id="majorCode" hidden value="${majorCode}">
    <input id="classId" hidden value="${classId}">
</div>
<script>
    var listTable;
    var dataScoreType;

    $.post("<%=request.getContextPath()%>/common/getSysDict", {
        name: 'QTCJKCLX',
        where: " dic_name in ('优秀','良好','合格','不合格','超旷')"
    }, function (data) {
        dataScoreType = data;
    });
    $(document).ready(function () {
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
                $.get("<%=request.getContextPath()%>/otherExamination/getScoreExamListByOtherExam?termId=${term}&course=${curriculum}&classId=${classId}&scoreExamId=${id}", function (msg) {
                    if (msg.status == 2) {
                        swal({
                            title: "成绩已提交，不可删除！",
                            type: "error"
                        });
                    } else {
                        swal({
                            title: "您确定要删除本条信息?",
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
                                    $('#listGrid').DataTable().ajax.reload();
                                }
                            })
                        })
                    }
                })
            }

        });

        $("#right").css("overflow", "auto");
        $(".sorting_disabled").append("<input type='checkbox' id='checkAll' onclick='check()'>");
    })

    function searchClear() {
        $("#studentName").val("");
        $("#selName").val("");
        search();
    }

    var render = "<a id='delete' class='icon-trash' title='删除'/>";

    function search() {
        var className = $("#studentName").val();
        if ("" == className || null == className) {
            className = "";
        } else {
            className = "%" + className + "%";
        }
        var studentNumber = $("#selName").val();
        if ("" == studentNumber || null == studentNumber) {
            studentNumber = "";
        } else {
            studentNumber = "%" + studentNumber + "%";
        }
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/otherExamination/getScoreImport',
                "data": {
                    scoreExamId: '${id}',
                    name:className,
                    studentNumber:studentNumber,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": null, "targets": 0, "title": "序号"},
                {"data": "name", "title": "学生姓名"},
                {"data": "studentNumber", "title": "学号"},
                {"data": "idcard", "title": "身份证号"},
                {"data": "sexShow", "title": "性别"},
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
                        var dis = "";
                        if (row.submitFlag == '1') {
                            dis = 'disabled';
                        }
                        var html = "<select name='score_" + row.id + "' " + dis + " style='min-width: 65px;'>";
                        $.each(dataScoreType, function (index, content) {
                            if (content.text === row.score) {
                                html += "<option value='" + content.text + "' selected='selected'>" + content.text + "</option>";
                            } else {
                                html += "<option value='" + content.text + "'>" + content.text + "</option>";
                            }
                        });
                        html += "</select>";
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
        var href = "<%=request.getContextPath()%>/otherExamination/exportOtherExamination?scoreExamId=${id}&classId=${classId}&departmentId=${departmentId}&majorCode=${majorCode}"
        $("#expdata").attr("href", href);
    }

    //导入
    function impdata() {
        $("#dialog").load("<%=request.getContextPath()%>/otherExamination/otherExaminationImportNew?id=${id}&trainingLevel=${trainingLevel}&majorDirection=${majorDirection}&term=${term}&curriculum=${curriculum}&classId=${classId}&semester=${semester}&departmentId=${departmentId}&majorCode=${majorCode}");
        $("#dialog").modal("show");
    }

    function saveScore() {
        var scores = $("#scores").serializeArray();
        $.get("<%=request.getContextPath()%>/otherExamination/getScoreExamListByOtherExam?termId=${term}&course=${curriculum}&classId=${classId}&scoreExamId=${id}", function (msg) {
            if (msg.status == 2) {
                swal({
                    title: "成绩已提交，不可保存！",
                    type: "error"
                });
            } else {
                $.post("<%=request.getContextPath()%>/otherExamination/saveScore", scores, function (msg) {
                    swal({title: msg.msg, type: "success"});
                    search();
                })
            }
        })
    }

    function check() {
        if ($("#checkAll").attr("checked")) {
            $("[text='checkbox']").attr("checked", "checked");
        } else {
            $("[text='checkbox']").removeAttr("checked");
        }
    }

    function checkSubmit() {
        $.get("<%=request.getContextPath()%>/otherExamination/getScoreExamListByOtherExam?termId=${term}&course=${curriculum}&classId=${classId}&scoreExamId=${id}", function (msg) {
            if (msg.status == 2) {
                swal({
                    title: "成绩已提交，不可重复提交！",
                    type: "error"
                });
            } else {
                $.get("<%=request.getContextPath()%>/scoreMakeup/check?termId=${term}&course=${curriculum}&classId=${classId}&scoreExamId=${id}&flag=100", function (data) {
                    if (data.status == 1) {
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                        $('#listGrid').DataTable().ajax.reload();
                    }else{
                        swal({
                            title: data.msg,
                            type: "error"
                        });
                    }
                });
            }
        })
    }
</script>
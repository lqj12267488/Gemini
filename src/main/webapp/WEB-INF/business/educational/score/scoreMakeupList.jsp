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
                            <h5 class="mui-title">${scoreExamName} > 补考学生名单</h5>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width: 70px">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="selDept"></select>
                            </div>
                            <div class="col-md-1 tar" style="width: 70px">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="selMajor"></select>
                            </div>
                            <div class="col-md-1 tar" style="width: 70px">
                                课程：
                            </div>
                            <div class="col-md-2">
                                <input id="selCourse" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                        <a id="expdata" class="btn btn-info btn-clean" onclick="expdata()">导出</a>
                        <a id="impdata" class="btn btn-info btn-clean" onclick="impdata()">导入</a>
                        <button type="button" class="btn btn-default btn-clean" onclick="saveScore()">保存
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="batchDel()">清除
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <form id="scores">
                            <table id="listGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                                <thead>
                                <tr>
                                    <th width="10%">
                                        <input type="checkbox" id="checkAll" onclick="check()"/>
                                    </th>
                                    <th>id</th>
                                    <th>time</th>
                                    <th>课程</th>
                                    <th>班级</th>
                                    <th>学生姓名</th>
                                    <th>成绩</th>
                                    <th>补考状态</th>
                                    <th>补考成绩</th>
                                    <th>系部</th>
                                    <th>专业</th>
                                    <th>学期</th>
                                    <th>考试</th>
                                </tr>
                                </thead>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="scoreExamId" hidden value="${scoreExamId}">
    <input id="scoreExamName" hidden value="${scoreExamName}">
    <input id="term" hidden value="${term}">
</div>
<script>
    var listTable;
    var type = $("#type").val();
    var dataS;
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {
        dataS = data
    })

    var dataKCCJ;
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCCJ", function (data) {
        dataKCCJ = data
    })

    var dataBKCJZT;
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=BKCJZT", function (data) {
        dataBKCJZT = data
    })

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selTerm');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'selDept');
        });
        $("#selMajor").append("<option value='' selected>请选择</option>");
        $("#selClass").append("<option value='' selected>请选择</option>");
        $("#selDept").change(function () {
            $.get("<%=request.getContextPath()%>/scoreMakeup/getMajorAndLevelByDept?deptId=" + $("#selDept").val(), function (data) {
                addOption(data, "selMajor");
            })
        });
        $("#selMajor").change(function () {
            $.get("<%=request.getContextPath()%>/scoreMakeup/getClassByMajorAndLevel?majorCode=" + $("#selMajor").val(), function (data) {
                addOption(data, "selClass");
            })
        });
        search();
        listTable.on('click', 'tr a', function () {
            var data = listTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/updateScoreMakeup?id=" + id);
                $("#dialog").modal("show");
            }
        });
    })

    function searchclear() {
        $("#selDept").val("");
        $("#selMajor").val("");
        $("#selCourse").val("");
        search();
    }

    function search() {
        var scoreExamId = $("#scoreExamId").val();
        var departmentsId = $("#selDept").val();
        var majorCode = $("#selMajor").val();
        var courseId = $("#selCourse").val();

        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreMakeup/getScoreMakeupExamList1111',
                "data": {
                    scoreExamId: scoreExamId,
                    departmentsId: departmentsId,
                    majorCode: majorCode,
                    courseId: courseId
                }
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) { return "<input type='checkbox' text='checkbox' value='" + row.id + "'/>";
                    }
                },
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "courseId"},
                {"data": "classId"},
                {"data": "studentName"},
                {"data": "score"},
                {
                    "data": "makeupStatus",
                    "render": function (data, type, row) {
                        var html = "<select name='" + row.id + "'>";
                        $.each(dataS, function (index, content) {
                            if(content.id !='4')
                                if (content.text === row.makeupStatus) {
                                    html += "<option value='" + content.id + "' selected>" + content.text + "</option>";
                                } else {
                                    html += "<option value='" + content.id + "'>" + content.text + "</option>";
                                }
                        })
                        html += "</select>"
                        return html;
                    }
                },
                {
                    "data": "makeupScore",
                    "render": function (data, type, row) {
                        var htm ="";
                        if(row.examinationStatus =='缓考'){
                            if(row.courseFlag =='02'){
                                htm ="<option > </option>";
                                $.each(dataKCCJ, function (index, content) {
                                    if (content.text == row.makeupScore) {
                                        htm += "<option value='" + content.id + "' selected>" + content.text + "</option>" ;
                                    } else {
                                        htm += "<option value='" + content.id + "'>" + content.text + "</option>";
                                    }
                                })
                                htm = "<select name='" + row.id + "'>"+htm+"</select>" ;
                            }else{
                                if (row.makeupScore == null) {
                                    row.makeupScore = ""
                                }
                                htm = "<input name='" + row.id + "' value='" + row.makeupScore + "'>" ;
                            }
                        }else{
                            htm ="<option></option>";
                            $.each(dataBKCJZT, function (index, content) {
                                if (content.text == row.makeupScore) {
                                    htm += "<option value='" + content.id + "' selected>" + content.text + "</option>" ;
                                } else {
                                    htm += "<option value='" + content.id + "'>" + content.text + "</option>";
                                }
                            })
                            htm = "<select name='" + row.id + "'>"+htm+"</select>" ;
                        }
                        return htm ;
                    }
                },
                {"data": "departmentsId"},
                {"data": "majorCode"},
                {"data": "termId"},
                {"data": "scoreExamName"},
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    //返回
    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreMakeup/examList?type=1");
        $("#right").modal("show");
    }

    //导出
    function expdata() {
        var href = "<%=request.getContextPath()%>/scoreMakeup/exportMakeupScore?type=1&scoreExamId=${scoreExamId}&scoreExamName=${scoreExamName}" +
            "&deptId=" + $("#selDept").val() + "&majorCode=" + $("#selMajor").val() + "&courseId=" + $("#selCourse").val();
        $("#expdata").attr("href", href);
    }

    //导入
    function impdata() {
        $("#dialog").load("<%=request.getContextPath()%>/scoreMakeup/scoreMakeupImport?type=${type}&scoreExamId=" + $("#scoreExamId").val() + "&scoreExamName=" + $("#scoreExamName").val());
        $("#dialog").modal("show");
    }

    function saveScore() {
        var scores = $("#scores").serializeArray()
        $.post("<%=request.getContextPath()%>/scoreMakeup/saveScore", scores, function (msg) {
            swal({title: msg.msg, type: "success"});
        })
    }

    function check() {
        if ($("#checkAll").attr("checked")) {
            $("[text='checkbox']").attr("checked", "checked");
        } else {
            $("[text='checkbox']").removeAttr("checked");
        }
    }

    function batchDel() {
        var chk_value = "'";
        if ($('input[text="checkbox"]:checked').length > 0) {
            swal({
                title: "确认清除所选学生的考试成绩?",
                text: "清除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "清除",
                closeOnConfirm: false
            }, function () {
                $('input[text="checkbox"]:checked').each(function () {
                    chk_value += $(this).val() + "','";
                });
                chk_value = chk_value.substring(0, chk_value.length - 2)
                $.get("<%=request.getContextPath()%>/scoreMakeup/delMakeupScore?ids=" + chk_value, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    }, function () {
                        listTable.ajax.reload();
                    });
                });
            })
        } else {
            swal({
                title: "请选择一条或多条记录!",
                type: "info"
            });
        }

    }
</script>
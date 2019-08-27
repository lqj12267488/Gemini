<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<input hidden="hidden" id="scoreClassId" value="${scoreClass.scoreClassId}">
<input hidden="hidden" id="subjectId" value="${scoreClass.subjectId}">
<input hidden="hidden" id="courseId" value="${scoreClass.courseId}">
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">${scoreClass.scoreExamName} > 成绩录入</h5>
                        </header>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="studentIdSel" type="text"/>
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
                    <div>
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean" onclick="back()">返回</button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="showSalaryDialog()">导入
                            </button>
                            <a id="expScore" class="btn btn-default btn-clean">导出</a>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="saveScore()">保存
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="batchDel()">清除
                            </button>
                        </div>
                        <div class="form-row block">
                            <form id="score">
                                <table id="importTable" cellpadding="0" cellspacing="0"
                                       width="100%" style="max-height: 50%;min-height: 10%;border: none;"
                                       class="table table-bordered table-striped sortable_default">
                                    <thead>
                                    <tr>
                                        <th width="10%">
                                            <input type="checkbox" id="checkAll" onclick="check()"/>
                                        </th>
                                        <th>id</th>
                                        <th>time</th>
                                        <th>scoreClassId</th>
                                        <th>subjectId</th>
                                        <th>planId</th>
                                        <th>scoreExamId</th>
                                        <th>系部</th>
                                        <th>专业</th>
                                        <th>课程</th>
                                        <th>班级</th>
                                        <th>授课教师</th>
                                        <th>学生姓名</th>
                                        <th>考核类型</th>
                                        <c:if test="${scoreClass.courseFlag == '01' }">
                                            <th>到课情况<br/>(10)</th>
                                            <th>作业情况<br/>(10)</th>
                                            <th>测验情况<br/>(10)</th>
                                            <th>课上提问情况<br/>(10)</th>
                                        </c:if>
                                        <th>考试状态</th>
                                        <th>考试成绩</th>
                                        <th>总成绩</th>
                                    </tr>
                                    </thead>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var importTable;
    var dataS;
    var courseFlag ='${scoreClass.courseFlag}';
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=KSZT", function (data) {
        dataS = data
    })

    function limitInput(o){
        var value=o.value;
        var min=0;
        var max=10;
        if(parseInt(value)<min||parseInt(value)>max){
            swal({
                title: "输入错误，最高分为10分！",
                type: "info"
            });
            o.value='';
        }
    }

    var dataKCCJ;
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCCJ", function (data) {
        dataKCCJ = data
    })
    $(document).ready(function () {
        importTable = $("#importTable").DataTable({
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' text='checkbox' value='" + row.id + "'/>";
                    }
                },
                {"data": "id", "visible": false},
                {"data": "scoreClassId", "visible": false},
                {"data": "subjectId", "visible": false},
                {"data": "planId", "visible": false},
                {"data": "scoreExamId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "departmentsId",},
                {"data": "majorCode",},
                {"data": "courseId",},
                {"data": "classId",},
                {"data": "personId",},
                {"data": "studentId",},
                {"data": "examMethod",},
                <c:if test="${scoreClass.courseFlag == '01'}">
                {   "data": "peacetimeScoreA",
                    "render": function (data, type, row) {
                        if (row.peacetimeScoreA == null) {
                            row.peacetimeScoreA = ""
                        }
                        return "<input name='" + row.id + "' value='" + row.peacetimeScoreA + "' " +
                            " onkeyup='limitInput(this);' >" ;
                    }
                },
                {   "data": "peacetimeScoreB",
                    "render": function (data, type, row) {
                        if (row.peacetimeScoreB == null) {
                            row.peacetimeScoreB = ""
                        }
                        return "<input name='" + row.id + "' value='" + row.peacetimeScoreB + "' " +
                            " onkeyup='limitInput(this);' >" ;
                    }
                },
                {   "data": "peacetimeScoreC",
                    "render": function (data, type, row) {
                        if (row.peacetimeScoreC == null) {
                            row.peacetimeScoreC = ""
                        }
                        return "<input width='50px' name='" + row.id + "' value='" + row.peacetimeScoreC + "' " +
                            " onkeyup='limitInput(this);' >" ;
                    }
                },
                {   "data": "peacetimeScoreD",
                    "render": function (data, type, row) {
                        if (row.peacetimeScoreD == null) {
                            row.peacetimeScoreD = ""
                        }
                        return "<input width='50px' name='" + row.id + "' value='" + row.peacetimeScoreD+ "' " +
                            " onkeyup='limitInput(this);' >" ;
                    }
                },
                </c:if>
                {
                    "data": "examinationStatus","width":"10%",
                    "render": function (data, type, row) {
                        var html = "<select name='" + row.id + "'>";
                        $.each(dataS, function (index, content) {
                            if (content.text === row.examinationStatus) {
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
                    "data": "score",
                    "render": function (data, type, row) {
                        if(row.courseFlag =='02'){
                            var htm ="<option > </option>";
                            $.each(dataKCCJ, function (index, content) {
                                if (content.id == row.score || content.text == row.score  ) {
                                    htm += "<option value='" + content.id + "' selected>" + content.text + "</option>" ;
                                } else {
                                    htm += "<option value='" + content.id + "'>" + content.text + "</option>" ;
                                }
                            })
                            return "<select name='" + row.id + "'>"+htm+"</select>" ;
                        }else{
                            if (row.score == null) {
                                row.score = ""
                            }
                            return "<input name='" + row.id + "' value='" + row.score + "'>" ;
                        }
                    }
                },
                {"data": "scoreSum",},
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            "scrollY": "400px",
            'order': [5, 'desc'],
            "dom": 'rtlip',
            language: language
        });

        search();
        importTable.on('click', 'tr a', function () {
            var data = importTable.row($(this).parent()).data();
            var aid = data.id;
            var id = data.scoreClassId;
            if (this.id == "addScoreImport") {
                $.get("<%=request.getContextPath()%>/scoreImport/selectScoreImportById?id=" + aid, function (boolean) {
                    if (boolean == true) {
                        $("#dialog").load("<%=request.getContextPath()%>/scoreImport/addScoreImportById?id=" + aid);
                        $("#dialog").modal("show");
                    } else {
                        swal({title: "成绩已经录入不能重复录入！", type: "info"});
                        return;
                    }
                })
            }
            if (this.id == "editScoreImport") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreImport/getScoreImportById?id=" + aid);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteScoreImport") {
                swal({
                    title: "请确认是否要删除本条记录?",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/scoreImport/deleteScoreImportById", {
                        id: aid
                    }, function (msg) {
                        swal({title: msg.msg, type: msg.result});
                        $("#dialog").modal('hide');
                        importTable.ajax.reload();
                    });
                })
            }
        });
    })

    function searchclear() {
        $("#studentIdSel").val("");
        search();
    }

    function search() {
        importTable.ajax.url("<%=request.getContextPath()%>/scoreImport/getScoreClass?scoreClassId=" + $("#scoreClassId").val() + "&subjectId=" + $("#subjectId").val()+
            "&courseId=" + $("#courseId").val() + "&studentName=" + $("#studentIdSel").val()).load();
        exportScore();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreImport/list");
    }

    function showSalaryDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/scoreImport/toImportSalary?scoreClassId=" + $("#scoreClassId").val() + "&subjectId=" + $("#subjectId").val()+
            "&courseId=" + $("#courseId").val()+ "&courseFlag="+courseFlag ) ;
        $("#dialog").modal("show");
    }

    function exportScore() {
        var href = "<%=request.getContextPath()%>/scoreImport/exportScoreImport?scoreClassId=" + $("#scoreClassId").val() + "&subjectId=" + $("#subjectId").val()+
            "&courseId=" + $("#courseId").val() + "&courseFlag="+courseFlag ;
        $("#expScore").attr("href", href);
    }

    function saveScore() {
        var scores = $("#score").serializeArray();
        $.post("<%=request.getContextPath()%>/scoreImport/saveScore?courseFlag="+courseFlag, scores, function (msg) {
            swal({title: msg.msg, type: "success"});
        });
        importTable.ajax.reload();
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
                $.get("<%=request.getContextPath()%>/scoreImport/delScore?ids=" + chk_value, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    }, function () {
                        importTable.ajax.reload();
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

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/12
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<input hidden="hidden" id="subjectId" value="${scoreClass.subjectId}">
<input hidden="hidden" id="examId" value="${scoreClass.examId}">
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="classIdSel" type="text" />
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                考试名称：
                            </div>
                            <div class="col-md-2">
                                <input id="examNameSel" type="text" />
                            </div>
                            <div class="col-md-1 tar">
                                课程：
                            </div>
                            <div class="col-md-2">
                                <input id="courseIdSel" type="text" />
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
                        <%--<button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>--%>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="allot()">设置授课教师
                        </button>
                        <%--<div class="form-row block" style="overflow-y:auto;">
                            <table id="scoreClassGrid" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>--%>
                    </div>
                    <table id="scoreClassGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>
                            <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                            </th>
                            <th>id</th>
                            <th>time</th>
                            <th>subject</th>
                            <th>plan</th>
                            <th>exam</th>
                            <th width="10%">考试名称</th>
                            <th width="10%">系部</th>
                            <th width="10%">专业</th>
                            <th width="10%">班级</th>
                            <th width="10%">课程</th>
                            <th width="10%">教师下属部门</th>
                            <th width="10%">录入教师</th>
                            <th width="10%">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    var scoreClassTable;

    $(document).ready(function () {
        scoreClassTable = $("#scoreClassGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/scoreClass/getScoreClassList',
            },
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.scoreClassId + "'/>";
                    }
                },
                {"data": "scoreClassId", "visible": false},
                {"data": "subjectId", "visible": false},
                {"data": "planId", "visible": false},
                {"data": "scoreExamId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "scoreExamName"},
                {"data": "departmentsId"},
                {"data": "majorCode"},
                {"data": "classId"},
                {"data": "courseId"},
                {"data": "teacherDeptId"},
                {"data": "personId"},
                {
                    "render": function () {
                        return "<a id='updateSalary' class='icon-edit' title='修改录入教师'></a>&nbsp;&nbsp;&nbsp;" +
                            /*"<a id='classAllot' class='icon-bullhorn' title='班级录入设置'></a>&ensp;&ensp;&nbsp;" +
                            */"<a id='deleteSalary' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [3, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });


        scoreClassTable.on('click', 'tr a', function () {
            var data = scoreClassTable.row($(this).parent()).data();
            var id = data.scoreClassId;
            if (this.id == "updateSalary") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreClass/getScoreClassById?scoreClassId=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "viewList") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreClass/viewList?scoreClassId=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "deleteSalary") {
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
                $.post("<%=request.getContextPath()%>/scoreClass/deleteScoreClassById", {
                    scoreClassId: id
                }, function (msg) {
                    swal({title: msg.msg,type: msg.result});
                    $("#dialog").modal('hide');
                    scoreClassTable.ajax.reload();
                });
            })
            }
            if (this.id == "classAllot") {
                $("#dialog").load("<%=request.getContextPath()%>/scoreClass/scoreClassTree", {
                    scoreClassId: id
                });
                $("#dialog").modal("show");
            }
        });
    })


    function searchclear() {

        $("#classIdSel").val("");
        $("#examNameSel").val("");
        $("#courseIdSel").val("");
        scoreClassTable.ajax.url("<%=request.getContextPath()%>/scoreClass/getScoreClassList").load()
    }

    function search() {

        scoreClassTable.ajax.url("<%=request.getContextPath()%>/scoreClass/getScoreClassList?classId="+$("#classIdSel").val()+"&scoreExamName="+$("#examNameSel").val()+"&courseId="+$("#courseIdSel").val()).load();
    }
    /*function back() {
        $("#right").load("/scoreCourse/list?examId="+$("#examId").val());
    }
    function setClass(id) {
        $("#dialog").load("/scoreClass/scoreClassTree", {
            scoreClassId: id
        });
        $("#dialog").modal("show");
    }*/
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }
    function allot() {
        var chk_value = "'";
        if ($('input[name="checkbox"]:checked').length > 0) {
            $('input[name="checkbox"]:checked').each(function () {
                chk_value += $(this).val() + "','";
            });

            $("#dialog").load("<%=request.getContextPath()%>/scoreClass/toScoreClass?scoreClassIds=" + chk_value);
            $("#dialog").modal("show");
        } else {
            swal({title: "请选择要录入的班级！",type: "info"});
        }

    }
</script>

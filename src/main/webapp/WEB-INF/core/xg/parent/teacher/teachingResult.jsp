<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="header">
                        <button type="button" class="btn btn-default btn-clean" id="back"
                                onclick="back()">返回
                        </button>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <header class="mui-bar mui-bar-nav">
                        <h5 class="mui-title"> ${teacherName} > 教师信息</h5>
                    </header>
                    <br>
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active"><a href="#tab8" data-toggle="tab">教师任教信息</a></li>
                        <li><a href="#tab9" data-toggle="tab">教科研成果信息</a></li>
                        <li><a href="#tab10" data-toggle="tab">考核信息</a></li>
                    </ul>
                    <div class="content tab-content">
                        <div class="tab-pane active" id="tab8">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="courseListGrid" cellpadding="0" cellspacing="0"
                                       width="100%" style="max-height: 50%;min-height: 10%;"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab9">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="teachingResultGrid" cellpadding="0" cellspacing="0"
                                       width="100%" style="max-height: 50%;min-height: 10%;"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab10">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="taskResultTable" cellpadding="0" cellspacing="0" width="100%"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="teacherId" hidden value="${teacherId}">
</div>
<script>
    var teachingResultGrid ;
    var courseListGrid ;
    var taskResultTable;
    $(document).ready(function () {
        courseListGrid = $("#courseListGrid").DataTable({
            "data": ${courseList},
            "destroy": true,
            "columns": [
                {"data":"teacherPersonId","visible": false},
                {"data":"teacherPersonName","title":"教师姓名"},
                {"data":"className","title":"所属班级"},
                {"data":"courseShow","title":"任课科目"},
                {"data":"termShow","title":"学期"}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

        teachingResultGrid = $("#teachingResultGrid").DataTable({
            "data": ${teachingResultList},
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "6%", "data": "personId", "title": "姓名"},
                {"width": "12%", "data": "deptId", "title": "所属部门"},
                {"width": "12%", "data": "resultType", "title": "成果类型"},
                {"width": "12%", "data": "creator", "title": "创建人"},
                {"width": "12%", "data": "createDept", "title": "创建部门"},
                {"width": "12%", "data": "createDate", "title": "创建时间"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return  '<span class="icon-tags" title="详细" onclick=getView("' + row.id + '","' + row.resultTypeValue + '")></span>';
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });

        taskResultTable = $("#taskResultTable").DataTable({
            "data": ${evaluationList},
            "destroy": true,
            "columns": [
                {"data": "taskId", "visible": false},
                {"width": "15%", "data": "taskName", "title": "评教任务"},
                {"width": "15%", "data": "planName", "title": "评教方案"},
                {"width": "10%", "data": "term", "title": "学期"},
                {"width": "10%", "data": "groupName", "title": "评委组"},
                {"width": "10%", "data": "taskType", "title": "类型"},
                {"width": "10%", "data": "startTime", "title": "开始时间"},
                {"width": "10%", "data": "endTime", "title": "结束时间"},
/*
                {"width": "10%", "data": "schedule", "title": "进度"},
*/
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return  '<span class="icon-tags" title="详细" ' +
                            'onclick=toEmps("' + row.taskId + '","' + row.taskName + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });

    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/core/parent/toTeacherList");
    }

    function getView(id, resultType) {
        if(resultType == 1 || resultType == '1'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/project",{id:id,flag:"on"});
        }else if(resultType == 2 || resultType == '2'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/standard",{id:id,flag:"on"});
        }else if(resultType == 3 || resultType == '3'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/medicine",{id:id,flag:"on"});
        }else if(resultType == 4 || resultType == '4'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/paper",{id:id,flag:"on"});
        }else if(resultType == 5 || resultType == '5'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/art",{id:id,flag:"on"});
        }else if(resultType == 6 || resultType == '6'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/guide",{id:id,flag:"on"});
        }else if(resultType == 7 || resultType == '7'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/writing",{id:id,flag:"on"});
        }else if(resultType == 8 || resultType == '8'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/patent",{id:id,flag:"on"});
        }else if(resultType == 9 || resultType == '9'){
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/report",{id:id,flag:"on"});
        }
        $("#dialog").modal("show");
    }

    function toEmps(taskId, taskName) {
        $("#dialog").load("<%=request.getContextPath()%>/core/parent/resultEmps", {
            head: '教师考核结果查看',
            taskId: taskId,
            taskName: taskName,
            evaluationType:'1',
            personId:$("#teacherId").val()
        });
        $("#dialog").modal("show");
    }

</script>



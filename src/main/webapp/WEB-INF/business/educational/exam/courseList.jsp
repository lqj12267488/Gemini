<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <input id="examId" name="examId" hidden value="${examId}"/>
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${examName} > 设置考试科目</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="did" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="mid" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                考试科目：
                            </div>
                            <div class="col-md-2">
                                <select id="cid" class="js-example-basic-single"></select>
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
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addCourse()">新增考试科目
                        </button>
                        <br>
                    </div>
                    <table id="courseTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        //系部
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "did");
            });
        //系部联动专业
        $("#did").change(function(){
            var major_sql = "(select distinct major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if($("#did option:selected").val()!="") {
                major_sql+= " and departments_id ='"+$("#did option:selected").val()+"' ";
            }
            major_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "mid");
                })
        });
        //课程
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " course_id",
                text: " course_name ",
                tableName: "T_JW_COURSE",
                orderby: " order by COURSE_ID "
            },
            function (data) {
                addOption(data, "cid");
            });
        table = $("#courseTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/course/getExamCourseList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "examCourseId", "visible": false},
                {"data": "examId", "visible": false},
                {"data": "examType", "visible": false},
                {"data": "courseType", "visible": false},
                {"data": "courseId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data":"courseShow","title":"考试科目"},
                {"data":"courseTypeShow","title":"课程类型"},
                {"data":"startTime","title":"考试开始时间"},
                {"data":"endTime","title":"考试结束时间"},
                {"data":"examMinute","title":"考试时长"},
                {"data":"departmentShow","title":"系部"},
                {"data":"majorShow","title":"专业"},
                {"data":"examTypeShow","title":"考试形式"},
                {"data":"roomShow","title":"教室"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editCourse("' + row.examCourseId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delCourse("' + row.examCourseId + '","'+row.courseShow+'")/>&ensp;&ensp;'+
                            '<span class="icon-flag-checkered" title="设置考试班级" onclick=addExamClass("'+ row.examCourseId +'","'+ row.examId+'","'+row.courseType+'","'+row.departmentsId+'","'+row.courseId+'","'+row.examType+'")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })
    function addExamClass(examCourseId, examId,courseType,departmentsId,courseId,examType) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/course/toAddExamClass", {
            examCourseId: examCourseId,
            examId: examId,
            courseType: courseType,
            departmentsId: departmentsId,
            courseId: courseId,
            examType: examType


        });
        $("#dialog").modal("show");
    }

    function addCourse() {
        $("#dialog").load("<%=request.getContextPath()%>/exam/course/toAdd?start=${start}&end=${end}&examId=${examId}")
        $("#dialog").modal("show")
    }
    function editCourse(id) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/course/toEdit?id=" + id)
        $("#dialog").modal("show")
    }
    function setExamCourse(id) {
        $("#right").load("<%=request.getContextPath()%>/exam/course/setExamCourse?id="+id);
    }

    function delCourse(id,courseShow) {
        swal({
            title: "您确定要删除本条信息?",
            text: "科目名称："+courseShow+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/course/del", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#courseTable').DataTable().ajax.reload();
            });
        })
    }
    function searchclear() {
       $("#did").val("");
       $("#mid").val("");
       $("#cid").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/course/getExamCourseList?examId=${examId}").load();
    }

    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var cid = $("#cid option:selected").val();
        var majorData="";
        var trainingLevel="";
        if (did != undefined || did != null || did=="" ||cid != undefined || cid != null || cid=="") {

            if(mid != undefined || mid != null || mid==""){
                 majorData=mid.split(",")[0];
                 trainingLevel=mid.split(",")[1];
            }
             table.ajax.url("<%=request.getContextPath()%>/exam/course/getExamCourseList?departmentsId="+did+"&majorCode="+majorData+"&trainingLevel="+trainingLevel+"&courseId="+cid+"&examId=${examId}").load();

        }

    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/course");
    }
</script>
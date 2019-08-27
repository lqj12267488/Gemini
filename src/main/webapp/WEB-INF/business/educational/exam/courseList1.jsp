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
<input id="f_examId" name="examId" hidden value="${examId}"/>
<div class="container">
    <div class="row">
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
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addCourse()">新增考试科目
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="allot()">设置考试时间
                        </button>
                    </div>
                    <table id="courseTableGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>
                            <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                            </th>
                            <th>examCourseId</th>
                            <th>examId</th>
                            <th>roomId</th>
                            <th>courseType</th>
                            <th>courseId</th>
                            <th>departmentsId</th>
                            <th width="12%">考场名称</th>
                            <th width="12%">考试科目</th>
                            <th width="12%">课程类型</th>
                            <th width="12%">考试形式</th>
                            <th width="12%">考试开始时间</th>
                            <th width="12%">考试结束时间</th>
                            <th width="12%">考试时长</th>
                            <th width="12%"></th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    var courseTable;

    $(document).ready(function () {
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
        courseTable = $("#courseTableGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/exam/course/getExamCourseAllList?examId='+$("#f_examId").val(),
            },
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='" + row.examCourseId + "'/>";
                    }
                },
                {"data": "examCourseId", "visible": false},
                {"data": "examId", "visible": false},
                {"data": "roomId", "visible": false},
                {"data": "courseType", "visible": false},
                {"data": "courseId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "roomShow"},
                {"data": "courseShow"},
                {"data": "courseTypeShow"},
                {"data": "examTypeShow"},
                {"data": "startTime"},
                {"data": "endTime"},
                {"data": "examMinute"},
                {
                    "render": function () {
                        return "<a id='updateSalary' class='icon-edit' title='添加考试信息'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='checkCourse' class='icon-flag-checkered' title='选择考试科目'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='deleteSalary' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });


        courseTable.on('click', 'tr a', function () {
            var data = courseTable.row($(this).parent()).data();
            var id = data.examCourseId;
            var roomId= data.roomId;
            var roomShow= data.roomShow;
            if (this.id == "updateSalary") {
                $("#dialog").load("<%=request.getContextPath()%>/exam/course/toAdd?examId=${examId}");
                $("#dialog").modal("show");
            }
            if (this.id == "checkCourse") {
                $("#dialog").load("<%=request.getContextPath()%>/exam/course/toAddExamRoomCourse?examId=${examId}&examCourseId=${examCourseId}&examRoomId="+roomId);
                $("#dialog").modal("show")
            }
            if (this.id == "deleteSalary") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "考场名称："+roomShow+"\n\n删除后将无法恢复，请谨慎操作！",
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
                        $('#courseTableGrid').DataTable().ajax.reload();
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
    function addCourse() {
        $("#dialog").load("<%=request.getContextPath()%>/exam/course/toAdd?start=${start}&end=${end}&examId=${examId}")
        $("#dialog").modal("show")
    }

    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        courseTable.ajax.url("<%=request.getContextPath()%>/exam/course/getExamCourseAllList?examId=${examId}").load();
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
        }
        courseTable.ajax.url("<%=request.getContextPath()%>/exam/course/getExamCourseAllList?departmentsId="+did+"&majorCode="+majorData+"&trainingLevel="+trainingLevel+"&courseId="+cid+"&examId=${examId}").load();

    }

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
            swal({title: "请选择要设置考试时间的考试！",type: "info"});
        }

    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/course");
    }
</script>

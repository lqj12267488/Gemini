<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <input id="examId" name="examId" hidden value="${examId}"/>
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${examName} > 查看考试安排</span>
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
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchclear()">清空
                            </button>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <table id="studentArray" cellpadding="0" cellspacing="0" width="100%"
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
                orderby: "  "
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




        table = $("#studentArray").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/array/personal/student/getStudentArrayList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "classId", "visible": false},
                {"data": "courseId", "visible": false},
                {"data": "seatNumber", "visible": false},
                {"data": "studentExamFlag", "visible": false},
                {"data":"courseShow","title":"考试科目"},
                {"data":"roomName","title":"教室"},
                {"data":"departmentShow","title":"系部"},
                {"data":"majorShow","title":"专业"},
                {"data":"classShow","title":"班级"},
                {"data":"studentName","title":"学生"},
                {"data":"startTime","title":"考试开始时间"},
                {"data":"endTime","title":"考试结束时间"},
                {"data":"ticketNumber","title":"准考证号"},
                {"data":"seatNumber","title":"座位"},
                {"data":"flagShow","title":"状态"},
               /* {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editstudentArray("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delstudentArray("' + row.id + '")/>&ensp;&ensp;';
                    }
                }*/
            ],
            'order' : [[2,'desc'],[3,'desc'],[4,'desc'],[5,'desc'],[6,'desc'],[7,'desc']],
            "dom": 'rtlip',
            language: language
        });
    })



    function editstudentArray(id) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/arry/student/toEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function delstudentArray(id) {
        if (confirm("确定要删除这条记录？")) {
            $.get("<%=request.getContextPath()%>/exam/array/del?id=" + id, function (data) {
                swal({title: data.msg, type: "success"});
                $('#studentArray').DataTable().ajax.reload();
            })
        }
    }
    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/array/personal/student/getStudentArrayList?examId=${examId}").load();
    }

    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var cid = $("#cid option:selected").val();
        var majorData="";
        var trainingLevel="";
        if (did != undefined || did != null || did=="") {
            table.ajax.url("<%=request.getContextPath()%>/exam/array/personal/student/getStudentArrayList?departmentsId="+did+"&examId=${examId}").load();
            if(mid != undefined || mid != null || mid==""){
                majorData=mid.substring(0,6);
                trainingLevel=mid.substring(7,mid.length);
                table.ajax.url("<%=request.getContextPath()%>/exam/array/student/getStudentArrayList?departmentsId="+did+"&majorCode="+majorData+"&trainingLevel="+trainingLevel+"&examId=${examId}").load();
                if(cid != undefined || did != null || did==""){
                    table.ajax.url("<%=request.getContextPath()%>/exam/array/student/getStudentArrayList?departmentsId="+did+"&majorCode="+majorData+"&trainingLevel="+trainingLevel+"&courseId="+cid+"&examId=${examId}").load();
                }

            }

        }

    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/personal/student");
    }
</script>
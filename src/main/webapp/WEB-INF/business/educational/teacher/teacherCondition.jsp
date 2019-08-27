<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/12
  Time: 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="departmentId" class="js-example-basic-single"></select>
                            </div>
                            <%--<div class="col-md-1 tar" style="width:100px">--%>
                                <%--专业名称：--%>
                            <%--</div>--%>
                            <%--<div class="col-md-2">--%>
                                <%--<select id="majorCode"/>--%>
                            <%--</div>--%>
                            <div class="col-md-1 tar" style="width:100px">
                                教师姓名:
                            </div>
                            <div class="col-md-2">
                                <input id="teacherName" type="text"/>
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
                                onclick="add()">新增
                        </button>
                        <a id="expdata1" class="btn btn-default btn-clean" >校内专任教师导出</a>
                        <a id="expdata2" class="btn btn-default btn-clean" >校外兼课教师导出</a>
                        <a id="expdata3" class="btn btn-default btn-clean" >校外兼职教师导出</a>
                        <a id="expdata4" class="btn btn-default btn-clean" >校内兼课教师导出</a>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreExamGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var scoreExamTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "departmentId");
            });
        <%--$.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {--%>
            <%--addOption(data, 'departmentsId', '${examTeacherCourse.departmentsId}');--%>
        <%--});--%>
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name ",
                tableName: "t_xg_major"
            },
            function (data) {
                var majorCodeLevel='${examTeacherCourse.majorCode}';
                var majorCode = majorCodeLevel.split(",")[0];
                addOption(data, "majorCode",majorCode);
            });
        $("#departmentId").change(function() {
            if($("#departmentId").val()!=""){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                        id: " distinct id ",
                        text: " name ",
                        tableName: " (select  MAJOR_CODE||','||TRAINING_LEVEL as id ," +
                        " MAJOR_NAME||' -- '||FUNC_GET_DICVALUE(TRAINING_LEVEL,'ZXZYPYCC') as name " +
                        "from T_XG_MAJOR where 1 = 1 and DEPARTMENTS_ID = '"+$("#departmentId").val()+"'  ) ",
                        where: " ",
                        orderby: " "
                    },
                    function (data1) {
                        addOption(data1, "majorCode", '${examTeacherCourse.majorCode}');
                    })
            }
        });
        <%--$.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {--%>
            <%--addOption(data, 'selTerm');--%>
        <%--});--%>
        search();
        scoreExamTable.on('click', 'tr a', function () {
            var data = scoreExamTable.row($(this).parent()).data();
            var teacherId = data.teacherId;
            var teacherName = data.teacherName;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/teacher/editTeacherCondition?teacherId=" + teacherId);
                $("#dialog").modal("show");
            }
            if (this.id == "delete") {
                swal({
                    title: "您确定要删除本条教师记录吗?",
                    text: "教师姓名："+teacherName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/teacher/deleteTeacherInfoById", {
                        teacherId: teacherId
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        scoreExamTable.ajax.reload();
                    });
                })
            }
        });
        exportDate1();
        exportDate2();
        exportDate3();
        exportDate4();
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teacher/editTeacherCondition" );
        $("#dialog").modal("show");
    }
    function searchclear() {
        $("#departmentId").val("");
        $("#teacherName").val("");
        $("#majorCode").val("");
        search();
    }
    function search() {
        var departmentId = $("#departmentId").val();
        var teacherName = $("#teacherName").val();
        var majorCode=$("#majorCode").val();
        // alert(teacherName)
        scoreExamTable = $("#scoreExamGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/teacher/getTeacherInfoList',
                "data":{
                    departmentId: departmentId,
                    teacherName: teacherName,
                    major:majorCode,
                    teacherId:'${teacherId}'
                }
            },
            "destroy": true,
            "columns": [
                {"data": "teacherId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"17%","data": "teacherName", "title": "姓名"},
                {"width":"17%","data": "birthday", "title": "出生日期"},
                {"width":"17%","data": "finalEducation", "title": "学历"},
                {"width":"16%","data": "degee", "title": "学位"},
                // {"width":"12%","data": "majorShow", "title": "最后学历专业"},
                // {"width":"12%","data": "title", "title": "职称"},
                {"width":"17%","data": "teacherCategoryShow", "title": "教师类别"},
                {"width":"16%","title": "操作","render": function () {return "<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" ;}}
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
    /*导出方法*/
    function exportDate1(){
        var hhh = "<%=request.getContextPath()%>/teacher/toExportDate?teacherType=1";
        $("#expdata1").attr("href",hhh);
    }
    function exportDate2(){
        var hhh = "<%=request.getContextPath()%>/teacher/toExportDate?teacherType=2";
        $("#expdata2").attr("href",hhh);
    }
    function exportDate3(){
        var hhh = "<%=request.getContextPath()%>/teacher/toExportDate?teacherType=3";
        $("#expdata3").attr("href",hhh);
    }
    function exportDate4(){
        var hhh = "<%=request.getContextPath()%>/teacher/toExportDate?teacherType=4";
        $("#expdata4").attr("href",hhh);
    }
</script>
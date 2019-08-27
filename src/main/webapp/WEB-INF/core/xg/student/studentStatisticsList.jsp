<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/26
  Time: 15:29
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
                               系部:
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsId"/>
                            </div>
                            <div id = "status">
                            <div  class="col-md-1 tar">
                               专业:
                            </div>
                            <div class="col-md-2">
                                <select id="majorId"/>
                            </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                培养层次:
                            </div>
                            <div class="col-md-2">
                                <select id="trainingLevel"/>
                            </div>
                                <div  class="col-md-1 tar">
                                    性别:
                                </div>
                                <div class="col-md-2">
                                    <select id="sex"/>
                                </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                民族:
                            </div>
                            <div class="col-md-2">
                                <select id="nation"/>
                            </div>
                            <div class="col-md-1 tar">
                                政治面貌:
                            </div>
                            <div class="col-md-2">
                                <select id="politicalStatus"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">统计
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchClear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <div  id="LogGrid">
                        <table id="studentGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                        </div>
                        <div id="LogGridGroup" style="display: none">
                        <table id="studentGridGroup" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script>
    var studentGrid;
    var studentGridGroup;
    var aa;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "departmentsId");
            });
        $("#departmentsId").change(function(){
            //系部联动专业
            var departmentsId= $("#departmentsId option:selected").val();
            var major_sql = "(select distinct major_code code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if(departmentsId!=null) {
                major_sql+= " and departments_id ='"+departmentsId+"' ";
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
                    addOption(data, "majorId");
                })
        });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYPYCC", function (data) {
                addOption(data, 'trainingLevel');

            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
                addOption(data, 'nation');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
                 addOption(data,'sex');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
                addOption(data, "politicalStatus");
            });
        studentTable = $("#studentGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/student/getStudentList',
                "data": {}
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"width": "10%", "data": "studentNumber", "title": "学籍号"},
                {"width": "10%", "data": "name", "title": "学生姓名"},
                {"width": "25%","data": "userAccount", "title": "登录账号"},
                {"width": "10%", "data": "sexShow", "title": "性别"},
                {"width": "25%", "data": "idcard", "title": "身份证号"},
                {"width": "10%", "data": "birthday", "title": "出生日期"},
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    });

    function searchClear() {
        $("#LogGridGroup").css("display","none");
        $("#LogGrid").css("display","block");
        $("#departmentsId").val("");
        $("#majorId").val("");
        $("#trainingLevel").val("");
        $("#sex").val("");
        $("#nation").val("");
        $("#politicalStatus").val("");
        studentTable.ajax.url("<%=request.getContextPath()%>/student/getStudentList").load();
    }

    function search() {
        var departmentsId = $("#departmentsId option:selected").val();
        var majorId = $("#majorId option:selected").val();
        var sex = $("#sex option:selected").val();
        var trainingLevel = $("#trainingLevel option:selected").val();
        var nation = $("#nation option:selected").val();
        var politicalStatus = $("#politicalStatus option:selected").val();
        $("#LogGrid").css("display","none");
        $("#LogGridGroup").css("display","block");
        studentGridGroup = $("#studentGridGroup").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/core/student/getStudentStatisticsList',
                "data": {
                    departmentsId: departmentsId,
                    majorCode: majorId,
                    sex:sex,
                    trainingLevel:trainingLevel,
                    nation:nation,
                    politicalStatus:politicalStatus,
                    departmentShow:$("#departmentsId option:selected").text(),
                    majorShow:$("#majorId option:selected").text(),
                    sexShow:$("#sex option:selected").text(),
                    trainingLevelShow:$("#trainingLevel option:selected").text(),
                    nationShow:$("#nation option:selected").text(),
                    politicalStatusShow:$("#politicalStatus option:selected").text()
                }
            },
            "initComplete": function() {
                if (departmentsId==""||departmentsId==undefined){
                    $(".hiddenCol").css("display","none");
                }else {
                    $(".hiddenCol").css("display", "");
                }
                if(majorId==""||majorId==undefined){
                    $(".hiddenCol2").css("display","none");
                }else {
                    $(".hiddenCol2").css("display", "");
                }
                if(trainingLevel==""||trainingLevel==undefined){
                    $(".hiddenCol3").css("display","none");
                }else {
                    $(".hiddenCol3").css("display", "");
                }
                if(sex==""||sex==undefined){
                    $(".hiddenCol4").css("display","none");
                }else {
                    $(".hiddenCol4").css("display", "");
                }
                if(nation==""||nation==undefined){
                    $(".hiddenCol5").css("display","none");
                }else {
                    $(".hiddenCol5").css("display", "");
                }
                if(politicalStatus==""||politicalStatus==undefined){
                    $(".hiddenCol6").css("display","none");
                }else {
                    $(".hiddenCol6").css("display", "");
                }
            },
            "destroy": true,
            "columns": [
                {"data":"departmentsId","title":"系部",sClass:"hiddenCol"},
                {"data":"majorCode","title":"专业",sClass:"hiddenCol2"},
                {"width":"16%","data":"trainingLevel","title":"培养层次",sClass:"hiddenCol3"},
                {"width":"16%","data":"sex","title":"性别",sClass:"hiddenCol4"},
                {"width":"16%","data":"nation","title":"民族",sClass:"hiddenCol5"},
                {"width":"16%","data":"politicalStatus","title":"政治面貌",sClass:"hiddenCol6"},
                {"data":"studentCount","title":"学生数量"},
            ],
            'order': [0, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
</script>

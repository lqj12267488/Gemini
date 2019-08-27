<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/31
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <input id="hiddenYear" name="hiddenYear" type="hidden" value="${year}">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部:
                            </div>
                            <div class="col-md-2">
                                <select id="did" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业:
                            </div>
                            <div class="col-md-2">
                                <select id="mid" class="js-example-basic-single"></select>
                            </div>
                        </div>
                    </div>
                    <div class="content block-fill-white" >
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                开始招生年份:
                            </div>
                            <div class="col-md-2">
                                <select id="startYear" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                结束招生年份:
                            </div>
                            <div class="col-md-2">
                                <select id="endYear" class="js-example-basic-single"></select>
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
                <div class="block block-drop-shadow">
                    <div class="content">
                       <%-- <div class="form-row">
                            <div class="col-md-12">
                                <a id="expdata" class="btn btn-info btn-clean" >导出</a>
                            </div>
                        </div>--%>
                        <div class="form-row block" style="overflow-y: auto;">
                            <table id="enrollmentGrid" cellpadding="0" cellspacing="0" width="100%"
                                   style="max-height: 50%;min-height: 10%;"
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
    var enrollmentTable;
    $(document).ready(function () {
        var did=  $("#did option:selected").val();
        if(did == null || did==undefined){
            $("#mid").html("<option value=''>请选择系部</option>");
        }
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
            var did= $("#did option:selected").val();
            var major_sql = "(select distinct major_code || ',' || training_level code,major_name ||  '--' ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if(did!=null) {
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYPYCC", function (data) {
            addOption(data, 'tid');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'startYear',$("#hiddenYear").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'endYear');
        });
        enrollmentTable = $("#enrollmentGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/enrollment/getMajorEnrollmentList?startYear='+$("#hiddenYear").val()
            },
            "destroy": true,
            "columns": [
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"width": "10%", "data": "departmentShow", "title": "系部"},
                {"width": "10%", "data": "majorShow", "title": "专业"},
                {"width": "10%", "data": "planNumber", "title": "计划招生人数"},
                {"width": "10%", "data": "realNumber", "title": "报到总人数"},
            ],
            'order' : [[0,'asc'],[1,'desc'],[2,'desc']],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        exportEnrollmentCount();
    });



    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var startYear = $("#startYear option:selected").val();
        var endYear = $("#endYear option:selected").val();
        var majorCode=mid.split(",")[0];
        var trainingLevel=mid.split(",")[1];
        enrollmentTable.ajax.url("/enrollment/getMajorEnrollmentList?departmentsId="+did+"&majorCode="+majorCode+"&trainingLevel="+trainingLevel+"&startYear="+startYear+"&endYear="+endYear).load();

    }

    function searchclear() {
        $("#did option:selected").val("");
        $("#mid option:selected").val("");
        $("#did").val("");
        $("#mid").val("");
        $("#mid").html("<option value=''>请选择系部</option>");
        $("#startYear").val($("#hiddenYear").val());
        $("#endYear").val("");
        enrollmentTable.ajax.url("/enrollment/getMajorEnrollmentList").load();

    }

    function exportEnrollmentCount(){
        var  hiddenYear=$("#hiddenYear").val();
        var hhh = "/enrollment/exportEnrollmentCount?year="+hiddenYear;
        $("#expdata").attr("href",hhh);
    }
</script>




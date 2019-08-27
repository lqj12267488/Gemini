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
                            <div class="col-md-1 tar">
                                培养层次:
                            </div>
                            <div class="col-md-2">
                                <select id="tid" class="js-example-basic-single"></select>
                            </div>
                        </div>
                    </div>
                    <div class="content block-fill-white" >
                        <div class="form-row">

                            <div class="col-md-1 tar">
                                学制:
                            </div>
                            <div class="col-md-2">
                                <select id="system" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                招生年份:
                            </div>
                            <div class="col-md-2">
                                <select id="year" class="js-example-basic-single"></select>
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
                        <%--<div class="form-row">
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
    var dothis ="<a id='searchCountDetails' class='icon-search' title='查看详细'></a>";
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
            var major_sql = "(select distinct major_code code,major_name  value from t_xg_major where 1=1  and valid_flag = 1";
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
            addOption(data, 'year',$("#hiddenYear").val());
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYXZ", function (data) {
            addOption(data, 'system');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYFX", function (data) {
            addOption(data, 'derection');
        });
        enrollmentTable = $("#enrollmentGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/enrollment/getEnrollmentList?flag=count'
            },
            "destroy": true,
            "columns": [
                {"data": "majorId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "majorDirection", "visible": false},
                {"data": "schoolSystem", "visible": false},
                {"width": "10%", "data": "departmentShow", "title": "系部"},
                {"width": "10%", "data": "majorShow", "title": "专业"},
                {"width": "10%", "data": "directionShow", "title": "专业方向"},
                {"width": "10%", "data": "trainingLevelShow", "title": "培养层次"},
                {"width": "10%", "data": "schoolSystemShow", "title": "学制"},
                {"width": "10%", "data": "issuingUnit", "title": "发证单位"},
                {"width": "10%", "data": "year", "title": "招生年份"},
                {"width": "10%", "data": "planNumber", "title": "计划招生人数"},
                {"width": "10%", "data": "realNumber", "title": "报到总人数"},
                //{"width": "10%", "data": "learningTypeShow", "title": "学习形式"},
                //{"width": "10%", "data": "classAmount", "title": "班级数"},
                {"width":"10%","title": "操作","render": function () {return dothis;}}
            ],
            'order' : [[1,'asc'],[2,'desc'],[3,'desc'],[4,'desc'],[5,'desc']],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        enrollmentTable.on('click', 'tr a', function () {
            var data = enrollmentTable.row($(this).parent()).data();
            var majorId = data.majorId;
            var year = data.year;
            if (this.id == "searchCountDetails") {
                $("#dialog").load("<%=request.getContextPath()%>/enrollment/searchCountDetails?majorId="+majorId+"&year="+year);
                $("#dialog").modal("show");
            }
        });
        exportEnrollmentCount();
    });



    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var tid = $("#tid option:selected").val();
        var system = $("#system option:selected").val();
        var year = $("#year option:selected").val();
         enrollmentTable.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentList?departmentsId="+did+"&majorCode="+mid+"&trainingLevel="+tid+"&schoolSystem="+system+"&year="+year).load();

    }

    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#tid").val("");
        $("#system").val("");
        $("#year").val($("#hiddenYear").val());
        enrollmentTable.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentList?flag=count").load();

    }

    function exportEnrollmentCount(){
        var  hiddenYear=$("#hiddenYear").val();
        var hhh = "<%=request.getContextPath()%>/enrollment/exportEnrollmentCount?year="+hiddenYear;
        $("#expdata").attr("href",hhh);
    }
</script>




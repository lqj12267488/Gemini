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
                                学制:
                            </div>
                            <div class="col-md-2">
                                <select id="system" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                培养层次:
                            </div>
                            <div class="col-md-2">
                                <select id="tid" class="js-example-basic-single"></select>
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
                        <div class="form-row">
                            <div class="col-md-12">
                                <a id="expdata" class="btn btn-info btn-clean" >导出</a>
                            </div>
                        </div>
                        <div class="form-row block" style="overflow-y: auto;">
                            <table id="registerCountGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var registerCountTable;
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
            var major_sql = "(select distinct major_code  code,major_name  value from t_xg_major where 1=1  and valid_flag = 1";
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYXZ", function (data) {
            addOption(data, 'system');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYFX", function (data) {
            addOption(data, 'derection');
        });
        registerCountTable = $("#registerCountGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/enrollment/getEnrollmentList?flag=first'
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
                {"width": "10%", "data": "trainingLevelShow", "title": "培养层次"},
                {"width": "10%", "data": "directionShow", "title": "专业方向"},
                {"width": "10%", "data": "schoolSystemShow", "title": "学制"},
                {"width": "10%", "data": "year", "title": "招生年份"},
                {"width": "10%", "data": "planNumber", "title": "计划招生人数"},
                {"width": "10%", "data": "realNumber", "title": "报到总人数"},
            ],
            'order' : [[1,'desc'],[2,'desc'],[3,'desc'],[4,'desc'],[5,'desc']],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        exportEnrollmentCount();
    });



    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var tid = $("#tid option:selected").val();
        var system = $("#system option:selected").val();
        if (did != null || mid!= null  || system != null || tid!= null) {
            registerCountTable.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentList?departmentsId="+did+"&majorCode="+mid+"&trainingLevel="+tid+"&schoolSystem="+system).load();
        }

    }

    function searchclear() {
        $("#did option:selected").val("");
        $("#mid option:selected").val("");
        $("#tid option:selected").val("");
        $("#did").val("");
        $("#mid").val("");
        $("#tid").val("");
        $("#mid").html("<option value=''>请选择系部</option>");
        $("#system").val("");
        registerCountTable.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentList?flag=first").load();
        var did=  $("#did option:selected").val();
        if(did == null){
            $("#mid").html("<option>请选择系部</option>");
        }
    }

    function exportEnrollmentCount(){
        var  hiddenYear=$("#hiddenYear").val();
        var hhh = "<%=request.getContextPath()%>/enrollment/exportEnrollmentCount?year="+hiddenYear;
        $("#expdata").attr("href",hhh);
    }
</script>




<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                                <select id="f_dept"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="f_major"/>
                            </div>
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <select id="f_class"/>
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
                                onclick="exportSurvey()">导出
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="surveytable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var surveytable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "f_dept");
            });
        //系部联动专业
        $("#f_dept").change(function () {
            var major_sql = "(select distinct major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if ($("#f_dept option:selected").val() != "") {
                major_sql += " and departments_id ='" + $("#f_dept option:selected").val() + "' ";
            }
            major_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "f_major");
                })
        });
        //专业联动班级
        $("#f_major").change(function () {
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if ($("#f_major option:selected").val() != "") {
                class_sql += "and major_code ='" + $("#f_major option:selected").val().split(",")[0] + "' and training_level='" + $("#f_major option:selected").val().split(",")[1] + "' ";
            }
            class_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: class_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "f_class");
                })
        });
        surveytable = $("#surveytable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/survey/getSurveyStatisticsEditList?surveyId=${surveyId}',
            },
            "destroy": true,
            "columns": [
                {"data": "surveyId", "visible": false},
                {"data": "dept", "title": "系部"},
                {"data": "major", "title": "专业"},
                {"data": "classes", "title": "班级"},
                {"data": "numberSurvey", "title": "已做调查人数"},
                {"data": "numberNotSurvey", "title": "未做调查人数"},
            ],
            "dom": 'rtlip',
            language: language
        });
    })


    function searchclear() {
        $("#f_dept").val("");
        $("#f_dept option:selected").val("");
        $("#f_major").val("");
        $("#f_major option:selected").val("");
        $("#f_class").val("");
        $("#f_class option:selected").val("");
        search();
    }

    function search() {
        var dept = $("#f_dept option:selected").val();
        if(null == dept || undefined == dept){
            dept = "";
        }
        var major = $("#f_major option:selected").val();
        if(null == major || undefined == major){
            major = "";
        }else{
            major = major.split(",")[0];
        }
        var classes = $("#f_class option:selected").val();
        if(null == classes || undefined == classes){
            classes = "";
        }
        surveytable.ajax.url("<%=request.getContextPath()%>/survey/getSurveyStatisticsEditList?surveyId=${surveyId}&departmentsId=" + dept + "&majorCode=" + major + "&personDept=" + classes).load();
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/survey/toSurveyStatisticsList");
    }
    function exportSurvey() {
        window.location.href = "<%=request.getContextPath()%>/survey/exportSurvey?surveyId=${surveyId}";
    }
</script>
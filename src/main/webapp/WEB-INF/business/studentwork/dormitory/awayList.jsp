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
                                    班级：
                                </div>
                                <div class="col-md-2">
                                    <select id="cid" class="js-example-basic-single"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="content block-fill-white" >
                        <div class="col-md-1 tar" >
                            寝室：
                        </div>
                        <div class="col-md-2">
                            <select id="dormv" />
                        </div>
                        <div class="col-md-1 tar" >
                            学生姓名：
                        </div>
                        <div class="col-md-2">
                            <input id="stu_name"  type="text"
                                   class="validate[required,maxSize[20]] form-control"/>
                        </div>
                        <div class="col-md-1 tar" >
                            旷寝时间：
                        </div>
                        <div class="col-md-2">
                            <input id="away_time" type="date"
                                   class="validate[required,maxSize[20]] form-control"/>
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
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addAway()">新增旷寝
                        </button>
                        <br>
                    </div>
                    <table id="awayGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">

                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var awayTable;
    $(document).ready(function () {
        //学生姓名自动提示框初始化
        $.get("<%=request.getContextPath()%>/exam/studuent/autoCompleteStudent", function (data) {
            $("#stu_name").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#stu_name").val(ui.item.label);
                    $("#stu_name").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });
        //寝室下拉初始化
        var qs_sql = "(select id code,DORM_NAME  value from T_JW_DORM where 1 = 1  and valid_flag = 1 order by DORM_TYPE  ,CREATE_TIME desc";
        qs_sql+=")";
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " code ",
                text: " value ",
                tableName: qs_sql,
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "dormv");
            })
        //系部下拉初始化
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
        //专业联动班级
        $("#mid").change(function(){
            var mid= $("#mid option:selected").val();
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if($("#mid option:selected").val()!="") {
                var majorCode=mid.split(",")[0];
                var trainingLevel=mid.split(",")[1];
                class_sql+= "and major_code ='"+majorCode+"' and training_level='"+trainingLevel+"' ";
            }
            class_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: class_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "cid");
                })

        });
    })


    $(document).ready(function () {
        awayTable = $("#awayGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/student/dorm/getAwayList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "dormId", "visible": false},
                {"data": "studentId", "visible": false},
                {"data":"departmentShow","title":"系部"},
                {"data":"majorShow","title":"专业"},
                {"data":"classShow","title":"班级"},
                {"data":"studentName","title":"学生姓名"},
                {"data":"dormName","title":"寝室"},
                {"data":"awayTime","title":"旷寝时间"},
                {"data":"awayReason","title":"旷寝原因"},
            ],
            'order' : [[1,'desc'],[2,'desc'],[3,'desc'],[4,'desc'],[5,'desc'],[6,'desc']],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    })


    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        $("#stu_name").val("");
        $("#dormv").val("");
        $("#away_time").val("");
        awayTable.ajax.url("<%=request.getContextPath()%>/student/dorm/getAwayList").load();
    }

    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var cid = $("#cid option:selected").val();
        var dormv = $("#dormv option:selected").val();
        var stu_name= $("#stu_name").val();
        var date = $("#away_time").val();
        var majorData="";
        var trainingLevel="";
        awayTable.ajax.url("<%=request.getContextPath()%>/student/dorm/getAwayList?departmentsId="+did+
            "&majorCode="+majorData+"&trainingLevel="+trainingLevel+"&classId="+cid+
            "&studentName="+stu_name+"&dormId="+dormv+"&awayTime="+date).load();



    }
    function addAway() {
        $("#dialog").load("<%=request.getContextPath()%>/student/dorm/away/toAdd")
        $("#dialog").modal("show")
    }
</script>

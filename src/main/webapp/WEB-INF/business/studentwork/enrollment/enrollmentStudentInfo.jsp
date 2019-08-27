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
                                学籍号
                            </div>
                            <div class="col-md-2">
                                <input id="studentNumber" type="text" />
                            </div>
                            <div class="col-md-1 tar">
                                学生姓名
                            </div>
                            <div class="col-md-2">
                                <input id="name" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                身份证号
                            </div>
                            <div class="col-md-2">
                                <input id="idcard" type="text"    class="validate[required,minSize[5],maxSize[10]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                性别
                            </div>
                            <div class="col-md-2">
                                <select id="sex" class="js-example-basic-single"></select>
                            </div>
                        </div>

                    <div class="form-row">

                        <%--<div class="col-md-1 tar">
                            学籍状态
                        </div>
                        <div class="col-md-2">
                            <select id="studentStatus" />
                        </div>--%>
                        <div class="col-md-1 tar">
                            入学年份
                        </div>
                        <div class="col-md-2">
                            <select id="year"  class="js-example-basic-single" ></select>
                        </div>
                        <div class="col-md-1 tar">
                            入学月份
                        </div>
                        <div class="col-md-2">
                            <select id="month" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-1 tar">
                            民族
                        </div>
                        <div class="col-md-2">
                            <select id="nation" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-1 tar">
                            政治面貌
                        </div>
                        <div class="col-md-2">
                            <select id="politicalstatus" class="js-example-basic-single"></select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-1 tar">
                            系部
                        </div>
                        <div class="col-md-2">
                            <select id="did" />
                        </div>
                        <div class="col-md-1 tar">
                            专业
                        </div>
                        <div class="col-md-2">
                            <select id="mid"/>
                        </div>
                        <div class="col-md-1 tar">
                            班级
                        </div>

                        <div class="col-md-2">
                            <select id="cid"></select>
                        </div>
                        <div class="col-md-1 tar">
                            国籍
                        </div>
                        <div class="col-md-2">
                            <select id="nationality"  class="js-example-basic-single" ></select>
                        </div>
                    </div>

                        <div class="col-md-1 tar">
                            籍贯省
                        </div>
                        <div class="col-md-2">
                            <select id="province" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-1 tar">
                            籍贯市
                        </div>
                        <div class="col-md-2">
                            <select id="city" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-1 tar">
                            籍贯县(区)
                        </div>
                        <div class="col-md-2">
                            <select id="county" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-2" >
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchclear()">清空
                            </button>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content">
                        <div class="form-row block" style="overflow-y: auto;">
                            <table id="studentInfoGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var studentInfoTable;
    var dothis ="<a id='studentDetails' class='icon-search' title='详细信息'></a>"
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, "nation");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GJ", function (data) {
            addOption(data, "nationality");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, "politicalstatus");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sex');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YF", function (data) {
            addOption(data, 'month');
        });
        //省份初始化
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " name ",
                tableName: "T_SYS_ADMINISTRATIVE_DIVISIONS ",
                where: " WHERE valid_flag = '1' and  type = '1' ",
                orderby: " order by show_order ",
            },
            function (data) {
                addOption(data, "province");
            });
        //省联市
        $("#province").change(function(){
            var province= $("#province option:selected").val();
            var city_sql = "(select  id  code,name value from T_SYS_ADMINISTRATIVE_DIVISIONS where 1=1  and valid_flag = 1";
            if(province!=null) {
                city_sql+= " and parent_id = '"+province+"' and type = '2' ";
            }
            city_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: city_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "city");
                })
        });
        //市联县
        $("#city").change(function(){
            var city= $("#city option:selected").val();
            var county_sql = "(select  id  code,name value from T_SYS_ADMINISTRATIVE_DIVISIONS where 1=1  and valid_flag = 1";
            if(city!=null) {
                county_sql+= " and parent_id = '"+city+"' and type = '3' ";
            }
            county_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: county_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "county");
                })
        });
        //系部
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 "
             },
            function (data) {
                addOption(data, "did");
            });
         //系部联动专业、班级
        $("#did").change(function(){
            //系部联动专业
            var did= $("#did option:selected").val();
            var major_sql = "(select distinct major_code || ',' || major_direction  || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if(did!=null) {
                major_sql+= " and departments_id ='"+did+"' ";
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
            //系部切换重新加载班级
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if(did !=null && did!="" ) {
                class_sql+= " and departments_id ='"+did+"' ";
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
            }
        });
        //专业联动班级
        $("#mid").change(function(){
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if($("#mid option:selected").val()!=null) {
                var mid=$("#mid option:selected").val();
                var majorCode=mid.split(",")[0];
                var majorDirection=mid.split(",")[1];
                var trainingLevel=mid.split(",")[2];
                class_sql+= " and major_code ='"+majorCode+"' and major_direction='"+majorDirection+"' and training_level='"+trainingLevel+"' ";
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
        var did=  $("#did option:selected").val();
        var mid=  $("#mid option:selected").val();
        if(did == null || did==undefined){
            $("#mid").html("<option value=''>请选择系部</option>");
        }
        if(mid == null || mid==undefined){
            $("#cid").html("<option value=''>请选择专业</option>");
        }
        var province=  $("#province option:selected").val();
        var city=  $("#city option:selected").val();
        if(province == null || province==undefined){
            $("#city").html("<option value=''>请选择省份</option>");
        }
        if(city == null || city==undefined){
            $("#county").html("<option value=''>请选择市</option>");
        }
        studentInfoTable = $("#studentInfoGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/enrollment/getStudentInfoList'
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"width": "10%","data": "studentNumber", "title": "学籍号"},
                {"width": "10%","data": "name", "title": "学生姓名"},
                {"width": "12%","data": "idcard", "title": "身份证号"},
                {"width": "8%","data": "sexShow", "title": "性别"},
                {"width": "10%","data": "joinYear", "title": "入学年份"},
                {"width": "10%","data": "joinMonth", "title": "入学月份"},
                {"width": "10%","data": "departmentShow", "title": "系部"},
                {"width": "10%","data": "majorShow", "title": "专业"},
                {"width": "10%","data": "classShow", "title": "班级"},
                {"width":"10%","title": "操作","render": function () {return dothis;}}
               /* {"width": "10%","data": "provinceShow", "title": "籍贯省"},
                {"width": "10%","data": "cityShow", "title": "籍贯市"},
                {"width": "10%","data": "countyShow", "title": "籍贯县"},
                {"data": "nationalityShow", "title": "国籍"},
                {"data": "nationShow", "title": "民族"},
                {"data": "politicalStatusShow", "title": "政治面貌"}*/
            ],
            'order' : [[0,'asc'],[1,'desc'],[2,'desc']],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        studentInfoTable.on('click', 'tr a', function () {
            var data = studentInfoTable.row($(this).parent()).data();
            var studentId = data.studentId;
            if (this.id == "studentDetails") {
                $("#dialog").load("<%=request.getContextPath()%>/enrollment/studentDetails?studentId="+studentId);
                $("#dialog").modal("show");

            }
        });
    });



    function search() {
        var studentNumber=$("#studentNumber").val();
        var name=$("#name").val();
        var idcard=$("#idcard").val();
        //var tel=$("#tel").val();
        var sex=$("#sex option:selected").val();
        //var studentStatus=$("#studentStatus option:selected").val();
        var year=$("#year option:selected").val();
        var month=$("#month option:selected").val();
        var nationality=$("#nationality option:selected").val();
        var nation=$("#nation option:selected").val();
        var politicalstatus=$("#politicalstatus option:selected").val();
        var province=$("#province option:selected").val();
        var city=$("#city option:selected").val();
        var county=$("#county option:selected").val();
        var did=$("#did option:selected").val();
        var mid=$("#mid option:selected").val();
        var majorCode=mid.split(",")[0];
        var majorDirection=mid.split(",")[1];
        var trainingLevel=mid.split(",")[2];
        var cid=$("#cid option:selected").val();
        //alert(studentstatus)
        //alert(tel)
        studentInfoTable.ajax.url("<%=request.getContextPath()%>/enrollment/getStudentInfoList?studentNumber="+studentNumber+"&name="+name+"&idcard="+idcard+
                /* +studentStatus+"&tel="+tel*/
            "&sex="+sex+"&studentStatus="+
            "&joinYear="+year+"&joinMonth="+month+
            "&nationality="+nationality+"&nation="+nation+"&politicalStatus="+politicalstatus+
            "&houseProvince="+province+"&houseCity="+city+"&houseCounty="+county+
            "&departmentsId="+did+"&majorCode="+majorCode+"&majorDirection="+majorDirection+
            "&trainingLevel="+trainingLevel+"&classId="+cid).load();
    }

    function searchclear() {
        $("#politicalstatus option:selected").val("");
        $("#did option:selected").val("");
        $("#mid option:selected").val("");
        $("#cid option:selected").val("");
        $("#county option:selected").val("");
        $("#city option:selected").val("");
        $("#province option:selected").val("");
        $("#studentNumber").val("");
        $("#name").val("");
        $("#idcard").val("");
        $("#tel").val("");
        $("#sex").val("");
        $("#studentStatus").val("");
        $("#tel").val("");
        $("#year").val("");
        $("#month").val("");
        $("#nationality").val("");
        $("#nation").val("");
        $("#province").val("");
        $("#city").val("");
        $("#county").val("");
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        $("#mid").html("<option value=''>请选择系部</option>");
        $("#cid").html("<option value=''>请选择专业</option>");
        $("#city").html("<option value=''>请选择省份</option>");
        $("#county").html("<option value=''>请选择市</option>");
        studentInfoTable.ajax.url("<%=request.getContextPath()%>/enrollment/getStudentInfoList").load();

    }


</script>




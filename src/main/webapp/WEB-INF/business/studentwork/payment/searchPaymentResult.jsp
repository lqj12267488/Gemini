<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/31
  Time: 19:55
  To change this template use File | Settings | File Templates.
--%>
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
                <input id="planId" name="planId" hidden value="${planId}"/>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
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
                                    班级:
                                </div>
                                <div class="col-md-2">
                                    <select id="cid" class="js-example-basic-single"></select>
                                </div>
                            </div>

                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                姓名:
                            </div>
                            <div class="col-md-2">
                                <input class="validate[required,maxSize[20]] form-control"
                                       id="name" type="text" placeholder="请输入学生姓名" />
                            </div>
                            <div class="col-md-1 tar">
                                缴费项目:
                            </div>
                            <div class="col-md-2">
                                <select id="item"  />
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
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <a id="expdata" class="btn btn-info btn-clean" >导出结果</a>
                    </div>

                    <table id="resultTable" cellpadding="0" cellspacing="0" width="100%"
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
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=JFXM", function (data) {
            addOption(data, 'item');
        });
        var did=  $("#did option:selected").val();
        var mid=  $("#mid option:selected").val();
        if(did == null || did==undefined){
            $("#mid").html("<option value=''>请选择系部</option>");
        }
        if(mid == null || mid==undefined){
            $("#cid").html("<option value=''>请选择专业</option>");
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
        //系部联动专业、班级
        $("#did").change(function(){
            //系部联动专业
            var did= $("#did option:selected").val();
            var major_sql = "(select distinct major_code || ',' || major_direction  || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(major_direction, 'ZXZYFX')  ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if(did!=null) {
                major_sql+= " and departments_id ='"+did+"' ";
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
            }
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
            var mid= $("#mid option:selected").val();
            var did= $("#did option:selected").val();
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if(did !=null && did!="" && mid!=null && mid!="") {
                var mid=$("#mid option:selected").val();
                var majorCode=mid.split(",")[0];
                var majorDirection=mid.split(",")[1];
                var trainingLevel=mid.split(",")[2];
                class_sql+= " and major_code ='"+majorCode+"' and major_direction='"+majorDirection+"' and training_level='"+trainingLevel+"' ";
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
        table = $("#resultTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/payment/info/getStandardList?planId=${planId}'
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "majorDirection", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "classId", "visible": false},
                {"data": "itemId", "visible": false},
                {"width": "5%", "data": "idcard", "title": "身份证号"},
                {"width": "10%", "data": "name", "title": "学生姓名"},
                {"width": "5%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "departmentShow", "title": "系部"},
                {"width": "10%", "data": "majorShow", "title": "专业"},
                {"width": "10%", "data": "classShow", "title": "班级"},
                {"width": "10%", "data": "planItemShow", "title": "缴费项目"},
                {"width": "10%", "data": "paymentStandard", "title": "缴费标准"},
                {"width": "10%", "data": "paymentAmount", "title": "缴费金额"},
                {"width": "10%", "data": "refundAmount", "title": "退费金额"},


            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order' : [[1,'desc'],[2,'desc'],[3,'desc'],[4,'desc'],[5,'desc'],[6,'desc']],
            "dom": 'rtlip',
            "language": language
        });
        exportPaymentResultStudent();
    });




    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var cid = $("#cid option:selected").val();
        var item=$("#item").val();
        var name=$("#name").val();
        var major = mid.split(",");
        var majorCode = major[0];
        var majorDirection = major[1];
        var trainingLevel = major[2];
        /*var majorCode=mid.substring(0,6);
        var majorDirection= mid.substring(7,9);
        var trainingLevel= mid.substring(10,mid.length);*/
        if (majorCode == null || majorCode == undefined){
            majorCode = ""
        }
        if (majorDirection == null || majorDirection == undefined){
            majorDirection = ""
        }
        if (trainingLevel == null || trainingLevel == undefined){
            trainingLevel = ""
        }
        table.ajax.url("<%=request.getContextPath()%>/payment/info/getStandardList?departmentsId="+did+"&majorCode="+majorCode+"&majorDirection="+majorDirection+"&trainingLevel="+trainingLevel+"&classId="+cid+"&itemId="+item+"&name="+name+"&planId=${planId}").load();
    }

    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        $("#name").val("");
        $("#item").val("");
        table.ajax.url("<%=request.getContextPath()%>/payment/info/getStandardList?planId=${planId}").load();
    }
    function back() {
        $("#right").load("<%=request.getContextPath()%>/payment/result");
        $("#right").modal("show")
    }
    function exportPaymentResultStudent(){
        var hhh = "<%=request.getContextPath()%>/payment/exportInfoStudentPayment?planId=${planId}&flag=2";
        $("#expdata").attr("href",hhh);
    }
</script>





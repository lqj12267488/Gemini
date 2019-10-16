<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:29
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
        <div class="col-md-12" id="roleList">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <div class="block block-drop-shadow">

                            <div class="content block-fill-white">
                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        申请日期：
                                    </div>
                                    <div class="col-md-2">
                                        <input id="dateSel" type="date"
                                               class="validate[required,maxSize[100]] form-control"/>
                                    </div>

                                    <div class="col-md-2 tar">
                                        奖助学金所属学期：
                                    </div>
                                    <div class="col-md-2">
                                        <select id="termSel"/>
                                    </div>

                                    <div class="col-md-2 tar">
                                        奖助学金名称：
                                    </div>
                                    <div class="col-md-2">
                                        <select id="nameSel"/>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-row">
                                        <div class="col-md-2 tar">
                                            系部:
                                        </div>
                                        <div class="col-md-2">
                                            <select id="did"></select>
                                        </div>
                                        <div class="col-md-2 tar">
                                            专业:
                                        </div>
                                        <div class="col-md-2">
                                            <select id="mid" ></select>
                                        </div>
                                        <div class="col-md-2 tar">
                                            班级:
                                        </div>
                                        <div class="col-md-2">
                                            <select id="cid" ></select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        学生姓名：
                                    </div>
                                    <div class="col-md-2">
                                        <input id="s_student" type="text"/>
                                    </div>

                                    <div class="col-md-2 tar">
                                        性别：
                                    </div>
                                    <div class="col-md-2">
                                        <select id="s_sex"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                    </div>
                                    <div class="col-md-2">
                                        <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                        <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="block block-drop-shadow content">
                            <div>
                                <div class="form-row block" style="overflow-y:auto;">
                                    <table id="grantManagementGrid" cellpadding="0" cellspacing="0" width="100%"
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
    </div>
</div>

<script>
    var roleTable;
    var render = "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"/*+
        "<a id='feedbackReport' class='icon-comments' title='反馈'></a>"*/
    $(document).ready(function () {

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
                orderby: " "
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
        $.get("<%=request.getContextPath()%>/grantmanagement/autoCompleteEmployee", function (data) {
            $("#s_student").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_student").val(ui.item.label);
                    $("#s_student").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'termSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZXJMC", function (data) {
            addOption(data, 'nameSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 's_sex');
        });



        roleTable = $("#grantManagementGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/grantmanagement/getCompleteList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "requestDate", "title": "申请日期"},
                {"width": "10%", "data": "grantManagementTermShow", "title": "奖助学金所属学期"},
                {"width": "10%", "data": "grantManagementNameShow", "title": "奖助学金名称"},
                {"width": "10%", "data": "studentId", "title": "学生姓名"},
                {"width": "10%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "departmentId", "title": "系部"},
                {"width": "10%", "data": "majorCode", "title": "专业"},
                {"width": "10%", "data": "classId", "title": "班级"},
                {"width": "10%","data": "requestFlag", "title": "请求状态"},
                {"width": "10%", "title": "操作", "render": function () {return render;}},

            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var grantmanagementProcessId = data.id;
            //查看流程轨迹
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: grantmanagementProcessId,
                    tableName: "T_XG_GRANT_MANAGEMENT_WF",
                    url: "<%=request.getContextPath()%>/grantmanagement/auditGrantManagementById?id=" + grantmanagementProcessId,
                    backUrl: "/grantmanagement/complete"
                });
            }
        });
    });

    function searchclear() {
        $("#dateSel").val("");
        $("#s_student").val("");
        $("#termSel").val("");
        $("#nameSel").val("");
        $("#s_sex").val("");
        $("#did option:selected").val("");
        $("#mid option:selected").val("");
        $("#cid option:selected").val("");
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");

        $("#mid").html("<option value=''>请选择系部</option>");
        $("#cid").html("<option value=''>请选择专业</option>");
        search();
    }

    function search() {
        roleTable = $("#grantManagementGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/grantmanagement/getCompleteList',
                "data": {
                    requestDate: $("#dateSel").val(),
                    studentId: $("#s_student").val(),
                    grantManagementName: $("#nameSel").val(),
                    grantManagementTerm: $("#termSel").val(),
                    sex: $("#s_sex").val(),
                    majorCode: $("#mid").val(),
                    classId: $("#cid").val(),
                    departmentId: $("#did").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "11%", "data": "requestDate", "title": "申请日期"},
                {"width": "11%", "data": "grantManagementTermShow", "title": "奖助学金所属学期"},
                {"width": "11%", "data": "grantManagementNameShow", "title": "奖助学金名称"},
                {"width": "11%", "data": "studentId", "title": "学生姓名"},
                {"width": "11%", "data": "sexShow", "title": "性别"},
                {"width": "11%", "data": "departmentId", "title": "系部"},
                {"width": "11%", "data": "majorCode", "title": "专业"},
                {"width": "11%", "data": "classId", "title": "班级"},
                {
                    "width": "11%", "title": "操作", "render": function () {
                        return render;
                    }
                },
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>


<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:17
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="grantManagementGridSel" cellpadding="0" cellspacing="0" width="100%"
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
<input id="tableName" hidden value="T_XG_GRANT_MANAGEMENT_WF">
<input id="workflowCode" hidden value="T_XG_GRANT_MANAGEMENT_WF01">
<input id="businessId" hidden>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var grantManagementTable;
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
        search();
        grantManagementTable.on('click', 'tr a', function () {
            var data = grantManagementTable.row($(this).parent()).data();
            var id = data.id;
            var requestFlag = data.requestFlag;
            if (this.id=="previewSel") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + id + "&role=leader");
                $("#dialog").modal("show");
            }
        });
    })



    function searchClear() {
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
        grantManagementTable = $("#grantManagementGridSel").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/grantmanagement/getGrantManagementSearchList',
                "data": {
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
                {"width": "12%", "data": "grantManagementTermShow", "title": "奖助学金所属学期"},
                {"width": "12%", "data": "grantManagementNameShow", "title": "奖助学金名称"},
                {"width": "12%", "data": "studentId", "title": "学生姓名"},
                {"width": "12%", "data": "sexShow", "title": "性别"},
                {"width": "12%", "data": "departmentId", "title": "系部"},
                {"width": "12%", "data": "majorCode", "title": "专业"},
                {"width": "12%", "data": "classId", "title": "班级"},
                {
                    "width": "12%", "title": "操作", "render": function () {
                        return "<a id='previewSel' class='icon-eye-open' title='附件查看'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>

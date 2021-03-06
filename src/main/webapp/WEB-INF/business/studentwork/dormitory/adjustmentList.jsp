<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
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
                                <select id="did" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="mid" class="js-example-basic-single"></select>
                            </div>
                        </div>
                    </div>
                    <div class="content block-fill-white" >
                        <div class="col-md-1 tar">
                            班级：
                        </div>
                        <div class="col-md-2">
                            <select id="cid" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-1 tar" style="margin-left: 3PX;margin-top: 6px;">
                            学生姓名：
                        </div>
                        <div class="col-md-2">
                            <input id="stu_name" style="width: 98.5%;" type="text"
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
                                onclick="singlePensonAdjust()">单人调寝
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="doublePeopleAdjust()">两人调寝
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="doubleDormAdjust()">两寝互调
                        </button>
                    </div>
                    <table id="adjustTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>
                            <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                            </th>
                            <th>id</th>
                            <th>departmentsId</th>
                            <th>majorCode</th>
                            <th>trainingLevel</th>
                            <th>dormId</th>
                            <th>studentId</th>
                            <th width="10%">系部</th>
                            <th width="10%">专业</th>
                            <th width="10%">班级</th>
                            <th width="10%">学生姓名</th>
                            <th width="10%">寝室</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
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
        table = $("#adjustTable").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/student/dorm/getAdjustmentList',
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='"+row.studentId+","+row.dormId+"'/>";
                    }
                },
                {"data": "id", "visible": false},
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

            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order' : [[2],[3,'desc'],[4,'desc'],[5,'desc']],
            paging: true,
            "dom": 'rtlip',
            "language": language
        });
    })


    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }


    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        $("#stu_name").val("");
        table.ajax.url("<%=request.getContextPath()%>/student/dorm/getAdjustmentList").load();
    }

    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var cid = $("#cid option:selected").val();
        var stu_name = $("#stu_name").val();
        var majorData = "";
        var trainingLevel = "";
        if (did == null || did == undefined || did == "") {
            did = "";
        }
        if (mid == null || mid == undefined || mid == "") {
            mid = "";
        } else {
            majorData = mid.split(",")[0];
            trainingLevel = mid.split(",")[1];
        }
        if (cid == null || cid == undefined || cid == "") {
            cid = "";
        }
        table.ajax.url("<%=request.getContextPath()%>/student/dorm/getAdjustmentList?departmentsId="+did+"&majorCode="+majorData+"&trainingLevel="+trainingLevel+"&classId="+cid+"&studentName="+stu_name).load();
    }

    //单人调寝
    function singlePensonAdjust() {
        var ids = "";
        var check_value = '';
        if ($('input[name="checkbox"]:checked').length > 1) {
             swal({
                title: "只能选择一个学生！",
                type: "info"
            });
        } else if($('input[name="checkbox"]:checked').length==0) {
             swal({
                title: "请选择要调寝的学生！",
                type: "info"
            });
        }else{
            $('input[name="checkbox"]:checked').each(function () {
                ids= $(this).val();
                check_value+="'" + $(this).val().substring(0,18)  +"'";


            });
            $("#dialog").load("<%=request.getContextPath()%>/dorm/toAdjustDorm?ids="+ids+"&check_value="+check_value);
            $("#dialog").modal("show");


        }

    }
    //两人调寝
    function doublePeopleAdjust(){
        $("#dialog").load("<%=request.getContextPath()%>/dorm/toDoublePeopleAdjust")
        $("#dialog").modal("show")
    }
    //两寝互调
    function doubleDormAdjust(){
        $("#dialog").load("<%=request.getContextPath()%>/dorm/toDoubleDormAdjust")
        $("#dialog").modal("show")
    }
</script>

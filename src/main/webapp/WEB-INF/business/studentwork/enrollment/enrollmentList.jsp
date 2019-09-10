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
                    <input id="hiddenYear" name="hiddenYear" type="hidden" value="${year}">
                    <input id="deptId" name="deptId" type="hidden" value="${deptId}">
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
                            <select id="f_year" class="js-example-basic-single"></select>
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
                                onclick="batchAddEnrollmentPlan()">批量设置招生计划
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="batchDelPlan()">批量删除招生计划
                        </button>
                    </div>

                    <table id="enrollmentGrid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>
                            <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                            </th>
                            <th>majorId</th>
                            <th>departmentsId</th>
                            <th>majorCode</th>
                            <th>trainingLevel</th>
                            <th>majorDirection</th>
                            <th>schoolSystem</th>
                            <th width="9%">系部</th>
                            <th width="9%">专业</th>
                            <th width="9%">培养层次</th>
                            <th width="9%">方向</th>
                            <th width="9%">学制</th>
                            <th width="9%">发证单位</th>
                            <th width="9%">招生年份</th>
                            <th width="9%">学习形式</th>
                            <th width="9%">班级数</th>
                            <th width="9%">计划招生人数</th>
                            <th width="10%">操作</th>
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
    var dothis ="<a id='addEnrollmentPlan' class='icon-cogs' title='设置招生计划'></a>&nbsp;&nbsp;&nbsp;"+
              "<a id='delPlan' class='icon-trash' title='删除招生计划'></a>";
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYXZ", function (data) {
            addOption(data, 'system');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYPYCC", function (data) {
            addOption(data, 'tid');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'f_year',$("#hiddenYear").val());
        });
        table = $("#enrollmentGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/enrollment/getEnrollmentList?flag=plan',
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='"+row.majorId+"'/>";
                    }
                },
                {"data": "majorId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "majorDirection", "visible": false},
                {"data": "schoolSystem", "visible": false},
                {"width": "9%", "data": "departmentShow", "title": "系部"},
                {"width": "9%", "data": "majorShow", "title": "专业"},
                {"width": "9%", "data": "directionShow", "title": "专业方向"},
                {"width": "9%", "data": "trainingLevelShow", "title": "培养层次"},
                {"width": "9%", "data": "schoolSystemShow", "title": "学制"},
                {"width": "9%", "data": "issuingUnitShow", "title": "发证单位"},
                {"width": "9%", "data": "year", "title": "招生年份"},
                {"width": "9%", "data": "learningTypeShow", "title": "学习形式"},
                {"width": "9%", "data": "classAmount", "title": "班级数"},
                {"width": "9%", "data": "planNumber", "title": "计划招生人数"},
                {"width":"10%","title": "操作","render": function () {return dothis;}}
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order' : [[2,'desc'],[3,'desc'],[4,'desc'],[5,'desc'],[6,'desc']],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var majorId = data.majorId;
            var majorShow = data.majorShow;
            var directionShow = data.directionShow;
            var trainingLevelShow = data.trainingLevelShow;
            var schoolSystemShow = data.schoolSystemShow;
            var year = data.year;
            if (this.id == "addEnrollmentPlan") {
                $("#dialog").load("<%=request.getContextPath()%>/enrollment/addEnrollmentPlan?majorId="+majorId+"&year="+year);
                $("#dialog").modal("show");
            }
            if (this.id == "delPlan") {
                swal({
                    title: "您确定要删除此条专业的招生计划信息?",
                    text: "专业名称："+majorShow+"，专业方向："+directionShow+"，专业层次："+trainingLevelShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/enrollment/delPlan?id="+majorId+"&year="+year, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });

                        }else{
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#enrollmentGrid').DataTable().ajax.reload();
                        }
                    })

                });

            }

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
        $("#tid").val("");
        $("#system").val("");
        $("#f_year").val($("#hiddenYear").val());
        table.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentList?flag=plan").load();
    }

    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var tid = $("#tid option:selected").val();
        var system = $("#system option:selected").val();
        var year = $("#f_year option:selected").val();
        if (year==""){
            year = 0;
        }
        if (mid!= null  || system != null || year != null || tid!= null) {
            table.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentList?departmentsId="+did+"&majorCode="+mid+"&trainingLevel="+tid+"&schoolSystem="+system+"&year="+year+"&flag=plan").load();
        }

    }

    function batchAddEnrollmentPlan() {
        var  year=$("#f_year").val();
        var  hiddenYear=$("#hiddenYear").val();
        var ids = '';
        var id = "";
        var length=$('input[name="checkbox"]:checked').length;
        if (length > 1) {
            $('input[name="checkbox"]:checked').each(function () {
                ids+="'" + $(this).val()  +"',";
                id += $(this).val() + ",";

            });
            ids = ids.substring(0,ids.length-1);
            if(year==null || year==""){
                $("#dialog").load("<%=request.getContextPath()%>/enrollment/batchAddEnrollmentPlan?ids="+ids+"&id="+id+"&year="+hiddenYear);
                $("#dialog").modal("show");
            }else{
                $("#dialog").load("<%=request.getContextPath()%>/enrollment/batchAddEnrollmentPlan?ids="+ids+"&id="+id+"&year="+year);
                $("#dialog").modal("show");
            }

        } else if(length<2){
            swal({
                title: "请至少选择两个专业!",
                type: "info"
            });
        }else{
            swal({
                title: "请选择要添加的专业!",
                type: "info"
            });
        }

    }

    function batchDelPlan() {
        var  year=$("#f_year").val();
        var  hiddenYear=$("#hiddenYear").val();
        var ids = '';
        var id = "";
        var length=$('input[name="checkbox"]:checked').length;
        if (length > 1) {
            $('input[name="checkbox"]:checked').each(function () {
                ids+="'" + $(this).val()  +"',";
                id += $(this).val() + ",";

            });
            ids = ids.substring(0,ids.length-1);
            swal({
                title: "您确定要批量删除招生计划信息?",
                //text: "专业名称："+majorShow+"，专业方向："+directionShow+"，专业层次："+trainingLevelShow+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                if(year==null || year==""){
                    $.get("<%=request.getContextPath()%>/enrollment/batchDelPlan?ids="+ids+"&id="+id+"&year="+hiddenYear, function (data) {
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                        $('#enrollmentGrid').DataTable().ajax.reload();
                    })
                }else{
                    $.get("<%=request.getContextPath()%>/enrollment/batchDelPlan?ids="+ids+"&id="+id+"&year="+year, function (data) {
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                        $('#enrollmentGrid').DataTable().ajax.reload();
                    })
                }

            });
          /*  if (confirm("确定要删除选择的记录？")) {
                if(year==null || year==""){
                    $.get("/enrollment/batchDelPlan?ids="+ids+"&id="+id+"&year="+hiddenYear, function (data) {
                        alert(data.msg);
                        $('#enrollmentGrid').DataTable().ajax.reload();
                    })
                }else{
                    $.get("/enrollment/batchDelPlan?ids="+ids+"&id="+id+"&year="+year, function (data) {
                        alert(data.msg);
                        $('#enrollmentGrid').DataTable().ajax.reload();
                    })
                }

            }*/


        } else if(length<2){
             swal({
                title: "请至少选择两个专业!",
                type: "info"
            });
        }else{
             swal({
                title: "请选择要删除的专业!",
                type: "info"
            });
        }

    }

</script>

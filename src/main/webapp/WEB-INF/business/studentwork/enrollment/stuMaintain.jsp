<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/31
  Time: 16:32
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
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="nameSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
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
                        <div class="form-row block" style="overflow-y: auto;">
                            <div class="form-row">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="batchAddEnrollmentPlan()">批量确认报到
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="batchDelPlan()">批量取消报到
                                </button>
                            </div>
                            <table id="studentEnrollmentGrid" cellpadding="0" cellspacing="0" width="100%"
                                   style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                                <thead>
                                <tr>
                                    <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                                    </th>
                                    <th>studentId</th>
                                    <th>departmentsId</th>
                                    <th>majorCode</th>
                                    <th>trainingLevel</th>
                                    <th>majorDirection</th>
                                    <th width="10%">学生姓名</th>
                                    <th width="7%">性别</th>
                                    <th width="10%">身份证号</th>
                                    <th width="7%">民族</th>
                                    <th width="10%">系部</th>
                                    <th width="7%">专业</th>
                                    <th width="7%">专业方向</th>
                                    <th width="7%">培养层次</th>
                                    <th width="7%">学制</th>
                                    <th width="7%">报到状态</th>
                                    <th width="10%">操作</th>
                                </tr>
                                </thead>

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

        enrollmentTable = $("#studentEnrollmentGrid").DataTable({
            "processing": false,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/enrollment/getEnrollmentStudentList'
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='"+row.studentId+"'/>";
                    }
                },
                {"data": "studentId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "majorDirection", "visible": false},
                {"width": "10%", "data": "name", "title": "学生姓名"},
                {"width": "7%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "idcard", "title": "身份证号"},
                {"width": "7%", "data": "nationShow", "title": "民族"},
                {"width": "10%", "data": "departmentShow", "title": "系部"},
                {"width": "7%", "data": "majorShow", "title": "专业"},
                {"width": "7%", "data": "majorDirectionShow", "title": "专业方向"},
                {"width": "7%", "data": "trainingLevelShow", "title": "培养层次"},
                {"width": "7%", "data": "programDurationShow", "title": "学制"},
                {"width": "7%", "data": "reportStatusShow", "title": "报到状态"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<span id='report' class='icon-check' title='更改为报到状态'  />&nbsp;"+
                        "<span id='unreport' title='更改为未报到状态' class='icon-repeat'></span>&ensp;";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc'],[3,'desc'],[4,'desc']],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        exportEnrollmentStudent();

        enrollmentTable.on('click', 'tr span', function () {
                var data = enrollmentTable.row($(this).parent()).data();
                if (this.id == "report") {
                    if (data.reportStatusShow == "已报到") {
                        swal({
                            title: "此学生已报到，不可重复报到",
                            type: "error"
                        });

                    } else {
                        swal({
                            title: "您确定要更改学生姓名：" + data.name + "为报到状态?",
                            //text: "用户名："+data.name+"\n\n删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "green",
                            confirmButtonText: "确定",
                            closeOnConfirm: false
                        }, function () {
                            $.post("<%=request.getContextPath()%>/enrollment/saveAllStuMaintain?", {
                                id: data.studentId,
                            }, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: "已更改为报到状态",
                                        type: "success"
                                    });

                                    enrollmentTable.ajax.reload();
                                }
                            })
                        })
                    }
                }
                 if (this.id == "unreport") {
                    if (data.reportStatusShow == "未报到") {
                        swal({
                            title: "此学生未报到，不可重复未报到",
                            type: "error"
                        });

                    } else {
                        swal({
                            title: "您确定要更改学生姓名为：" + data.name + "的报到状态?",
                            //text: "用户名："+data.name+"\n\n删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "green",
                            confirmButtonText: "确定",
                            closeOnConfirm: false
                        }, function () {
                            $.post("<%=request.getContextPath()%>/enrollment/saveAllStuMaintainCancel?", {
                                id: data.studentId,
                            }, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: "报到状态更改成功",
                                        type: "success"
                                    });

                                    enrollmentTable.ajax.reload();
                                }
                            })
                        })
                    }

                }
            }
        );

    })




    function showEmpDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/enrollment/toImportStudent");
        $("#dialog").modal("show");
    }



    function exportEnrollmentStudent(){
        var hhh = "<%=request.getContextPath()%>/enrollment/exportEnrollmentStudent";
        $("#expdata").attr("href",hhh);
    }

    function addStudentRegister() {
        $("#dialog").load("<%=request.getContextPath()%>/enrollment/addStudentRegister");
        $("#dialog").modal("show");
    }


    function searchclear() {
        $("#did option:selected").val("");
        $("#mid option:selected").val("");
        $("#nameSel").val("");
        $("#did").val("");
        $("#mid").val("");
        $("#mid").html("<option value=''>请选择系部</option>");
        enrollmentTable.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentStudentList").load();
    }

    function search() {
        var nameSel = $("#nameSel").val();
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        if (did != null || mid!= null ) {
            enrollmentTable.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentStudentList?departmentsId="+did+"&majorCode="+mid+"&name="+nameSel).load();
        }
    }
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }
    function batchAddEnrollmentPlan() {
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
                title: "您确定要批量修改报到状态吗?",
                //text: "专业名称："+majorShow+"，专业方向："+directionShow+"，专业层次："+trainingLevelShow+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "green",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                if(id !=null || id !=""){
                    $.get("<%=request.getContextPath()%>/enrollment/saveAllStuMaintain?ids="+ids+"&id="+id, function (data) {
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                        $('#studentEnrollmentGrid').DataTable().ajax.reload();
                    })
                }

            });
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
                title: "您确定要批量取消报到状态吗?",
                //text: "专业名称："+majorShow+"，专业方向："+directionShow+"，专业层次："+trainingLevelShow+"\n\n删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "green",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                if(id !=null || id !=""){
                    $.get("<%=request.getContextPath()%>/enrollment/saveAllStuMaintainCancel?ids="+ids+"&id="+id, function (data) {
                        swal({
                            title: data.msg,
                            type: "success"
                        });
                        $('#studentEnrollmentGrid').DataTable().ajax.reload();
                    })
                }

            });
            <%--$.post("<%=request.getContextPath()%>/enrollment/saveAllStuMaintain", {--%>
            <%--ids: ids,--%>
            <%--id: id,--%>
            <%--reportStatus: reportStatus--%>
            <%--}, function (msg) {--%>
            <%--hideSaveLoading();--%>
            <%--swal({--%>
            <%--title: msg.msg,--%>
            <%--type: "success"--%>
            <%--});--%>
            <%--$("#dialog").modal('hide');--%>
            <%--$('#studentEnrollmentGrid').DataTable().ajax.reload();--%>

            <%--})--%>

            // });

            <%--if(year==null || year==""){--%>
            <%--$("#dialog").load("<%=request.getContextPath()%>/enrollment/allStuMaintain?ids="+ids+"&id="+id+"&year="+hiddenYear);--%>
            <%--$("#dialog").modal("show");--%>
            <%--}else{--%>
            <%--$("#dialog").load("<%=request.getContextPath()%>/enrollment/savaAllStuMaintain?ids="+ids+"&id="+id+"&year="+year);--%>
            <%--$("#dialog").modal("show");--%>
            <%--}--%>

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

</script>





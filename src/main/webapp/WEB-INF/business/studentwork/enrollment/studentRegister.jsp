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
                            <div class="form-row">
                            <div class="col-md-1 tar">
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="nameSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                身份证号：
                            </div>
                            <div class="col-md-2">
                                <input id="idcardSel" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
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
                </div>
                <div class="block block-drop-shadow">
                    <div class="content">
                        <div class="form-row">
                            <div class="form-row" id="addbutton">
                                <button class="btn btn-default btn-clean" type="button"
                                        onclick="addStudentRegister()">添加</button>
                                <a id="expdata" class="btn btn-info btn-clean" >导出</a>
                            <button class="btn btn-info btn-clean" onclick="showEmpDialog()">导入</button>
                            </div>
                        </div>
                        <div class="form-row block" style="overflow-y: auto;">
                            <table id="studentEnrollmentGrid" cellpadding="0" cellspacing="0" width="100%"
                                   style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    <%--</div>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
</div>
    </div>
</div>
<script>
    var enrollmentTable;
    $(document).ready(function () {

        enrollmentTable = $("#studentEnrollmentGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/enrollment/getEnrollmentStudentList'
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data": "majorCode", "visible": false},
                {"data": "trainingLevel", "visible": false},
                {"data": "majorDirection", "visible": false},
                {"width": "10%", "data": "name", "title": "学生姓名"},
                {"width": "7%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "idcard", "title": "身份证号"},
                {"width": "10%", "data": "nationShow", "title": "民族"},
                {"width": "10%", "data": "departmentShow", "title": "系部"},
                {"width": "10%", "data": "majorShow", "title": "专业"},
                {"width": "10%", "data": "programDurationShow", "title": "学制"},
                {"width": "10%", "data": "gradationShow", "title": "层次"},
                {"width": "10%", "data": "reportStatusShow", "title": "报到状态"},
                {

                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editEnrollmentStudent' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delEnrollmentStudent' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"
                                /*+"<a id='addRelation' class='icon-sitemap' title='添加班级'></a>"*/;
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc'],[3,'desc'],[4,'desc']],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
        exportEnrollmentStudent();
        enrollmentTable.on('click', 'tr a', function () {
            var data = enrollmentTable.row($(this).parent()).data();
            var studentId = data.studentId;
            var name = data.name;
            if (this.id == "editEnrollmentStudent") {
                $("#dialog").load("<%=request.getContextPath()%>/enrollment/editStudentRegister?studentId=" + studentId);
                $("#dialog").modal("show");
            }
            if (this.id == "delEnrollmentStudent") {
                swal({
                    title: "您确定要删除此条信息?",
                    text: "学生姓名："+name+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/enrollment/delEnrollmentStudent?studentId=" + studentId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "info"
                            });
                        }else{
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#studentEnrollmentGrid').DataTable().ajax.reload();
                        }
                    })

                });


            }
             
        });
    });



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
        $("#nameSel").val("");
        $("#idcardSel").val("");
        enrollmentTable.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentStudentList").load();
    }

    function search() {
        var nameSel = $("#nameSel").val();
        var idcardSel = $("#idcardSel").val();
        enrollmentTable.ajax.url("<%=request.getContextPath()%>/enrollment/getEnrollmentStudentList?name="+nameSel+"&idcard="+idcardSel).load();

    }
    
</script>





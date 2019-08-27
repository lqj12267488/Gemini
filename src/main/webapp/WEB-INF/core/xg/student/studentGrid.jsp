<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
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
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            学生姓名：
                        </div>
                        <div class="col-md-3">
                            <input id="nameSel" type="text"
                                   class="validate[required,maxSize[20]] form-control"/>
                        </div>
                        <div class="col-md-2 tar">
                            身份证号：
                        </div>
                        <div class="col-md-3">
                            <input id="idcardSel" type="text" placeholder="末位字母请大写"
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
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <span id="addbutton">
                            <button type="button" class="btn btn-info btn-clean"
                                    onclick="addStudent()">新增
                            </button>
                        </span>
                        <a id="expdata" class="btn btn-info btn-clean" onclick="exportStudent()">导出</a>
                        <button class="btn btn-info btn-clean" onclick="showEmpDialog()">导入</button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="studentGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="classId" type="hidden" value="${classId}"/>
<input id="tablename" type="hidden" value="${tablename}"/>
<input id="relationId" type="hidden" value="${relationId}"/>
<script>
    var studentTable;
    var tablename = $("#tablename").val();
    var relationId = $("#relationId").val();
    var classId = $("#classId").val();

    $(document).ready(function () {
        if (tablename != "T_XG_CLASS") {
            $("#addbutton").css('display', 'none');
        }
        search();
        studentTable.on('click', 'tr a', function () {
            var data = studentTable.row($(this).parent()).data();
            var studentId = data.studentId;
            var name = data.name;
            if (this.id == "updateStudent") {
                $("#dialog").load("<%=request.getContextPath()%>/student/updateStudent?studentId=" + studentId);
                $("#dialog").modal("show");
            }
            if (this.id == "parentRelation") {
                $("#dialog").load("<%=request.getContextPath()%>/core/parent/toStudentRelationList?studentId=" + studentId + "&studentName=" + name);
                $("#dialog").modal("show");
            }
            if (this.id == "delStudent") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "学生姓名：" + name + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/student/delStudent?studentId=" + studentId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#studentGrid').DataTable().ajax.reload();
                        }else{
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                            $('#studentGrid').DataTable().ajax.reload();
                        }
                    })
                });
            }
            if (this.id == "viewStudent") {
                $("#dialog").load("<%=request.getContextPath()%>/student/viewStudent?studentId=" + studentId);
                $("#dialog").modal("show");
            }
            if (this.id == "repeatPwd") {
                //if (confirm("确定要初始化用户 " + data.name + " 的密码?")) {
                swal({
                    title: "您确定要初始化学生：" + data.name + "的密码?",
                    //text: "用户名："+data.name+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/saveLoginPwd?", {
                        personId: data.studentId,
                        password: '123456'
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: "密码初始化成功",
                                type: "success"
                            });
                            //alert("密码初始化成功");
                            //deptTable.ajax.reload();
                        }
                    })
                })
            }

        });

    })

    function searchClass() {
        var nameSel = $("#nameSel").val();
        if (nameSel != "")
            nameSel = '%' + nameSel + '%';
        var idcardSel = $("#idcardSel").val();
        if (idcardSel != "")
            idcardSel = '%' + idcardSel + '%';
        studentTable = $("#studentGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/student/getStudentList',
                "data": {
                    classId: $("#classId").val(),
                    name: nameSel,
                    idcard: idcardSel,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"width": "10%", "data": "studentNumber", "title": "学籍号"},
                {"width": "10%", "data": "name", "title": "学生姓名"},
                {"width": "25%", "data": "userAccount", "title": "登录账号"},
                {"width": "10%", "data": "sexShow", "title": "性别"},
                {"width": "25%", "data": "idcard", "title": "身份证号"},
                {"width": "10%", "data": "birthday", "title": "出生日期"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='updateStudent' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='repeatPwd' title='初始化密码' class='icon-repeat'></a>&nbsp;&nbsp;&nbsp;" +
                            '<a id="parentRelation" class="icon-tags" title="关联家长" ></a>&nbsp;&nbsp;&nbsp;' +
                            "<a id='delStudent' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"
                            /*+"<a id='addRelation' class='icon-sitemap' title='添加班级'></a>"*/;
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

    function addStudent() {
        var classid = $("#classId").val();
        $("#dialog").load("<%=request.getContextPath()%>/student/addStudent?classId=" + classid);
        $("#dialog").modal("show");
    }


    function searchclear() {
        $("#nameSel").val("");
        $("#idcardSel").val("");
        search();
    }

    function search() {
        if (tablename == "T_XG_CLASS") {
            searchClass();
        } else {
            searchDeptOrMajor();
        }
    }

    function searchDeptOrMajor() {
        var nameSel = $("#nameSel").val();
        if (nameSel != "")
            nameSel = '%' + nameSel + '%';
        var idcardSel = $("#idcardSel").val();
        if (idcardSel != "")
            idcardSel = '%' + idcardSel + '%';
        studentTable = $("#studentGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/student/getStudentListByDeptOrMajor',
                "data": {
                    tablename: tablename,
                    relationId: relationId,
                    name: nameSel,
                    idcard: idcardSel,
                    level: 1,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"width": "10%", "data": "studentNumber", "title": "学籍号"},
                {"width": "10%", "data": "name", "title": "学生姓名"},
                {"width": "25%", "data": "userAccount", "title": "登录账号"},
                {"width": "10%", "data": "sexShow", "title": "性别"},
                {"width": "25%", "data": "idcard", "title": "身份证号"},
                {"width": "10%", "data": "birthday", "title": "出生日期"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='updateStudent' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='repeatPwd' title='初始化密码' class='icon-repeat'></a>&nbsp;&nbsp;&nbsp;" +
                            '<a id="parentRelation" class="icon-tags" title="关联家长" ></a>&ensp;&ensp;' +
                            "<a id='delStudent' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

    function showEmpDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/student/toImportStudent?classId=" + classId);
        $("#dialog").modal("show");
    }


    function exportStudent() {
        var nameSel = $("#nameSel").val();
        if (nameSel != "")
            nameSel = '%' + nameSel + '%';
        var idcardSel = $("#idcardSel").val();
        if (idcardSel != "")
            idcardSel = '%' + idcardSel + '%';
        var classId = $("#classId").val();
        if(""==classId || null == classId){
            classId = "";
        }else{
            classId = classId;
        }
        var hhh = "<%=request.getContextPath()%>/student/exportStudent?type=0&classId="+classId+"&departmentsId="+relationId+"&name=" + nameSel + "&idcard=" + idcardSel;
        $("#expdata").attr("href", hhh);
    }

</script>
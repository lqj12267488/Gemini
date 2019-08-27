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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                排课计划：
                            </div>
                            <div class="col-md-2">
                                <input id="s_arrayClassName"/>
                            </div>
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="s_term" class="validate[required,maxSize[100]] form-control"></select>
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="arrayClassCourseGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var arrayClass;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 's_term');
        });
        arrayClass = $("#arrayClassCourseGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/getArrayClassList',
            },
            "destroy": true,
            "columns": [
                {"data": "arrayClassId", "visible": false},
                {"data": "termValue", "visible": false},
                {"width": "30%", "data": "arrayClassName", "title": "排课计划"},
                {"width": "30%", "data": "term", "title": "学期"},
                {"width": "30%", "data": "remark", "title": "备注"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return  '<span class="icon-search" title="查看上课班级" onclick=courseClassManage("' + row.arrayClassId + '")/>&ensp;&ensp;' +
                            '<span class="icon-refresh" title="根据班级生成学生列表" onclick=courseInsertStudent("' + row.arrayClassId + '")/>&ensp;&ensp;'  +
                            '<span class="icon-th-list" title="学生列表调整" onclick=courseStudentView("' + row.arrayClassId + '")/>&ensp;&ensp;' ;
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    })

    function courseClassManage( id) {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClass/student/toSelectClass?arrayClassId="+id);
        $("#dialog").modal("show");
    }

    function courseInsertStudent( id) {
        swal({
            title: "确定要新生成学生列表?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/arrayClass/student/insertClassTeacher", {
                arrayclassId: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#assetsScrapGrid').DataTable().ajax.reload();
            });
        })
    }

    function courseStudentView( id) {
        $("#right").load("<%=request.getContextPath()%>/arrayClass/student/viewClassStudengList?arrayClassId="+id );
    }

    function searchclear() {
        $("#s_arrayClassName").val("");
        $("#s_term").val("");
        search();
    }

    function search() {
        var t_arrayClassName = $("#s_arrayClassName").val();
        var t_term = $("#s_term option:selected").val();
        arrayClass.ajax.url("<%=request.getContextPath()%>/arrayClass/getArrayClassList?"+
            "arrayClassName="+t_arrayClassName +"&" +
            "term=t_term").load();
    }
</script>
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
                <div class="block block-drop-shadow content block-fill-white">
                    <%--<div class="form-row">
                        <h5>开课计划维护</h5>
                    </div>--%>
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            计划名称:
                        </div>
                        <div class="col-md-2">
                            <input id="planSel" type="text"/>
                        </div>
                        <div class="col-md-1 tar">
                            创建年份:
                        </div>
                        <div class="col-md-2">
                            <select id="yearSel" />
                        </div>
                        <div class="col-md-1 tar">
                            系部名称:
                        </div>
                        <div class="col-md-2">
                            <select id="departmentsSel"/>
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
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearSel' );
        });

        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseplan/getList',
            },
            "destroy": true,
            "columns": [
                {"data": "createTime","visible": false},
                {"data": "planName", "title": "计划名称"},
                {"data": "year", "title": "创建年份"},
                {"data": "departmentsId", "title": "系部名称"},
                {"data": "majorShow", "title": "专业名称"},
                {"data": "semester", "title": "学期"},
                {"data": "teacherPersonId", "title": "教师"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.planId + '")/>&ensp;&ensp;' +
                            '<span class="icon-eye-open" title="计划管理" onclick=planManage("' + row.planId + '","' + row.planName + '","' + row.majorCode + '","' + row.trainingLevel + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.planId + '","' + row.planName + '")/>';
                    }
                }
            ],
            'order' : [5,'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/courseplan/toAddTeacher", {
            type: '${type}'
        })
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/courseplan/toEditTeacher?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id,planName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "计划名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/courseplan/del?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            })

        });
        /*if (confirm("确定要删除这条记录？")) {
            $.get("/courseplan/del?id=" + id, function (data) {
                alert(data.msg);
                $('#table').DataTable().ajax.reload();
            })
        }*/
    }

    function planManage(id, planName,majorCode,trainingLevel) {
        $("#right").load("<%=request.getContextPath()%>/courseplan/toPlanDetails?id=" + id + "&planName=" + planName
            + "&majorCode=" + majorCode  + "&trainingLevel=" + trainingLevel );
    }

    function search() {
        var departmentsSel = $("#departmentsSel option:selected").val();
        if(departmentsSel == undefined || departmentsSel == null ){
            departmentsSel ="";
        }
        var yearSel = $("#yearSel option:selected").val();
        if(yearSel == undefined || yearSel == null ){
            yearSel ="";
        }
        var planName = $("#planSel").val();
        table.ajax.url("<%=request.getContextPath()%>/courseplan/getList?"+
            "planName=" + planName +"&departmentsId="+departmentsSel+"&year="+yearSel
        ).load();
    }

    function searchclear() {
        $("#yearSel option:selected").val("");
        $("#yearSel").val("");
        $("#departmentsSel option:selected").val("");
        $("#departmentsSel").val("");
        $("#planSel").val("");
        search();
    }

</script>
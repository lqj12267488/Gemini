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
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${planName} > ${courseName} > 学期管理</span>
                </div>
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
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
    <input hidden id="courseName" value="${data.courseName}">
    <input hidden id="planName" value="${planName}">
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseplan/getPlanTerms?detailsId=${data.id}',
            },
            "destroy": true,
            "columns": [
                {"data": "courseId", "visible": false},
                {"data": "planId", "visible": false},
                {"data": "term", "visible": false},
                {"data": "detailsId", "visible": false},
                {"data": "schoolYear", "title": "学年"},
                {"data": "termShow", "title": "学期"},
                {"data": "theoreticalHours", "title": "理论周学时"},
                {"data": "practiceHours", "title": "实践周学时"},
                {"data": "theorypracticeHours", "title": "理实周学时"},
                {"data": "totleHours", "title": "总学时"},
                /*{"data": "personId", "title": "签课教师(位)"},*/
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '","' + row.termShow + '","' + row.personId + '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/courseplan/toAddPlanTerm?detailsId=${data.id}");
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/courseplan/toEditPlanTerm?id=" + id);
        $("#dialog").modal("show")
    }

    function del(id,termShow , personId) {
        if( personId!="0" ){
            swal({
                title: "已有教师签课，无法删除",
                type: "error"
            });
            return;
        }
        swal({
            title: "您确定要删除本条信息?",
            text: "学期："+termShow+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/courseplan/delPlanTerm?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            })


        });
      /*  if (confirm("确定要删除这条记录？")) {
            $.get("/courseplan/delPlanTerm?id=" + id, function (data) {
                alert(data.msg);
                $('#table').DataTable().ajax.reload();
            })
        }*/
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/courseplan/toPlanDetails?id=${data.planId}&planName=${planName}")
    }
</script>

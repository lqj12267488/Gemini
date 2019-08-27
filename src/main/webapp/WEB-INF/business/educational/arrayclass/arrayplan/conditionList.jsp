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
<input id="elementsId" hidden value="${elementsId}">
<input id="arrayClassId" hidden value="${arrayClassId}">
<input id="elementsType" hidden value="${elementsType}">
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-fill-white content">
                    <div class="form-row">
                        <h5>${arrayClassName} > ${elementsIdShow} > 设置排课约束条件</h5>
                    </div>
                    <%--<div class="col-md-1 tar">
                        禁排星期：
                    </div>
                    <div class="col-md-2">
                        <input id="limitWeek" type="text">
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="search()">查询
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="searchclear()">清空
                        </button>
                    </div>--%>
                </div>
                <div class="block block-drop-shadow content">
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
                        <table id="arrayClassConditionGrid" cellpadding="0" cellspacing="0"
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
        table = $("#arrayClassConditionGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClass/toArrayClassConditionList?arrayclassId=${arrayClassId}'+'&elementsId=${elementsId}',

            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "arrayclassId", "visible": false},
                {"data": "elementsId", "visible": false},
                {"data": "conditionTypeShow", "title": "约束条件类型"},
                {"data": "limitWeekShow", "title": "禁排星期"},
                {"data": "limitHoursTypeShow", "title": "禁排学时类型"},
                {"data": "limitHoursCodeShow", "title": "禁排学时"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>';

                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/addArrayClassCondition?arrayClassId=${arrayClassId}&elementsId=${elementsId}&elementsType=${elementsType}")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/arrayClassCourse/editArrayClassCondition?id=" + id);
        $("#dialog").modal("show");
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/arrayClass/delArrayClassCondition", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#arrayClassConditionGrid').DataTable().ajax.reload();
            });
        })
    }
    function back() {
        if($("#elementsType").val()==1){
            $("#right").load("<%=request.getContextPath()%>/arrayClass/toArrayClassClassList?arrayClassId=${arrayClassId}&arrayClassName=${arrayClassName}");
        }else if($("#elementsType").val()==2){
            $("#right").load("<%=request.getContextPath()%>/arrayClass/teacher/teacherList?arrayclassId=${arrayClassId}&arrayClassName=${arrayClassName}");
        }else if($("#elementsType").val()==3){
            $("#right").load("<%=request.getContextPath()%>/arrayClassCourse/request?arrayClassId=${arrayClassId}&arrayClassName=${arrayClassName}");
        }else{
            $("#right").load("<%=request.getContextPath()%>/arrayClassRoom/arrayClassRoom?arrayClassId=${arrayClassId}&arrayClassName=${arrayClassName}");
        }
    }
</script>
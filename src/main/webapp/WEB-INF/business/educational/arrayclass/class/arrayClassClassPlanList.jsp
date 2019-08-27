<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <%--<div class="block block-drop-shadow">
                </div>--%>
                    <div class="block block-fill-white content">
                        <div class="form-row">
                            <h5>${arrayClassName} > 设置班级信息</h5>
                            <div class="col-md-1 tar">
                                班级名称：
                            </div>
                            <div class="col-md-2">
                                <input id="selClass" type="text">
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
                    <div>
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
    </div>
</div>

<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayclass/getArrayClassClassList?arrayclassId=${arrayClassId}',
            },
            "destroy": true,
            "columns": [
                {"data": "className", "title": "班级名称"},
                {"data": "departmentsId", "title": "系部名称"},
                {"data": "majorCode", "title": "专业名称"},
                {"data": "roomId", "title": "教室名称"},
                {"data": "studentNumber", "title": "班级学生数量"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.arrayclassClassId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.arrayclassClassId + '")/>&ensp;&ensp;'+
                            '<span class="icon-info-sign" title="设置排课约束条件" onclick=skip("'+row.arrayclassClassId+'")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/arrayclass/toArrayClassClassAdd?arrayClassId=${arrayClassId}")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/arrayclass/toArrayClassClassEdit?id=" + id);
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
            $.post("<%=request.getContextPath()%>/arrayclass/delArrayClassClass", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            });
        })
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayclass/class");
    }

    function skip(arrayclassClassId) {
        $("#right").load("<%=request.getContextPath()%>/arrayClassCondition/request?arrayClassId=${arrayClassId}&elementsId=" + arrayclassClassId+"&elementsType="+1+"&arrayClassName=${arrayClassName}" );
    }
    function searchclear() {
        $("#selClass").val("");
        search();
    }
    function search() {
        var classId = $("#selClass").val();
        table.ajax.url("<%=request.getContextPath()%>/arrayclass/getArrayClassClassList?arrayclassId=${arrayClassId}"+
            "&classId="+classId).load();
    }
</script>
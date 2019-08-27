<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/14
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
<%--楼宇场地维护首页--%>
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
                <div class="block block-drop-shadow">

                    <%--<div class="content block-fill-white">--%>

                    <%--<div class="form-row">--%>
                    <%--<div class="col-md-1 tar">--%>
                    <%--学期：--%>
                    <%--</div>--%>
                    <%--<div class="col-md-2">--%>
                    <%--<select id="s_semester"/>--%>
                    <%--</div>--%>
                    <%--<div class="col-md-1 tar">--%>
                    <%--系部：--%>
                    <%--</div>--%>
                    <%--<div class="col-md-2">--%>
                    <%--<select id="f_departmentId"/>--%>
                    <%--</div>--%>
                    <%--<div class="col-md-1 tar">--%>
                    <%--专业：--%>
                    <%--</div>--%>
                    <%--<div class="col-md-2">--%>
                    <%--<select id="prize"/>--%>
                    <%--</div>--%>
                    <%--<div class="col-md-2">--%>
                    <%--<button type="button" class="btn btn-default btn-clean" onclick="search()">查询--%>
                    <%--</button>--%>
                    <%--<button type="button" class="btn btn-default btn-clean" onclick="searchclear()">--%>
                    <%--清空--%>
                    <%--</button>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addMaterial()">
                            新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="material" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_JY_PRACTICE_MATERIAL">
<input id="businessId" hidden>
<input id="flag" hidden value="${flag}">
<input id="flag1" hidden value="${flag1}">
<script>

    var roleTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 's_semester');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: "dept_id",
            text: "dept_name",
            tableName: "T_SYS_DEPT",
            where: "WHERE dept_type = 8 ",
            orderBy: ""
        }, function (data) {
            addOption(data, 'f_departmentId');
        });
        $("#f_departmentId").change(function () {
            if ($("#f_departmentId").val() != "") {
                $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: "major_code",
                    text: "major_name",
                    tableName: "T_XG_MAJOR",
                    where: "WHERE departments_id = '" + $("#f_departmentId").val() + "' ",
                    orderBy: ""
                }, function (data) {
                    addOption(data, 'prize');
                });
            }

        })
        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var uploadPerson = data.uploadPerson;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/tableManagement/edit?id=" + id);
                $("#dialog").modal("show");
            }
            <%--if(this.id == "upload"){--%>
            <%--$("#dialog").load("<%=request.getContextPath()%>/tableManagement/toUpload?id=" + id);--%>
            <%--$("#dialog").modal("show")--%>
            <%--}--%>

            if (this.id == "upload") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUploadTable?businessId=' + id + '&businessType=TEST&tableName=T_JY_PRACTICE_SAMPLE_TABLE');
                $('#dialogFile').modal('show');
            }

            if (this.id == "download") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUploadTable1?businessId=' + id + '&businessType=TEST&tableName=T_JY_PRACTICE_SAMPLE_TABLE');
                $('#dialogFile').modal('show');
            }

            if (this.id == "delRole") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "上传人：" + uploadPerson + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/sampleTable/deleteSampleTableById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#material').DataTable().ajax.reload();
                        }
                    })

                });

            }

        });
    });

    function addMaterial() {
        $("#dialog").load("<%=request.getContextPath()%>/tableManagement/edit");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#s_semester").val("");
        $("#s_semester option:selected").val("");
        $("#prize").val("");
        $("#prize option:selected").val("");
        $("#f_departmentId").val("");
        $("#f_departmentId option:selected").val("");
        search();
    }

    function search() {
        var flag = $("#flag").val();
        var flag1 = $("#flag1").val();
        roleTable = $("#material").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/tableManagement/list',
                "data": {
                    // semester: $("#s_semester option:selected").val(),
                    // majorId:$("#prize option:selected").val(),
                    // departmentId:$("#f_departmentId option:selected").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                // {"width": "15%", "data": "semester", "title": "学期"},
                // {"width": "15%", "data": "departmentId", "title": "系部"},
                // {"width": "15%", "data": "majorId", "title": "专业"},
                // {"width": "15%", "data": "uploadPerson", "title": "上传人"},
                {"width": "15%", "data": "sampleName", "title": "名称"},
                {
                    "width": "15%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"
                            <c:if test="${flag eq '1'}">
                            +'<a id="upload" class="icon-upload" title="上传附件"></a>&ensp;&ensp;'
                            </c:if>
                            <c:if test="${flag1 eq '0'}">
                            +'<a id="download" class="icon-download" title="下载附件"></a>&ensp;&ensp;';
                            </c:if>
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });

    }
</script>



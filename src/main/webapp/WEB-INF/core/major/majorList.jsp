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
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsIdSel" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业名称：
                            </div>
                            <div class="col-md-2">
                                <input id="majorNameSel" type="text" class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业代码：
                            </div>
                            <div class="col-md-2">
                                <input id="majorTypeSel" type="text" class="validate[required,maxSize[20]] form-control"/>
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
                                onclick="addMajor()">新增
                        </button>
                        <a id="expdata" class="btn btn-default btn-clean">导出</a>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="majorGrid" cellpadding="0" cellspacing="0"
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
    var majorTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsIdSel");
            });
        //专业类型 majorType
        <%--$.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYLX", function (data) {--%>
        <%--addOption(data, 'majorTypeSel', $("#majorType").val());--%>
        <%--});--%>


        search();
        majorTable.on('click', 'tr a', function () {
            var data = majorTable.row($(this).parent()).data();
            var majorId = data.majorId;
            var majorName = data.majorName;
            if (this.id == "updateMajor") {
                $("#dialog").load("<%=request.getContextPath()%>/major/updateMajor?majorId=" + majorId);
                $("#dialog").modal("show");
            }
            if(this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + majorId + '&businessType=TEST&tableName=T_XG_MAJOR');
                $('#dialogFile').modal('show');
            }
            if (this.id == "delMajor") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "专业名称：" + majorName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/major/delMajor?majorId=" + majorId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#majorGrid').DataTable().ajax.reload();
                        } else {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                            $('#majorGrid').DataTable().ajax.reload();
                        }
                    })

                });
                /* if (confirm("确定要删除" + data.majorName + "?")) {
                     $.get("/major/delMajor?majorId=" + majorId, function (msg) {
                         if (msg.status == 1) {
                             alert(msg.msg);
                             $('#majorGrid').DataTable().ajax.reload();
                         }
                     })
                 }*/
            }
        });
    })

    function addMajor() {
        $("#dialog").load("<%=request.getContextPath()%>/major/addMajor");
        $("#dialog").modal("show");
    }

    var rootPath = "<%=request.getContextPath()%>";

    function searchclear() {
        $("#departmentsIdSel").val("");
        $("#majorNameSel").val("");
        $("#majorTypeSel").val("");
        search();
    }

    function search() {
        var majorName = $("#majorNameSel").val();
        if (majorName != "")
            majorName = '%' + majorName + '%';
        majorTable = $("#majorGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/major/getMajorList',
                "data": {
                    departmentsId: $("#departmentsIdSel option:selected").val(),
                    majorName: $("#majorNameSel").val(),
                    majorCode: $("#majorTypeSel").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "majorId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "7%", "data": "majorSchoolShow", "title": "所属学院"},
                {"width": "20%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "10%", "data": "majorDirectionShow", "title": "专业方向"},
                {"width": "20%", "data": "majorName", "title": "专业名称"},
                {"width": "10%", "data": "trainingLevelShow", "title": "培养层次"},
            /*    {"width": "10%", "data": "majorCode", "title": "专业代码"},*/
                {"width": "10%", "data": "maxYear", "title": "修业年限"},
                {"width": "10%", "data": "ordersStudentnum", "title": "学生总数"},
                {"width": "10%", "data": "majorDirectionCode", "title": "专业方向代码"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        var html = "<a id='updateMajor' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delMajor' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-upload' title='上传附件'></a>&ensp;&ensp;";
                        // if (row.fileUrl != '' && row.fileUrl != null) {
                        //     html += "<a href='" + rootPath + row.fileUrl + "' class='icon-download' title='下载附件'></a>"
                        // }
                        return html;
                    }
                }
            ],
            'order': [1, 'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
        exportMajor()
    }

    function upload(dataId) {
        $("#dialog").load("<%=request.getContextPath()%>/teachingplanNew/toUpload?id=" + dataId);
        $("#dialog").modal("show")
    }

    function exportMajor() {
        var exp = "<%=request.getContextPath()%>/major/exportInfo";
        $("#expdata").attr("href", exp);
    }


</script>
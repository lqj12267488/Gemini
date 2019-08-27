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
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="tname"/>
                            </div>
                            <div class="col-md-1 tar">
                                系部
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsIdSearch"
                                        onchange="changeSearchMajor()"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业
                            </div>
                            <div class="col-md-2">
                                <select id="majorCodeSearch"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addResponsible()">新增
                        </button>
                        <a type="button" class="btn btn-default btn-clean"
                           href="<%=request.getContextPath()%>/majorResponsible/daochuDate">导出
                        </a>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="mrtable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="personType" hidden value="${pType}">
<script>
    var mrtable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsIdSearch');
        });
        $("#majorCodeSearch").append("<option value='' selected>请选择</option>")

        mrtable = $("#mrtable").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/majorResponsible/majorResponsibleList',
                "data":{
                    personType:$("#personType").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data":"id","visible":false},
                {"data": "createTime", "visible": false},
                {"width": "11%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "11%", "data": "majorIdShow", "title": "专业名称"},
                {"width": "11%", "data": "personIdShow", "title": "姓名"},
                {"width": "11%", "data": "sexShow", "title": "性别"},
                {"width": "11%", "data": "educationShow", "title": "学历"},
                {"width": "11%", "data": "degreeShow", "title": "学位"},
                {
                    "width": "11%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editleader("' + row.id +'")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delleader("' + row.id + '","' + row.personIdShow +'")/>&ensp;&ensp;'
                    }
                }
            ],
            'order' : [0,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    })

    function changeSearchMajor() {
        var deptId = $("#departmentsIdSearch").val();
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " major_id",
                text: " major_name ",
                tableName: "T_XG_MAJOR",
                where: " WHERE departments_id ="+deptId
            },
            function (data) {
                addOption(data, "majorCodeSearch");
            });
    }

    function addResponsible() {
        $("#dialog").load("<%=request.getContextPath()%>/majorResponsible/editMajorResponsible?personType="+$("#personType").val());
        $("#dialog").modal("show");
    }

    function editleader(id) {
            $("#dialog").load("<%=request.getContextPath()%>/majorResponsible/editMajorResponsible?id=" + id);
            $("#dialog").modal("show");
    }

    function delleader(id,personIdShow) {
        swal({
            title: "您确定要删除本条信息?",
            text: "姓名："+personIdShow+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/majorResponsible/delMajorResponsible", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#mrtable').DataTable().ajax.reload();

            });

        });
    }
    function search() {
        var planName = $("#tname").val();
        var departmentsId = $("#departmentsIdSearch").val();
        var majorid = $("#majorCodeSearch").val();
        planName=encodeURI(encodeURI(planName));
        mrtable.ajax.url("<%=request.getContextPath()%>/majorResponsible/majorResponsibleList?personIdShow="+planName+"&departmentsId="+
            departmentsId+"&majorId="+majorid).load();
    }

    function searchclear() {
        $("#tname").val("");
        $("#departmentsIdSearch").val("");
        $("#majorCodeSearch").val("");
        search();
    }

</script>
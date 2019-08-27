<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
    .ztree li span.button.switch.level0 {
        visibility: hidden;
        width: 1px;
    }

    .ztree li ul.level0 {
        padding: 0;
        background: none;
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="row">
                    <div class="col-md-3">
                        <div class="block block-drop-shadow">
                            <div class="content controls" id="style-4" style="overflow-y:auto;height: 85%">
                                <ul id="tree" class="ztree"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="block block-drop-shadow content block-fill-white">
                            <%--<div class="form-row">
                                <div class="col-md-1 tar">
                                    学科名称
                                </div>
                                <div class="col-md-2">
                                    <select id="SubjectIdSel"/>
                                </div>
                                <div class="col-md-1 tar">
                                    专业名称
                                </div>
                                <div class="col-md-2">
                                    <select id="majorIdSel"/>
                                </div>
                                <div class="col-md-1 tar">
                                    课程名称
                                </div>
                                <div class="col-md-2">
                                    <select id="CourseIdSel"/>
                                </div>
                            </div>--%>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    资源名称
                                </div>
                                <div class="col-md-2">
                                    <input id="resourceNameSel"/>
                                </div>
                                <div class="col-md-8 tar">
                                    <button type="button" class="btn btn-default btn-clean pull-right"
                                            onclick="searchclear()">清空
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="searchResource()">查询
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="block block-drop-shadow content">
                            <div>
                                <div class="form-row">
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="add()">新增
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean"
                                            onclick="batchAdd()">批量上传
                                    </button>
                                    <br>
                                </div>
                                <div class="form-row block" style="overflow-y:auto;">
                                    <table id="tableResource" cellpadding="0" cellspacing="0"
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
    </div>
</div>
<div id="search">
    <input id="SubjectIdSel" hidden>
    <input id="majorIdSel" hidden>
    <input id="CourseIdSel" hidden>
    <input id="cache" hidden>
</div>
<script>
    var tableResource;
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
            }
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                $("#search input").val("")
                if (treeNode.level == '0') {
                    $("#SubjectIdSel").val(treeNode.id)
                    $("#cache").val(treeNode.id)
                } else if (treeNode.level == '1') {
                    $("#cache").val(treeNode.getParentNode().id + "," + treeNode.id)
                    $("#majorIdSel").val(treeNode.id)
                } else {
                    $("#cache").val(treeNode.getParentNode().getParentNode().id + "," + treeNode.getParentNode().id + "," + treeNode.id)
                    $("#CourseIdSel").val(treeNode.id)
                }
                searchResource()
            }
        }
    };
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/resourcePublic/getResourceTree", function (data) {
            tree = $.fn.zTree.init($("#tree"), setting, data);
            tree.expandAll(true);
        });
        tableResource = $("#tableResource").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/resourcePublic/getResourcePublicList',
            },
            "destroy": true,
            "columns": [
                {"data": "resourceId", "visible": false},
                {"data": "resourceSubjectId", "visible": false},
                {"data": "resourceMajorId", "visible": false},
                {"data": "resourceCourseId", "visible": false},
                {"data": "resourceName", "title": "资源名称"},
                {"data": "resourceType", "title": "资源类型"}, /* 使用ZYK_ZYLX字典 */
                {"data": "resourceSubjectIdShow", "title": "学科"},
                {"data": "resourceMajorIdShow", "title": "专业"},
                {"data": "resourceCourseIdShow", "title": "课程"},
                {"data": "resourceFormat", "title": "资源格式"}, /* 使用ZYK_ZYGS字典 */
                {"data": "publicFlag", "title": "公共资源", "visible": false},
                {"data": "classicFlag", "title": "精品课", "visible": false},
                {"data": "publicPersonIdShow", "title": "提供人"},
                {"data": "publicTime", "title": "公开时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {

                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.resourceId + '")></span>&ensp;&ensp;' +

                            '<span class="icon-trash" title="删除" onclick=del("' + row.resourceId + '","' + row.resourceName + '")></span>';
                    }
                }
            ],
            'order': [10, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    })
    /*$.get("/common/getTableDict", {
        id: " RESOURCE_SUBJECT_ID ",
        text: " RESOURCE_SUBJECT_NAME ",
        tableName: " ZYK_TYPE_SUBJECT ",
        where: " ",
        orderby: " order by LPAD(resource_SUBJECT_order,5,'0')"
    }, function (data) {
        addOption(data, "SubjectIdSel");
    })*/

    /*$("#SubjectIdSel").blur(function () {
        if ($("#SubjectIdSel").val() != "") {
            $.get("/common/getTableDict", {
                    id: " resource_major_id ",
                    text: " resource_major_name ",
                    tableName: " ZYK_TYPE_MAJOR ",
                    where: " where RESOURCE_SUBJECT_ID='" + $("#SubjectIdSel").val() + "'",
                    orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
                },
                function (data) {
                    addOption(data, "majorIdSel");
                })
        }
    });
    $("#majorIdSel").blur(function () {
        /!*    RESOURCE_MAJOR_ID     RESOURCE_SUBJECT_ID   *!/
        if ($("#majorIdSel").val() != "") {
            $.get("/common/getTableDict", {
                    id: " RESOURCE_COURSE_ID ",
                    text: " RESOURCE_COURSE_NAME ",
                    tableName: " ZYK_TYPE_COURSE ",
                    where: " where RESOURCE_SUBJECT_ID='" + $("#majorIdSel").val() + "'",
                    orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
                },
                function (data) {
                    addOption(data, "CourseIdSel");
                })
        }
    });*/

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePublic/toResourcePublicAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/resourcePublic/toResourcePublicEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id, resourceName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "资源名称：《" + resourceName + "》  ，   删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/resourcePublic/delResourcePublic", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#tableResource').DataTable().ajax.reload();
            });
        })
    }

    function batchAdd() {
        if ($("#cache").val() == "") {
            swal({
                title: "请选择左侧资源类别！",
                type: "error"
            });
        } else {
            $("#dialog").load("<%=request.getContextPath()%>/resourcePublic/toAddFiles")
            $("#dialog").modal("show")
        }
    }

    function searchclear() {
        $("#resourceNameSel").val("");
        searchResource();
    }
    function upreasources(resourceId) {
        $("#dialog").load("<%=request.getContextPath()%>/resourceLibrary/JPK/setJPKResourceSkip" +
            "?resourceId=" + resourceId);
        $("#dialog").modal("show")
    }
    function searchResource() {
        var SubjectId = $("#SubjectIdSel").val();
        var majorId = $("#majorIdSel").val();
        var CourseId = $("#CourseIdSel").val();
        var resourceName = $("#resourceNameSel").val();
        tableResource.ajax.url("<%=request.getContextPath()%>/resourcePublic/getResourcePublicList?resourceSubjectId=" + SubjectId +
            "&resourceMajorId=" + majorId + "&resourceCourseId=" + CourseId + "&resourceName=" + resourceName).load();
    }


</script>
<style>
    #style-4::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar {
        width: 5px;
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar-thumb {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }
</style>
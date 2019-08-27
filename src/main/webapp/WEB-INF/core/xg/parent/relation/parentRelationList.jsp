<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">家长&nbsp;${parentName}&nbsp;关联的学生</span>
            <input id="pId" hidden value="${parentId}"/>
            <input id="pName" hidden value="${parentName}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="form-row">
                <button type="button" class="btn btn-default btn-clean"
                        onclick="addRelationList()">新增关联学生
                </button>
            </div>
            <div class="form-row block" style="overflow-y:auto;">
                <table id="tableRelationList" cellpadding="0" cellspacing="0"
                       width="100%" style="max-height: 50%;min-height: 10%;"
                       class="table table-bordered table-striped sortable_default">
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    var tableRelationList;
    $(document).ready(function () {
        tableRelationList = $("#tableRelationList").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/core/parent/getStudentParentRelationList?parentId='+$("#pId").val(),
            },
            "destroy": true,
            "columns": [
                {"data":"id","visible": false},
                {"data":"parentId","visible": false},
                {"data":"studentId","visible": false},
                {"data":"parentName","visible": false},
                {"data":"studentName","title":"学生姓名"},
                {"data":"relationShow","title":"关系"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return  '<span class="icon-trash" title="删除" onclick=delRelation("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    });

    function addRelationList() {
        $("#dialogFile").load("<%=request.getContextPath()%>/core/parent/toStudentRelationAdd?parentId="+$("#pId").val()+"&parentName="+$("#pName").val());
        $("#dialogFile").modal("show")
    }

    function delRelation(id) {
        swal({
            title: "您确定要删除本条关系?",
            text: "",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/core/parent/delStudentParentRelation?id=" + id, function (msg) {
                swal({title: msg.msg,type: msg.result});
                if (msg.status == 1) {
                    $('#tableRelationList').DataTable().ajax.reload();
                }
            })
        });
    }

</script>




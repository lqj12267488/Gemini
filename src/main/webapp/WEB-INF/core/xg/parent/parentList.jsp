<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            家长姓名
                        </div>
                        <div class="col-md-2">
                            <input id="nameSel" />
                        </div>
                        <div class="col-md-2 tar">
                            家长身份证号
                        </div>
                        <div class="col-md-2">
                            <input id="idcardSel" placeholder="末位字母请大写"/>
                        </div>
                        <div class="col-md-3 tar">
                            <button type="button" class="btn btn-default btn-clean pull-right"
                                    onclick="searchclear()">清空
                            </button>

                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>

                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <button class="btn btn-default btn-clean" onclick="openImportDialog()">导入</button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="parentTable" cellpadding="0" cellspacing="0"
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
    var parentTable;
    $(document).ready(function () {
        parentTable = $("#parentTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/core/parent/getParentList',
            },
            "destroy": true,
            "columns": [
                {"data":"parentId","visible": false},
                {"data":"parentName","title":"家长姓名"},
                {"data":"idcard","title":"身份证号"},
                {"data":"parentTel","title":"电话"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.parentId + '")></span>&ensp;&ensp;' +
                            '<span class="icon-repeat" title="初始化密码" onclick="getRepeatPwd(\'' + row.parentId + '\',\'' + row.parentName + '\')"></span>&ensp;&ensp;' +
                            '<span class="icon-tags" title="关联学生" onclick=getRelation("' + row.parentId + '","' + row.parentName + '")></span>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.parentId + '","' + row.parentName + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/core/parent/toParentAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/core/parent/toParentEdit?id=" + id)
        $("#dialog").modal("show");
    }

    function getRelation(parentId,parentName) {
        $("#dialog").load("<%=request.getContextPath()%>/core/parent/toParentRelationList?parentId="+parentId+"&parentName="+parentName);
        $("#dialog").modal("show");
    }

    function getRepeatPwd(parentId,parentName) {
        swal({
            title: "您确定要初始化家长：" + parentName + "的密码?",
            //text: "用户名："+data.name+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/saveLoginPwd?", {
                personId: parentId,
                password: '123456'
            }, function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: "密码初始化成功",
                        type: "success"
                    });
                }
            })
        })
    }

    function del(id,parentName) {
        swal({
            title: "您确定要删除本条信息?",
            text: " 家长" + parentName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/core/parent/delParent?id=" + id, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg,type: "success"});
                    $('#parentTable').DataTable().ajax.reload();
                }
            })
        });
    }

    function openImportDialog() {
        $("#dialog").load("<%=request.getContextPath()%>/core/parent/toOpenImportDialog");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#nameSel").val("");
        $("#idcardSel").val("");
        search();
    }

    function search() {
        var nameSel = $("#nameSel").val();
        var idcardSel = $("#idcardSel").val();

        parentTable.ajax.url("<%=request.getContextPath()%>/core/parent/getParentList" +
            "?parentName="+nameSel+"&idcard="+idcardSel ).load();
    }

</script>
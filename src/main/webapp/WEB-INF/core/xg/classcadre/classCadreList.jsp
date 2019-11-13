<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="block block-drop-shadow">
                <div class="content controls" id="style-4" style="overflow-y:auto;height: 85%">
                    <ul id="majorClassTree" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div id="studentList" class="col-md-9">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <h3 class="modal-title" id="titleV"></h3>
                    <br/>
                    <div class="form-row">
                        <button id="addButton" style="display: none" type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="classCadreTable" cellpadding="0" cellspacing="0"
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
    var classCadreTable;
    var checkedNote ;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/student/getMajorClassTreeByLevel?level=1,2,3,4,5,6", function (data) {
            majorClassTree = $.fn.zTree.init($("#majorClassTree"), setting, data);
            majorClassTree.expandAll(true);
        })

        classCadreTable = $("#classCadreTable").DataTable({
/*
            "ajax": {
                "type": "post",
                "url": '< %=request.getContextPath()%>/classCadre/getClassCadreList',
            },
*/
            "destroy": true,
            "columns": [
                {"data":"id","visible": false},
                {"data":"classId","visible": false},
                {"data":"cadrecoad","visible": false},
                {"data":"className","title":"班级"},
                {"data":"studentName","title":"学生"},
                {"data":"cadrecoadShow","title":"职位"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/classCadre/toClassCadreAdd"
                                +"?className="+checkedNote.name+"&classId="+checkedNote.id);
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
            $.get("<%=request.getContextPath()%>/classCadre/delClassCadre?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#classCadreTable').DataTable().ajax.reload();
                });
            })
        });
    }

    var majorClassTree;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view: {
            fontCss: {color: "white"},
            showLine: false
        },
        data: {
            simpleData: {
                enable: true,
                rootPId:'0'
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    function zTreeOnClick(event, treeId, treeNode) {
        $.get("<%=request.getContextPath()%>/classCadre/checkClass?classId=" + treeNode.id, function (msg) {
            if(msg.status == 0 || msg.status == '0'){
                swal({title: msg.msg, type: "error" });
            }else{
                classCadreTable.ajax.url("<%=request.getContextPath()%>/classCadre/getClassCadreList" +
                    "?classId="+treeNode.id ).load();
                checkedNote = treeNode;
                $("#addButton").css("display","block");
                $("#titleV").html(treeNode.name+" 班级干部列表");
            }
        })
    }

</script>
<style>
    #style-4::-webkit-scrollbar-track
    {
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        background-color: #474D52;
    }
    #style-4::-webkit-scrollbar
    {
        width: 5px;
        background-color: #474D52;
    }
    #style-4::-webkit-scrollbar-thumb
    {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }
</style>
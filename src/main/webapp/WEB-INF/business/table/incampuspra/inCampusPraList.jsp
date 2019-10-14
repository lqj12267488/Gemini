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
                            实践基地名称：
                        </div>
                        <div class="col-md-2">
                            <input id="praNameSel">
                        </div>
                        <div class="col-md-1 tar">
                            主要专业：
                        </div>
                        <div class="col-md-2">
                            <input id="parMajorSel">
                        </div>
                <div class="col-md-2 tar">
                    <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                    <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                </div>
            </div>
            </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
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
<script>
    $(document).ready(function () {


        search();
    })

    function search() {
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/InCampusPra/getInCampusPraList',
                "data": {
                    praName: $("#praNameSel").val(),
                    parMajor: $("#parMajorSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "praName", "title": "实践基地名称"},
                 {"data": "parMajor", "title": "主要专业"},
                 {"data": "parTotal", "title": "总数"},
                 {"data": "parSupDept", "title": "支持部门"},
                 {"data": "parSupTime", "title": "批准日期"},
                 {"data": "parArea", "title": "建筑面积"},
                 {"data": "parDevAllvalue", "title": "设备总值"},
                 {"data": "parDevNewvalue", "title": "当年新增设备值"},
                 {"data": "selfDevValue", "title": "自主研制设备值"},
                 {"data": "ssDevValue", "title": "社会捐赠设备值"},
                 {"data": "sswDevValue", "title": "社会准捐赠设备值"},
                 {"data": "devNum", "title": "设备总数"},
                 {"data": "devBigNum", "title": "大型设备数"},
                 {"data": "parProNum", "title": "实训项目总数"},
                 {"data": "mainParPro", "title": "主要项目名称"},
                 {"data": "schUseFre", "title": "学年使用频率（人时）校内"},
                 {"data": "ssUseFre", "title": "学年使用频率（人时）社会"},
                 {"data": "workNum", "title": "工位数"},
                 {"data": "materCost", "title": "原材料（耗材）费用（万元）"},
                 {"data": "devMaintCost", "title": "设备维护费用"},
                 {"data": "mgeNum", "title": "专职管理人员（名）"},
                 {"data": "partMgeNum", "title": "兼职管理人员（名）"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            paging: true,
            language: language
        });
    }

    function searchClear() {
        $(".form-row div input,.form-row div select").val("");
        search();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/InCampusPra/toInCampusPraAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/InCampusPra/toInCampusPraEdit?id=" + id)
        $("#dialog").modal("show")
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
            $.get("<%=request.getContextPath()%>/InCampusPra/delInCampusPra?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
</script>
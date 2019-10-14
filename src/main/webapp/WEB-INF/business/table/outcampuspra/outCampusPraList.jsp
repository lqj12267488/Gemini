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
                           基地名称：
                       </div>
                       <div class="col-md-2">
                           <input id="opraNameSel">
                       </div>
                        <div class="col-md-1 tar">
                            依托单位名称：
                        </div>
                        <div class="col-md-2">
                            <input id="opraUnitSel">
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
                "url": '<%=request.getContextPath()%>/OutCampusPra/getOutCampusPraList',
                "data": {
                    opraName: $("#opraNameSel").val(),
                    opraUnit: $("#opraUnitSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "opraUnit", "title": "依托单位	名称"},
                 {"data": "opraEmpNum", "title": "在岗职工总数"},
                 {"data": "buildTime", "title": "建立日期"},
                 {"data": "opraMajorNum", "title": "面向专业总数"},
                 {"data": "mainOpraMajor", "title": "主要专业"},
                 {"data": "opraProNum", "title": "实习实训项目	总数"},
                 {"data": "opraProName", "title": "主要项目(全称)"},
                 {"data": "opraStdNum", "title": "接待学生量（人次）"},
                 {"data": "baseUseDay", "title": "基地使用天数"},
                 {"data": "internNum", "title": "接收半年顶岗实习学生树"},
                 {"data": "sfDorm", "title": "是否有住宿条件"},
                 {"data": "sfSub", "title": "基地是否方法学生实习补贴"},
                 {"data": "itnCost", "title": "学校向基地支付专项实习经费（元/生）"},
                 {"data": "sendMge", "title": "学校派指导教师/学生管理人员(人次)"},
                 {"data": "accGrad", "title": "接收应届毕业生就业数"},
                 {"data": "opraName", "title": "基地名称"},
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
        $("#dialog").load("<%=request.getContextPath()%>/OutCampusPra/toOutCampusPraAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/OutCampusPra/toOutCampusPraEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/OutCampusPra/delOutCampusPra?id=" + id, function (msg) {
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
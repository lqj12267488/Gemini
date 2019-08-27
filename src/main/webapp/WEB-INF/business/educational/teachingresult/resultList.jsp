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
                                成果对象：
                            </div>
                            <div class="col-md-2">
                                <select id="s_resultObject" class="validate[required,maxSize[100]] form-control" onchange="autoComplete()"></select>
                            </div>
                            <div class="col-md-1 tar">
                                成果所有人：
                            </div>
                            <div class="col-md-2">
                                <input id="s_resultPersonId" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                成果类别：
                            </div>
                            <div class="col-md-2">
                                <select id="s_resultType" class="validate[required,maxSize[100]] form-control"></select>
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
                                onclick="addTeachingResult()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="resultGrid" cellpadding="0" cellspacing="0"
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
    var resultTable;
    var headT;
    var headTList;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=CGDX", function (data) {
            addOption(data, 's_resultObject');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYCGLB", function (data) {
            addOption(data, 's_resultType');
        });
        /*$.get("/common/getPersonDept", function (data) {
            $("#s_resultPersonId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_resultPersonId").val(ui.item.label);
                    $("#s_resultPersonId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })*/
        search();

        resultTable.on('click', 'tr a', function () {
            var data = resultTable.row($(this).parent()).data();
            var id = data.id;
            var resultPersonId = daya.resultPersonId;
            if (this.id == "addResult") {
                $("#dialog").load("<%=request.getContextPath()%>/teacherResult/addTeachingResult?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delResult") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "成果所有人：" + resultPersonId + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/teacherResult/deleteTeachingResultById", {
                        id: id
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#resultGrid').DataTable().ajax.reload();
                        }
                    });
                })
            }
        });
    })
    function autoComplete(){
        if($("#t_resultObject option:selected").val() =='1'){
            $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
                $("#t_resultPersonId").autocomplete({
                    source: data,
                    select: function (event, ui) {
                        $("#t_resultPersonId").val(ui.item.label);
                        $("#t_resultPersonId").attr("keycode", ui.item.value);
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li>")
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
                };
            })
        }else{
            $.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
                $("#t_resultPersonId").autocomplete({
                    source: data,
                    select: function (event, ui) {
                        $("#t_resultPersonId").val(ui.item.label);
                        $("#t_resultPersonId").attr("keycode", ui.item.value);
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li>")
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
                };
            })
        }
    }

    function addTeachingResult() {
        $("#dialog").load("<%=request.getContextPath()%>/teacherResult/addTeachingResult");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#s_resultPersonId").val("");
        $("#s_resultObject").val("");
        $("#s_resultType").val("");

        search();
    }

    function uploadFiles() {
        alert(00);
    }

    function search() {
        var t_resultPersonId = $("#s_resultPersonId").val();
        var t_resultObject = $("#s_resultObject option:selected").val();
        var t_resultType = $("#s_resultType option:selected").val();
        headT = $("#s_resultPersonId").attr("keycode");
        headTList = headT.split(",");
        alert(headTList[1]);
        resultTable = $("#resultGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teacherResult/getResultList',
                "data": {
                    resultPersonId: headTList[1],
                    resultObject:  t_resultObject,
                    resultType: t_resultType
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "10%", "data": "resultObject", "title": "成果对象"},
                {"width": "10%", "data": "resultPersonId", "title": "成果所有人"},
                {"width": "10%", "data": "resultPersonDeptId", "title": "成果所有人所在部门"},
                {"width": "10%", "data": "resultType", "title": "成果类别"},
                {"width": "10%", "data": "resultLevel", "title": "成果级别"},
                {"width": "10%", "data": "resultTime", "title": "成果获得时间"},
                {"width": "10%", "data": "remark", "title": "备注"},
                {"width": "10%", "data": "files", "title": "是否包含附件"},
                {
                    "width": "10%",
                    "title": "附件",
                    "render": function () {
                        return "<button style='text-align:center' type='button' id='upload' onclick='uploadFiles()'>上传附件</button>";
                    }
                },
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='addResult' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delResult' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
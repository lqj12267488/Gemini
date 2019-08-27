<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/3
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="../../../../../libs/css/qtip/jquery.qtip.min.css">
<script type="text/javascript" src="../../../../../libs/js/plugins/qtip/jquery.qtip.min.js"></script>
<script type="text/javascript" src = "../../../../../libs/js/plugins/qtip/imagesloaded.pkgd.js"></script>
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow"><%--出现底部阴影--%>
                    <div class="content block-fill-white"><%--文本框变白--%>
                        <div class="form-row">
                            <div class="col-md-1 tar"><%--文本框变小--%>
                                <h3>morning</h3>
                            </div>
                            <div class="col-md-2">
                                <input id="screenUseText" type="text"
                                       class="validate[required,maxSize[20]] form-control" />
                            </div>
                            <div class="col-md-1 tar"><%--文本框变小--%>
                                申请日期:
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[20]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <%--class="btn btn-default btn-clean"这个是按钮的一个样式--%>
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content"><%--出现底部阴影--%>
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addScreenUse()">新增</button>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="screenUseGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--将tabIndex赋值为-1，则在使用[Tab]键时，此元素被忽略。--%>
    <%--role再强调一下这是个dialog--%>
    <%--aria-labelledby属性    当想要的标签文本已在其他元素中存在时，可以将其值为该元素的id。--%>
</div>
<input id="tableName" hidden value="T_BG_SCREENUSE_WF">
<input id="businessId" hidden>
<script>
    var screenUseTestTable;

    $(document).ready(function () {
        /*DataTables可以自定义列的属性。*/
        search();
        /*向screenUseTestTable添加click事件处理程序,规定子元素为tr a才有click事件*/
        /*向修改删除添加click事件*/
        screenUseTestTable.on("click", "tr a", function () {
            var data = screenUseTestTable.row($(this).parent()).data();/*row:表格的列*/
            var id = data.id;
            var screenShow = data.screenShow;
            if(this.id=="uScreenUseTest"){
                $("#dialog").load("<%=request.getContextPath()%>/screenUse/getScreenUseById?id=" + id);
                $("#dialog").modal("show");/*modal是Bootstrap里面的一个插件,模态框*/
            }
            if(this.id=="delScreenUseTest"){
                swal({
                    title: "您确定要删除本条信息?",
                    text: "大屏幕："+screenShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/screenUse/deleteScreenUseById?id=" + id, function (msg) {
                        if(msg.status == 1){
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $("#screenUseGrid").DataTable().ajax.reload();
                        }
                    });


                });
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
        });
    });

    function addScreenUse() {
        $("#dialog").load("<%=request.getContextPath()%>/screenUse/editScreenUse");
        $("#dialog").modal("show");
    }
    function searchClear() {
        $("#date").val("");
        search();
    }
    function search() {
        var requestDate = $("#date").val();

        if(requestDate != "")
            requestDate = '%' + requestDate + '%';
        screenUseTestTable = $('#screenUseGrid').DataTable({
            "ajax":{
                "type":"post",
                "url":'<%=request.getContextPath()%>/screenUse/getScreenUseList',
                "data":{
                    requestDate:requestDate

                }
            },
            "destroy":true,
            "columns":[
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "screen", "visible": false},
                {"width": "14%",
                    "render": function(data,type,row,meta){
                        data = row.content;
                        return qtip_td(data,type,row,meta,qtip_num,$('#screenUseGrid tr a'));
                    },"title": "申请内容"
                },
                {"width": "14%","data": "screenShow", "title": "大屏幕"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "10%","data": "usingTime", "title": "使用日期"},
                {"width": "12%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "requester", "title": "经办人"},
                {"width": "14%","render": function(data,type,row,meta){
                    data = row.content;
                    return qtip_td(data,type,row,meta,qtip_num,$('#screenUseGrid tr a'));
                }, "title": "备注"},
                {"width": "16%","title": "操作","render": function () {return
                    "<a id='uScreenUseTest' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delScreenUseTest' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='submit' class='icon-upload-alt' title='提交'></a>";}}
            ],
            'order':[1,'desc'],
            'dom':'rtlip',
            language:language
        });
    }
    function getAuditer() {
        $("#dialog").modal().load("/toSelectAuditer")
    }
    function audit() {
        var personId;
        var handleName;
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == undefined) {
                handleName = $("#personId option:selected").text();
            }
            if (personId == undefined) {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == undefined) {
                handleName = $("#name").val();
            }
            if (personId == undefined) {
                personId = $("#personIds").val();
            }
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_BG_SCREENUSE_WF",
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal("hide");
                    $('#screenUseGrid').DataTable().ajax.reload();
                }
            })
    }
</script>

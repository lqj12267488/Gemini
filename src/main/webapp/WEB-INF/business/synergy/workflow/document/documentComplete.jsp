<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">

                    <div class="content block-fill-white">

                        <div class="form-row">
                            <div class="col-md-1 tar">
                               申请部门：
                            </div>
                            <div class="col-md-2">
                                <input id="f_dept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                拟稿：
                            </div>
                            <div class="col-md-2">
                                <input id="f_requester" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>

                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="f_date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="documentGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var roleTable;
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/document/autoCompleteDept", function (data) {
            $("#f_dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_dept").val(ui.item.label);
                    $("#f_dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/document/autoCompleteEmployee", function (data) {
            $("#f_requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_requester").val(ui.item.label);
                    $("#f_requester").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        search();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var documentProcessId = data.id;
            var requestFlag = data.requestFlag;
            //查看流程轨迹
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: documentProcessId,
                    tableName: "T_BG_DOCUMENT_WF",
                    url: "<%=request.getContextPath()%>/document/auditDocumentById?id=" + documentProcessId,
                    backUrl: "/document/complete",
                    requestFlag:requestFlag,
                });
            }
            if(this.id == "updateSymbol"){
                $.get("<%=request.getContextPath()%>/document/checkRequestFlagById?id=" + documentProcessId, function (msg) {
                    if (msg.status == 1) {
                        $("#dialog").load("<%=request.getContextPath()%>/document/getDocumentSymbolById?id=" + documentProcessId);
                        $("#dialog").modal("show");
                    }else{
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                        $('#documentGrid').DataTable().ajax.reload();
                    }
                })
            }
            //反馈
            if (this.id == "feedbackReport") {
                var data = roleTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_DOCUMENT_WF",
                        businessId: documentProcessId,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: documentProcessId,
                                tableName: "T_BG_DOCUMENT_WF",
                                backUrl: "/document/complete"
                            });
                        }
                    })

                }else{
                    swal({
                        title: "本申请已经完成反馈！",
                        type: "error"
                    });
                }


            }

        });
    });

    function searchclear() {
        $("#f_dept").val("");
        $("#f_requester").val("");
        $("#f_date").val("");
        search();
    }

    function search() {
        var dept = $("#f_dept").val();
        if (dept != "")
            dept = '%' + dept + '%';
        var jbr = $("#f_requester").val();
        if (jbr != "")
            jbr = '%' + jbr + '%';
        var date = $("#f_date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        roleTable = $("#documentGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '/document/getCompleteList',
                "data": {
                    requester: jbr,
                    requestDate: date,
                    requestDept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "7%","data": "requestDept", "title": "申请部门"},
                {"width": "7%","data": "requestDate", "title": "申请日期"},
                {"width": "7%","data": "requester", "title": "拟稿"},
                {"width": "7%","data": "fileTitle", "title": "文件标题"},
                {"width": "7%","data": "deliveryEmpIdShow", "title": "主送"},
                {"width": "7%","data": "makeEmpIdShow", "title": "抄送"},
                {"width": "7%","data": "secretClass", "title": "密级"},
                /*{"width": "7%","data": "title", "title": "标题"},*/
                {"width": "7%","data": "printingNumber", "title": "打印份数"},
                {"width": "7%","data": "symbol", "title": "文号"},
                {"width": "8%","data": "requestFlag", "title": "请求状态"},
                {"width": "8%","data": "feedbackFlag", "title": "反馈状态"},
                {"width": "8%","data": "feedback", "title": "反馈意见"},
                {"width": "6%", "title": "操作", "render": function () {return "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='feedbackReport' class='icon-comments' title='反馈'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='updateSymbol' class='icon-edit' title='发布'></a>";}},

            ],
            'order' : [7,'desc'],
            "dom": 'rtlip',
            language: language
        });

    }
</script>


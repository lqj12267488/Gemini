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
                                <input id="dept" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                经办人：
                            </div>
                            <div class="col-md-2">
                                <input id="jbr" />

                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
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
                        <table id="stampGrid" cellpadding="0" cellspacing="0" width="100%"
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

        $.get("<%=request.getContextPath()%>/stamp/autoCompleteDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#jbr").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#jbr").val(ui.item.label);
                    $("#jbr").attr("keycode", ui.item.value);
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
            var stampProcessId = data.id;
            //查看流程轨迹
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: stampProcessId,
                    tableName: "T_BG_STAMP_WF",
                    url: "<%=request.getContextPath()%>/stamp/auditStampById?id=" + stampProcessId,
                    backUrl: "/stamp/complete"
                });
             }
             //反馈
            if (this.id == "feedbackReport") {
                var data = roleTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_STAMP_WF",
                        businessId: stampProcessId,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: stampProcessId,
                                tableName: "T_BG_STAMP_WF",
                                backUrl: "/stamp/complete"
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
        $("#dept").val("");
        $("#jbr").val("");
        $("#date").val("");
        search();
    }

    function search() {
        var dept = $("#dept").val();
        if (dept != "")
            dept = '%' + dept + '%';
        var jbr = $("#jbr").val();
        if (jbr != "")
            jbr = '%' + jbr + '%';
        var date = $("#date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        roleTable = $("#stampGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/stamp/getCompleteList',
                "data": {
                    manager: jbr,
                    requestDate: date,
                    requestDept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "9%","data": "stampFlag", "title": "印章类型"},
                {"width": "12%","data": "contractDetails", "title": "合同内容(用途)"},
                {"width": "9%","data": "requestDept", "title": "申请部门"},
                {"width": "9%","data": "manager", "title": "经办人"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "10%","data": "remark", "title": "备注"},
                {"width": "11%","data": "requestFlag", "title": "请求状态"},
                {"width": "11%","data": "feedbackFlag", "title": "反馈状态"},
                {"width": "11%","data": "feedBack", "title": "反馈意见"},
                {"width": "8%", "title": "操作", "render": function () {return  "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='feedbackReport' class='icon-comments' title='反馈'></a>"
                        /*     "<a id='addRelation' class='icon-sitemap' title='授权人员'></a>&nbsp;&nbsp;&nbsp;"+
                         "<a id='addRelationMenu' class='icon-cogs'  title='添加菜单'></a>";*/;}},

            ],
            'order' : [1,'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });

    }
</script>

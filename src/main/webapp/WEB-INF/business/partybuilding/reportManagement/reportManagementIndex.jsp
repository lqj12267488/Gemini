<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/6 0006
  Time: 上午 10:53
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
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="e_requestDate" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申诉类型：
                            </div>
                            <div class="col-md-2">
                                <select id="e_reportType"/>
                            </div>
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="s_nameSel" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addLoan()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="crTable" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_DT_REPORT_MANAGEMENT">
<input id="workflowCode" hidden value="T_DT_REPORT_MANAGEMENT01">
<input id="businessId" hidden>
<script>
    var crTable;

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getPersonDeptAndClass", function (data) {
            $("#s_nameSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_nameSel").val(ui.item.label);
                    $("#s_nameSel").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SSLX", function (data) {
            addOption(data,'e_reportType');
        });
        search();
        crTable.on('click', 'tr a', function () {
            var data = crTable.row($(this).parent()).data();
            var id = data.id;
            var tableName=$("#tableName").val();
            var reportTypeShow = data.reportTypeShow;

            if (this.id == "editLoan") {
                $("#dialog").load("<%=request.getContextPath()%>/reportManagement/editReportManagement?id=" + id);
                $("#dialog").modal("show");
            }

            if (this.id == "delLoan") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "申请内容："+data.reportContent+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/reportManagement/deleteReportManagementById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#crTable').DataTable().ajax.reload();
                        }
                    })
                })
            }

            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer(reportTypeShow);

            }
            if (this.id=="preview") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + id + "&role=leader");
                $("#dialog").modal("show");
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_DT_REPORT_MANAGEMENT');
                $('#dialogFile').modal('show');
            }
        });
    })



    function addLoan() {
        $("#dialog").load("<%=request.getContextPath()%>/reportManagement/editReportManagement");
        $("#dialog").modal("show");
    }

    function getAuditer(reportTypeShow) {
        if (reportTypeShow == '学生申诉' || reportTypeShow== undefined || reportTypeShow== null){
            $("#workflowCode").val("T_DT_REPORT_MANAGEMENT01");
        } else if(reportTypeShow == '教师申诉' || reportTypeShow== undefined || reportTypeShow== null){
            $("#workflowCode").val("T_DT_REPORT_MANAGEMENT02");
        }else if (reportTypeShow == '干部申诉' || reportTypeShow== undefined || reportTypeShow== null){
            $("#workflowCode").val("T_DT_REPORT_MANAGEMENT03");
        }else{
            $("#workflowCode").val("T_DT_REPORT_MANAGEMENT04");
        }

        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
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
        if (personId == '') {
            swal({title: '请选择人员！',type: "warning"});
            return;
        }
        $("#saveBtn").attr("disabled",true);
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_DT_REPORT_MANAGEMENT",
                workflowCode: $("#workflowCode").val(),
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
                    $('#crTable').DataTable().ajax.reload();
                }
            })
    }
    function searchClear() {
        $("#e_requestDate").val("");
        $("#e_reportType").val("");
        $("#s_nameSel").val("");
        $("#s_nameSel").removeAttr("keycode");
        search()
    }
    function search() {
        var headT = $("#s_nameSel").attr("keycode");
        var person = "";
          if (null == headT){
          } else{
              var personList = headT.split(",");
              person = personList[1];
              var dept = personList[0];
          }
        crTable = $("#crTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/reportManagement/getReportManagementList',
                "data": {
                    requestDate: $("#e_requestDate").val(),
                    reportType: $("#e_reportType").val(),
                    manager: person
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "18%", "data": "manager", "title": "姓名"},
                {"width": "18%", "data": "requestDept", "title": "部门/班级"},
                {"width": "18%", "data": "requestDate", "title": "申请日期"},
                {"width": "18%", "data": "reportContent", "title": "申请内容"},
                {"data": "reportTypeShow", "title": "申诉类型"},
                {
                    "width": "18%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='editLoan' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delLoan' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='preview' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

</script>


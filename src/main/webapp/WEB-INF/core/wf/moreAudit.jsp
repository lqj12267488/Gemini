<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog" style="width: 1200px" id="index">
    <div class="row">
        <div class="col-md-12">
            <div>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="">
                        &times;
                    </button>
                    <h4 class="modal-title">查看工作流业务</h4>
                </div>
                <div class="modal-body clearfix">
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active"><a href="#tab10" data-toggle="tab">待办事项</a></li>
                        <li><a href="#tab11" data-toggle="tab">已办事项</a></li>
                    </ul>
                    <div class="content tab-content">
                        <div class="tab-pane active" id="tab10">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="unRead" cellpadding="0" cellspacing="0" width="100%"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab11">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="readed" cellpadding="0" cellspacing="0" width="100%"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var unRead;
    var readed;
    $(document).ready(function () {
        unRead = $("#unRead").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/getMoreUnAuditList"
            },
            "destroy": true,
            "columns": [
                {"data": "businessId", "visible": false},
                {"data": "abc", "visible": false},
                {"data": "url", "visible": false},
                {"data": "editUrl", "visible": false},
                {"data": "state", "visible": false},
                {"data": "tableName", "visible": false},
                {"width": "80%", "data": "workflowName", "title": "业务名称"},
                {"width": "12%", "data": "createTime", "title": "创建时间"},
                {
                    "width": "8%", "title": "操作", "render": function () {
                    return "<a id='detail' class='icon-edit' title='办理'></a>";
                }
                }
            ],
            'order': [[3, 'desc']],
            "dom": 'rtlip',
            "language": language
        });

        readed = $("#readed").DataTable({
            "ajax": {
                "url": "<%=request.getContextPath()%>/getMoreAuditList"
            },
            "destroy": true,
            "columns": [
                {"data": "businessId", "visible": false},
                {"data": "abc", "visible": false},
                {"data": "url", "visible": false},
                {"data": "editUrl", "visible": false},
                {"data": "state", "visible": false},
                {"data": "tableName", "visible": false},
                {"width": "80%", "data": "workflowName", "title": "业务名称"},
                {"width": "12%", "data": "createTime", "title": "创建时间"},
                {
                    "width": "8%", "title": "操作", "render": function () {
                    return "<a id='detail' class='icon-search' title='查看'></a>";
                }
                }
            ],
            'order': [3, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        unRead.on('click', 'tr a', function () {
            var data = unRead.row($(this).parent()).data();
            var id = data.id;
            loadAuditIndex(data.url, data.tableName, data.businessId, '1', data.abc, data.state, data.editUrl);
            //$("#dialogFile").modal("show");

        });
        readed.on('click', 'tr a', function () {
            var data = readed.row($(this).parent()).data();
            var id = data.id;
            loadAuditIndex(data.url, data.tableName, data.businessId, '1', data.abc, data.state, data.editUrl);
            //$("#dialogFile").modal("show");
        });

    })

    function loadAuditIndex(url, tableName, businessId, flag, abc, state, editUrl) {
        if (state == "3") {
            var url = editUrl + "?id=" + businessId;
            $.post("<%=request.getContextPath()%>/toEditBusinessForMore", {
                businessId: businessId,
                tableName: tableName,
                url: '<%=request.getContextPath()%>' + url,
                backUrl: "0"
            }, function (html) {
                var s = "<div class=\"modal-dialog\">\n" +
                    "        <div class=\"modal-content\">\n" +
                    "            <div class=\"modal-header\">\n" +
                    "                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                    "                    &times;\n" +
                    "                </button>\n" +
                    "                <h3 class=\"modal-title\">修改</h3>\n" +
                    "            </div>\n" +
                    "            <div id=\"editBuis\" class=\"modal-body clearfix\">";
                var e = "        <div class=\"modal-footer\">\n" +
                    "                <button type=\"button\" class=\"btn btn-default btn-clean\" data-dismiss=\"modal\">关闭\n" +
                    "                </button>\n" +
                    "            </div>\n" +
                    "        </div>\n" +
                    "    </div>"
                    $("#dialogFile").html(s + html + e);
            })
        } else {
            var url = url + "?id=" + businessId;
            if (abc == '1') {
                $.get("<%=request.getContextPath()%>/getTask?id=" + businessId, function (data) {
                    $("#dialogFile").load("<%=request.getContextPath()%>/getIndexWorkflowLog", {
                        url: data.taskUrl,
                        tableName: data.taskTable,
                        businessId: data.taskBusinessId,
                        taskId: businessId
                    })
                })
            } else {
                if (tableName == "T_SYS_TASK") {
                    $("#dialogFile").load("<%=request.getContextPath()%>/training/searchTrainAudit", {
                        businessId: businessId,
                    })
                } else {
                    $("#dialogFile").load("<%=request.getContextPath()%>/toIndexMoreAudit", {
                        url: url,
                        tableName: tableName,
                        businessId: businessId,
                        flag: flag
                    })

                }
            }
        }
        $("#dialogFile").modal("show")

    }

</script>



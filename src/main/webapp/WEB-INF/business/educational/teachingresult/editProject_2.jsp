<%--项目(课题)管理编辑
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/24
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeView()">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <form id="validate" method="POST" action="#">
                    <input name="id" id="w_id" hidden value="${project.id}">
                    <input name="flag" id="flag" type="hidden" value="${flag}">
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            姓名：
                        </div>
                        <div class="col-md-10">
                            <input id="w_personId"
                                   class="validate[required,maxSize[20]] form-control"
                                   type="text" value="${project.personId}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            项目名称：
                        </div>
                        <div class="col-md-4">
                            <input name="projectName" id="w_projectName"
                                   class="validate[required,maxSize[20]] form-control"
                                   type="text" value="${project.projectName}">
                        </div>
                        <div class="col-md-2 tar">
                            项目中本人角色：
                        </div>
                        <div class="col-md-4">
                            <select name="projectRole" id="w_projectRole"
                                    class="validate[required] form-control"
                                    class="js-example-basic-single"></select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            项目类型：
                        </div>
                        <div class="col-md-4">
                            <select name="projectType" id="w_projectType"
                                    class="validate[required,maxSize[20]] form-control"
                                    class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-2 tar">
                            学科领域：
                        </div>
                        <div class="col-md-4">
                            <select name="subject" id="w_subject"
                                    class="validate[required,maxSize[20]] form-control"
                                    class="js-example-basic-single"></select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            是否为代表项目：
                        </div>
                        <div class="col-md-4">
                            <select name="typicalFlag" id="w_typicalFlag" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-2 tar">
                            本人排名：
                        </div>
                        <div class="col-md-4">
                            <select name="ranking" id="w_ranking" class="js-example-basic-single"></select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            项目批准号：
                        </div>
                        <div class="col-md-4">
                            <input name="approveNum" id="w_approveNum"
                                   class="validate[required,maxSize[20]] form-control"
                                   type="text" value="${project.approveNum}">
                        </div>
                        <div class="col-md-2 tar">
                            项目经费额度：
                        </div>
                        <div class="col-md-4">
                            <input name="fundsAmount" id="w_fundsAmount"
                                   class="validate[required,custom[number]] form-control"
                                   type="text" value="${project.fundsAmount}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            开始日期：
                        </div>
                        <div class="col-md-4">
                            <input id="w_startDate" name="startDate" type="date" value="${project.startDate}">
                        </div>
                        <div class="col-md-2 tar">
                            结束日期：
                        </div>
                        <div class="col-md-4">
                            <input id="w_endDate" name="endDate" type="date" value="${project.endDate}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            项目来源：
                        </div>
                        <div class="col-md-4">
                            <select name="projectSource" id="w_projectSource"
                                    class="validate[required] form-control"
                                    class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-2 tar">
                            项目委托单位：
                        </div>
                        <div class="col-md-4">
                            <input name="projectClient" id="w_projectClient"
                                   type="text" class="validate[required,maxSize[20]] form-control"
                                   value="${project.projectClient}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            备注
                        </div>
                        <div class="col-md-10">
                        <textarea name="remark" id="w_remark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${project.remark}">${project.remark}</textarea>
                        </div>
                    </div>
                    <div id="file" class="form-row" hidden>
                        <div class="col-md-2 tar">
                            &nbsp;&nbsp;&nbsp;&nbsp;附件：
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="modal-footer">
            <button id="btn" type="button" class="btn btn-success btn-clean" onclick="saveProject()">保存</button>
            <button type="button" onclick="closeView()" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        //项目所有人及所属部门模糊查询下拉选择
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#w_personId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#w_personId").val(ui.item.label);
                    $("#w_personId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SDBXXM", function (data) {
            addOption(data, 'w_typicalFlag', '${project.typicalFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XMLX", function (data) {
            addOption(data, 'w_projectType', '${project.projectType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRJSXM", function (data) {
            addOption(data, 'w_projectRole', '${project.projectRole}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRPM", function (data) {
            addOption(data, 'w_ranking', '${project.ranking}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XKLY", function (data) {
            addOption(data, 'w_subject', '${project.subject}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XMLY", function (data) {
            addOption(data, 'w_projectSource', '${project.projectSource}');
        });
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${project.id}',
        }, function (data) {
            if (data.data.length == 0) {
                $("#file").append('<div class="form-row">' +
                    '<div class="col-md-3 tar"></div>' +
                    '<div class="col-md-9">' +
                    '无' +
                    '</div>' +
                    '</div>')
            } else {
                $.each(data.data, function (i, val) {
                    $("#file").append('<div class="form-row">' +
                        '<div class="col-md-3 tar"></div>' +
                        '<div class="col-md-9">' +
                        '<a href="' + '<%=request.getContextPath()%>' + val.fileUrl + '" target="_blank">' + val.fileName + '</a>' +
                        '</div>' +
                        '</div>');
                })
            }
        })
        var ppid = $("#w_id").val();
        if (ppid != "") {
            $("#w_personId").val("${project.personId}");
            $("#w_personId").attr("keycode", "${project.deptId}");
        }
        if ($("#flag").val() == 'on') {
            $("#btn").hide();
            $("input").attr('readonly', 'readonly');
            $("select").attr('disabled', 'disabled');
            $("textarea").attr('readonly', 'readonly');
            $("#file").removeAttr('hidden');
        }
        $("#validate").validationEngine({
            promptPosition: "topLeft"
        });
    })

    function closeView() {
        $("input").removeAttr('readonly');
        $("select").removeAttr('disabled');
        $("textarea").removeAttr('readonly');
    }

    function saveProject() {
        if (!$("#validate").validationEngine("validate")) {
            return;
        } else {
            var formData = $('#validate').serializeArray();
            var headT = $("#w_personId").attr("keycode");
            var headTList = headT.split(",");
            formData.push({"name": "personId", "value": headTList[1]}, {"name": "deptId", "value": headTList[0]});
            $.post("<%=request.getContextPath()%>/teacherResult/saveTeachingResult/project", formData, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal('hide');
                    $('#projectGrid').DataTable().ajax.reload();
                }
            })
        }
    }
</script>
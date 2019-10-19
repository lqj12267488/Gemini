<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:08
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
                                <select id="d_dept" class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                招聘岗位：
                            </div>
                            <div class="col-md-2">
                                <input id="d_job" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请到岗日期：
                            </div>
                            <div class="col-md-2">
                                <input id="d_date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="d_requester" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                招聘人数：
                            </div>
                            <div class="col-md-2">
                                <input id="d_number" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                招聘原由：
                            </div>
                            <div class="col-md-2">
                                <select id="d_reason"></select>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="talentRecruitmentGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_RS_TALENT_RECRUITMENT_WF">
<input id="workflowCode" hidden value="T_RS_TALENT_RECRUITMENT_WF01">
<input id="businessId" hidden>
<script>
    var talentRecruitmentTable;
    $(document).ready(function () {
        search();
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZPYY", function (data) {
            addOption(data, "d_reason");
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "t_sys_dept"
            },
            function (data) {
                addOption(data, "d_dept");
            });
        $.get("<%=request.getContextPath()%>/talentRecruitment/autoCompleteEmployee", function (data) {
            $("#d_requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#d_requester").val(ui.item.label);
                    $("#d_requester").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        talentRecruitmentTable.on('click', 'tr a', function () {
            var data = talentRecruitmentTable.row($(this).parent()).data();
            var id = data.id;
            var deviceList = data.requester;
            if (this.id == "edittalentRecruitment") {
                $("#dialog").load("<%=request.getContextPath()%>/talentRecruitment/getTalentRecruitmentById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "deltalentRecruitment") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: deviceList + "申请的人才招聘计划\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/talentRecruitment/deleteTalentRecruitmentById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#talentRecruitmentGrid').DataTable().ajax.reload();
                        }
                    })

                });


            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();

            }
            if (this.id == "upload") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_RS_TALENT_RECRUITMENT_WF');
                $('#dialogFile').modal('show');
            }

            if (this.id=="previewSel") {
                $("#dialog").load("<%=request.getContextPath()%>/archives/preview?archivesId=" + id + "&role=leader");
                $("#dialog").modal("show");
            }
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/talentRecruitment/editTalentRecruitment");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#d_dept").val("");
        $("#d_job").val("");
        $("#d_date").val("");
        $("#d_requester").val("");
        $("#d_number").val("");
        $("#d_reason").val("");
        search();
    }

    function search() {
        talentRecruitmentTable = $("#talentRecruitmentGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/talentRecruitment/getTalentRecruitmentList',
                "data": {
                    requestDept: $("#d_dept").val(),
                    recruitmentPosts: $("#d_job").val(),
                    stationDate: $("#d_date").val(),
                    requester: $("#d_requester").val(),
                    recruitment: $("#d_number").val(),
                    recruitmentReason: $("#d_reason").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%", "data": "requestDept", "title": "申请部门"},
                {"width": "12%", "data": "requester", "title": "申请人"},
                {"width": "12%", "data": "recruitmentPosts", "title": "招聘岗位"},
                {"width": "13%", "data": "recruitment", "title": "招聘人数"},
                {"width": "13%", "data": "stationDate", "title": "申请到岗日期"},
                {"width": "13%", "data": "recruitmentReason", "title": "招聘原由"},
                {
                    "width": "12%", "title": "操作", "render": function () {
                        return "<a id='edittalentRecruitment' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='deltalentRecruitment' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='previewSel' class='icon-eye-open' title='查看附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });

    }

    function getAuditer() {
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
            swal({title: '请选择人员！', type: "warning"});
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_RS_TALENT_RECRUITMENT_WF",
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
                    $('#talentRecruitmentGrid').DataTable().ajax.reload();
                }
            })
    }
</script>

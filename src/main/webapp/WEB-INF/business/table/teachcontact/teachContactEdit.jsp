<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-9">
                        <input id="personId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[100]] form-control" value="${data.personIdShow}"/>
                        <input id="personIdEdit" type="hidden" value="${data.personId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>分管工作
                    </div>
                    <div class="col-md-9">
                        <input id="responsibilitiesEdit" value="${data.responsibilities}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>听课（节）
                    </div>
                    <div class="col-md-9">
                        <input id="attendLecturesEdit" value="${data.attendLectures}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>走访学生寝室（次）
                    </div>
                    <div class="col-md-9">
                        <input id="studentDormEdit" value="${data.studentDorm}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>走访校外实习点（次）
                    </div>
                    <div class="col-md-9">
                        <input id="outsidePracticeEdit" value="${data.outsidePractice}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>参与学生社团文体活动（次）
                    </div>
                    <div class="col-md-9">
                        <input id="studentClubActivitiesEdit" value="${data.studentClubActivities}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#personId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#personId").val(ui.item.label.split(" ---- ")[0]);
                    $("#personId").attr("keycode", ui.item.value);
                    $("#personIdEdit").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    });

    function save() {
        if ($("#personIdEdit").val() == "" || $("#personIdEdit").val() == undefined || $("#personIdEdit").val() == null) {
            swal({
                title: "请填写姓名！",
                type: "warning"
            });
            return;
        }
        if ($("#responsibilitiesEdit").val() == "" || $("#responsibilitiesEdit").val() == undefined || $("#responsibilitiesEdit").val() == null) {
            swal({
                title: "请填写分管工作！",
                type: "warning"
            });
            return;
        }
        if ($("#attendLecturesEdit").val() == "" || $("#attendLecturesEdit").val() == undefined || $("#attendLecturesEdit").val() == null) {
            swal({
                title: "请填写听课（节）！",
                type: "warning"
            });
            return;
        }
        if ($("#studentDormEdit").val() == "" || $("#studentDormEdit").val() == undefined || $("#studentDormEdit").val() == null) {
            swal({
                title: "请填写走访学生寝室（次）！",
                type: "warning"
            });
            return;
        }
        if ($("#outsidePracticeEdit").val() == "" || $("#outsidePracticeEdit").val() == undefined || $("#outsidePracticeEdit").val() == null) {
            swal({
                title: "请填写走访校外实习点（次）！",
                type: "warning"
            });
            return;
        }
        if ($("#studentClubActivitiesEdit").val() == "" || $("#studentClubActivitiesEdit").val() == undefined || $("#studentClubActivitiesEdit").val() == null) {
            swal({
                title: "请填写参与学生社团文体活动（次）！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/teachcontact/saveTeachContact", {
            id: "${data.id}",
            personId: $("#personIdEdit").val().split(",")[1],
            responsibilities: $("#responsibilitiesEdit").val(),
            attendLectures: $("#attendLecturesEdit").val(),
            studentDorm: $("#studentDormEdit").val(),
            outsidePractice: $("#outsidePracticeEdit").val(),
            studentClubActivities: $("#studentClubActivitiesEdit").val(),
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>



